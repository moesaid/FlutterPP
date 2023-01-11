import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/App/Models/wiki_model.dart';
import 'package:flutterpp/App/Services/Wiki/wiki_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectSingleWikiController extends GetxController {
  final supabase = Supabase.instance.client;

  final WikiServices _wikiServices = WikiServices();
  ProjectIndexController projectController = Get.find();

  final _editorState = EditorState(
    document: markdownToDocument(r'''### 🙌 Hello from Flutter++!'''),
  ).obs;
  EditorState get editorState => _editorState.value;

  final _isNeedToSave = false.obs;
  bool get isNeedToSave => _isNeedToSave.value;

  final _focusNode = FocusNode().obs;
  FocusNode get focusNode => _focusNode.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _isSaving = false.obs;
  bool get isSaving => _isSaving.value;

  final _wiki = WikiModel().obs;
  WikiModel get wiki => _wiki.value;

  @override
  Future<void> onReady() async {
    await fetchApi();

    // if (_wiki.value.id == null) return;
    // supabase
    //     .from('wikis')
    //     .stream(primaryKey: ['id'])
    //     .eq('id', 5)
    //     .listen((List data) {
    //       if (data.isEmpty) return;

    //       final localWiki = WikiModel.fromJson(data[0]);

    //       _wiki.value = localWiki;

    //       _editorState.value = EditorState(
    //         document: Document.fromJson(json.decode(localWiki.document!)),
    //       );
    //       update();
    //     });

    super.onReady();
  }

  @override
  Future<void> onClose() async {
    await supabase.removeAllChannels();

    super.onClose();
  }

  void updateEditorState(bool val) {
    _isNeedToSave.value = val;
    update();
  }

  // fetch project wiki
  Future<void> fetchApi({int? id}) async {
    print('fetching wiki');

    WikiModel? localWiki = await Get.showOverlay(
      loadingWidget: const BuildOverlay(),
      asyncFunction: () => _wikiServices.getWiki(
        projectId: id ?? projectController.activeProject.id!,
      ),
    );

    print('from fetch wiki: ${localWiki!.id} , ${localWiki.document}');

    if (localWiki == null) {
      _isLoading.value = false;
      update();
      return;
    }

    _wiki.value = localWiki;
    _isLoading.value = false;
    update();
  }

  // create or update project wiki
  Future<void> createOrUpdateWiki() async {
    if (wiki.id == null) {
      await _createWiki();
    } else {
      await _updateWiki();
    }
  }

  // create project wiki
  _createWiki() async {
    _isSaving.value = true;
    update();

    WikiModel? localWiki = await _wikiServices.createWiki(
      projectId: projectController.activeProject.id!,
      document: json.encode(_editorState.value.document.toJson()),
    );

    _wiki.value = localWiki!;
    _isSaving.value = false;
    update();

    updateEditorState(false);
  }

  // update project wiki
  _updateWiki() async {
    _isSaving.value = true;
    update();

    WikiModel? localWiki = await _wikiServices.updateWiki(
      wiki: WikiModel(
        id: wiki.id,
        document: json.encode(_editorState.value.document.toJson()),
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );

    _wiki.value = localWiki!;
    _isSaving.value = false;
    update();

    updateEditorState(false);
  }
}
