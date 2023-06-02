// import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:get/get.dart';

class ProjectSingleWikiController extends GetxController {
  // final supabase = Supabase.instance.client;

  // final WikiServices _wikiServices = WikiServices();
  // ProjectIndexController projectController = Get.find();

  // final _editorState = EditorState(
  //   document: markdownToDocument(r'''### 🙌 Hello from Flutter++!'''),
  // ).obs;
  // EditorState get editorState => _editorState.value;

  // final _isNeedToSave = false.obs;
  // bool get isNeedToSave => _isNeedToSave.value;

  // final _focusNode = FocusNode().obs;
  // FocusNode get focusNode => _focusNode.value;

  // final _isLoading = true.obs;
  // bool get isLoading => _isLoading.value;

  // final _isSaving = false.obs;
  // bool get isSaving => _isSaving.value;

  // final _wiki = WikiModel().obs;
  // WikiModel get wiki => _wiki.value;

  // final _isStreaming = false.obs;
  // bool get isStreaming => _isStreaming.value;

  // @override
  // Future<void> onReady() async {
  //   await fetchApi();
  //   super.onReady();
  // }

  // @override
  // Future<void> onClose() async {
  //   await supabase.removeAllChannels();

  //   super.onClose();
  // }

  // void updateEditorState(bool val) {
  //   _isNeedToSave.value = val;
  //   update();
  // }

  // // fetch project wiki
  // Future<void> fetchApi({int? id}) async {
  //   WikiModel? localWiki = await Get.showOverlay(
  //     loadingWidget: const BuildOverlay(),
  //     asyncFunction: () => _wikiServices.getWiki(
  //       projectId: id ?? projectController.activeProject.id!,
  //     ),
  //   );

  //   if (localWiki == null) {
  //     _editorState.value = EditorState(
  //       document: markdownToDocument(r'''### 🙌 Hello from Flutter++!'''),
  //     );

  //     _wiki.value = WikiModel();
  //     update();

  //     return;
  //   }

  //   _editorState.value = EditorState(
  //     document: Document.fromJson(json.decode(localWiki.document!)),
  //   );

  //   _wiki.value = localWiki;
  //   _isLoading.value = false;
  //   update();

  //   // start streaming

  //   // if (_isStreaming.value) {
  //   //   await supabase.removeAllChannels();
  //   // }

  //   // _isStreaming.value = true;
  //   // update();

  //   // supabase
  //   //     .from('wikis')
  //   //     .stream(primaryKey: ['id'])
  //   //     .eq('id', _wiki.value.id)
  //   //     .listen((List data) {
  //   //       print('stream data $data');

  //   //       if (data.isEmpty) return;

  //   //       final localWiki = WikiModel.fromJson(data[0]);

  //   //       _wiki.value = localWiki;

  //   //       _editorState.value = EditorState(
  //   //         document: Document.fromJson(json.decode(localWiki.document!)),
  //   //       );
  //   //       update();
  //   //     });
  // }

  // // create or update project wiki
  // Future<void> createOrUpdateWiki() async {
  //   // print('creating wiki ${_wiki.value.projectId}');

  //   if (wiki.id == null) {
  //     await _createWiki();
  //   } else {
  //     await _updateWiki();
  //   }
  // }

  // // create project wiki
  // _createWiki() async {
  //   _isSaving.value = true;
  //   update();

  //   WikiModel? localWiki = await _wikiServices.createWiki(
  //     projectId: projectController.activeProject.id!,
  //     document: json.encode(_editorState.value.document.toJson()),
  //   );

  //   if (localWiki == null) {
  //     _editorState.value = EditorState(
  //       document: markdownToDocument(r'''### 🙌 Hello from Flutter++!'''),
  //     );

  //     return;
  //   }

  //   _wiki.value = localWiki;
  //   _isSaving.value = false;
  //   update();

  //   updateEditorState(false);
  // }

  // // update project wiki
  // _updateWiki() async {
  //   _isSaving.value = true;
  //   update();

  //   WikiModel? localWiki = await _wikiServices.updateWiki(
  //     wiki: WikiModel(
  //       id: wiki.id,
  //       document: json.encode(_editorState.value.document.toJson()),
  //       updatedAt: DateTime.now().toIso8601String(),
  //     ),
  //   );

  //   _wiki.value = localWiki!;
  //   _isSaving.value = false;
  //   update();

  //   updateEditorState(false);
  // }
}
