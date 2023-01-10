import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectSingleWikiController extends GetxController {
  final _editorState = EditorState(
    document: markdownToDocument(r'''### 🙌 Hello from Flutter++!'''),
  ).obs;
  EditorState get editorState => _editorState.value;

  final _isNeedToSave = false.obs;
  bool get isNeedToSave => _isNeedToSave.value;

  final _focusNode = FocusNode().obs;
  FocusNode get focusNode => _focusNode.value;

  void updateEditorState() {
    _isNeedToSave.value = true;
    update();
  }

  void save() {
    print('save');
  }
}
