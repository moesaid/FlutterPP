import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/App/Models/board_model.dart';
import 'package:flutterpp/App/Models/task_model.dart';
import 'package:flutterpp/App/Services/Project/board_services.dart';
import 'package:flutterpp/App/Services/Project/task_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_board_widges.dart';
import 'package:get/get.dart';

class ProjectSingleBoardController extends GetxController {
  // services
  final BoardServices _boardServices = BoardServices();
  final TaskServices _taskServices = TaskServices();

  final ProjectIndexController _projectIndexController = Get.find();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  // board scroll controller
  final _boardScrollController = AppFlowyBoardScrollController().obs;
  AppFlowyBoardScrollController get boardScrollController =>
      _boardScrollController.value;

  // board controller
  final AppFlowyBoardController _boardController = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) async {
      await BoardServices().updateBoard(
        board: BoardModel(
          id: int.parse(fromGroupId),
          index: toIndex,
        ),
      );

      await BoardServices().updateBoard(
        board: BoardModel(
          id: int.parse(toGroupId),
          index: fromIndex,
        ),
      );
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('onMoveGroupItem $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint(
        'onMoveGroupItem $fromGroupId:$fromIndex to $toGroupId:$toIndex',
      );
    },
  );
  AppFlowyBoardController get boardController => _boardController;

  // list group data
  final _listGroupData = <AppFlowyGroupData>[].obs;
  List<AppFlowyGroupData> get listGroupData => _listGroupData;

  // boards
  final _boards = <BoardModel>[].obs;
  List<BoardModel> get boards => _boards;

  @override
  Future<void> onInit() async {
    await fetchApi();
    super.onInit();
  }

  Future<void> fetchApi() async {
    await _getBoards(_projectIndexController.activeProject.id!);
    await _getTasks();
    await _addGroupsToController();

    _isLoading.value = false;
    update();
  }

  // get boards
  Future<void> _getBoards(int i) async {
    List<BoardModel>? loaclBoards = await _boardServices.getBoards(
      projectId: i,
    );

    if (loaclBoards != null) {
      _boards.value = loaclBoards;

      _listGroupData.value = loaclBoards
          .map((e) => AppFlowyGroupData(
                id: e.id.toString(),
                name: e.name!,
                items: [],
              ))
          .toList();
      update();
    }
  }

  // get tasks
  _getTasks() async {
    // get all tasks by board id
    for (var board in _boards) {
      List<TaskModel>? localTasks = await _taskServices.getTasks(
        boardId: board.id!,
      );

      if (localTasks != null) {
        // add tasks to listGroupData where boardId == groupId
        for (var task in localTasks) {
          for (var element in _listGroupData) {
            if (element.id == task.boardId.toString()) {
              element.items.add(TextItem(task.title!));
            }
          }
        }
      }
    }
  }

  // add groups to controller
  _addGroupsToController() {
    _boardController.addGroups(_listGroupData);
    update();
  }

  // clear controller
  clearController() {
    _boardController.clear();
    update();
  }

  // create board
  createBoard(Map<String, dynamic> data) {
    final String title = data['title'];

    _boardServices
        .createBoard(
      name: title,
      projectId: _projectIndexController.activeProject.id!,
      index: _boards.length + 1,
    )
        .then((value) {
      if (value != null) {
        _boards.add(value);
        _listGroupData.add(
          AppFlowyGroupData(
            id: value.id.toString(),
            name: value.name!,
            items: [],
          ),
        );
        _boardController.addGroups(_listGroupData);
        update();
      }
    });
  }

  // update board
  updateBoardName(Map data) async {
    final String title = data['title'];
    final int id = int.parse(data['id']);

    await _boardServices.updateBoard(
      board: BoardModel(
        id: id,
        name: title,
      ),
    );

    // clear
    clearController();

    // refitsh boards
    Get.showOverlay(
      loadingWidget: const BuildOverlay(),
      asyncFunction: () async => await fetchApi(),
    );
  }

  // count tasks in listGroupData
  int countTasks() {
    int count = 0;
    for (var element in _listGroupData) {
      count += element.items.length;
    }
    return count;
  }
}
