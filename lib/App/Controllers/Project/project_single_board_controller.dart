import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectSingleBoardController extends GetxController {
  // board scroll controller
  final _boardScrollController = AppFlowyBoardScrollController().obs;
  AppFlowyBoardScrollController get boardScrollController =>
      _boardScrollController.value;

  // board controller
  final AppFlowyBoardController _boardController = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );
  AppFlowyBoardController get boardController => _boardController;

  // list group data
  final _listGroupData = <AppFlowyGroupData>[].obs;
  List<AppFlowyGroupData> get listGroupData => _listGroupData;
}
