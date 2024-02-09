import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Models/wiki_model.dart';
import 'package:flutterpp/App/Services/Project/wiki_services.dart';
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
}
