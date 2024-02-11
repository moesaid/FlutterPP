import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Models/wiki_model.dart';
import 'package:flutterpp/App/Services/Project/wiki_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:get/get.dart';

class ProjectSingleWikiController extends GetxController {
  final _wikiServices = WikiServices();

  late ProjectSingleController useController;

  final _editorState = EditorState.blank().obs;
  EditorState get editorState => _editorState.value;

  final _editorScrollController =
      EditorScrollController(editorState: EditorState.blank()).obs;
  EditorScrollController get editorScrollController =>
      _editorScrollController.value;

  // loading
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  // wikis
  final _wikis = <WikiModel>[].obs;
  List<WikiModel> get wikis => _wikis;

  // active wiki
  final _activeWiki = WikiModel().obs;
  WikiModel get activeWiki => _activeWiki.value;

  @override
  Future<void> onInit() async {
    await _getController();
    await _getProjectWikis();
    await _initEditor();
    _updateLoading(false);

    super.onInit();
  }

  // get controller
  Future<void> _getController() async {
    if (Get.isRegistered<ProjectSingleController>()) {
      useController = Get.find<ProjectSingleController>();
    }
  }

  // get project wikis
  Future<void> _getProjectWikis() async {
    if (useController.project.id == null) return;

    // get wikis
    List<WikiModel>? items = await _wikiServices.getWikis(
      projectId: useController.project.id!,
    );

    if (items == null || items.isEmpty) return;

    _wikis.assignAll(items);

    _activeWiki.value = items.first;
  }

  // init editor
  _initEditor() {
    if (_activeWiki.value.document == null) return;

    _editorState.value = EditorState(
      document: Document.fromJson(_activeWiki.value.document!),
    );

    _editorScrollController.value = EditorScrollController(
      editorState: _editorState.value,
    );
  }

  // update loading
  void _updateLoading(bool bool) {
    _isLoading.value = bool;
    update();
  }

  // create new page
  Future<void> createNewPage() async {
    if (useController.project.id == null) return;

    await Get.showOverlay(
      asyncFunction: () async {
        WikiModel? item = await _wikiServices.createWiki(
          document: _wikiServices.getDefultDocument,
          projectId: useController.project.id!,
          title: 'untitled',
        );

        if (item == null) return;

        _wikis.add(item);
        _activeWiki.value = item;
        _initEditor();

        update();
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // change active wiki
  void changeActiveWiki(WikiModel item) {
    _activeWiki.value = item;
    _initEditor();
    update();
  }

  // update wiki doc
  Future<void> updateWikiDoc() async {
    if (_activeWiki.value.id == null) return;

    Get.showOverlay(
      asyncFunction: () async {
        WikiModel? local = await _wikiServices.updateWiki(
          wiki: _activeWiki.value.copyWith(
            document: _editorState.value.document.toJson(),
          ),
        );

        if (local == null) return;
        // update wiki in list in the same index
        int index = _wikis.indexWhere((element) => element.id == local.id);
        _wikis[index] = local;
        update();
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // update wiki icon or title
  Future<void> updateWikiIconOrTitle({
    required WikiModel wiki,
    String? title,
    String? icon,
  }) async {
    WikiModel? local = await Get.showOverlay(
      asyncFunction: () async {
        return await _wikiServices.updateWiki(
          wiki: wiki.copyWith(
            title: title ?? wiki.title,
            icon: icon ?? wiki.icon,
          ),
        );
      },
      loadingWidget: const BuildOverlay(),
    );

    if (local == null) return;

    // replace wiki in list in the same index
    int index = _wikis.indexWhere((element) => element.id == local.id);
    _wikis[index] = local;

    update();
  }

  // duplicate wiki
  duplicateWiki(WikiModel wiki) async {
    Get.showOverlay(
      asyncFunction: () async {
        WikiModel? item = await _wikiServices.createWiki(
          icon: wiki.icon,
          projectId: useController.project.id!,
          document: wiki.document ?? _wikiServices.getDefultDocument,
          title: wiki.title != null ? '${wiki.title} (copy)' : 'untitled',
        );

        if (item == null) return;

        _wikis.add(item);
        update();
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // delete wiki
  deleteWiki(WikiModel wiki) {
    Get.showOverlay(
      asyncFunction: () async {
        await _wikiServices.deleteWiki(wikiId: wiki.id!);
        _wikis.removeWhere((element) => element.id == wiki.id);
        update();
      },
      loadingWidget: const BuildOverlay(),
    );
  }
}
