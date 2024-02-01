// import 'package:appflowy_board/appflowy_board.dart';
import 'package:get/get.dart';

class ProjectSingleBoardController extends GetxController {
  // final supabase = Supabase.instance.client;

  // // services
  // final BoardServices _boardServices = BoardServices();
  // final TaskServices _taskServices = TaskServices();

  // final ProjectIndexController _projectIndexController = Get.find();

  // final _isLoading = true.obs;
  // bool get isLoading => _isLoading.value;

  // // board scroll controller
  // final _boardScrollController = AppFlowyBoardScrollController().obs;
  // AppFlowyBoardScrollController get boardScrollController =>
  //     _boardScrollController.value;

  // // board controller
  // final AppFlowyBoardController _boardController = AppFlowyBoardController(
  //   onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) async {
  //     await BoardServices().updateBoard(
  //       board: BoardModel(
  //         id: int.parse(fromGroupId),
  //         index: toIndex,
  //       ),
  //     );

  //     await BoardServices().updateBoard(
  //       board: BoardModel(
  //         id: int.parse(toGroupId),
  //         index: fromIndex,
  //       ),
  //     );
  //   },
  //   onMoveGroupItem: (groupId, fromIndex, toIndex) async {
  //     // get from task
  //     TaskModel? fromTask = await TaskServices().getTaskByIndex(
  //       boardId: int.parse(groupId),
  //       index: fromIndex,
  //     );

  //     // get to task
  //     TaskModel? toTask = await TaskServices().getTaskByIndex(
  //       boardId: int.parse(groupId),
  //       index: toIndex,
  //     );

  //     // update from task
  //     if (fromTask != null) {
  //       await TaskServices().updateTask(
  //         task: TaskModel(
  //           id: fromTask.id,
  //           index: toIndex,
  //         ),
  //       );
  //     }

  //     // update to task
  //     if (toTask != null) {
  //       await TaskServices().updateTask(
  //         task: TaskModel(
  //           id: toTask.id,
  //           index: fromIndex,
  //         ),
  //       );
  //     }
  //   },
  //   onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) async {
  //     // get from task
  //     TaskModel? fromTask = await TaskServices().getTaskByIndex(
  //       boardId: int.parse(fromGroupId),
  //       index: fromIndex,
  //     );

  //     // update from task
  //     if (fromTask != null) {
  //       await TaskServices().updateTask(
  //         task: TaskModel(
  //           id: fromTask.id,
  //           boardId: int.parse(toGroupId),
  //           index: toIndex,
  //         ),
  //       );
  //     }
  //   },
  // );
  // AppFlowyBoardController get boardController => _boardController;

  // // list group data
  // final _listGroupData = <AppFlowyGroupData>[].obs;
  // List<AppFlowyGroupData> get listGroupData => _listGroupData;

  // // boards
  // final _boards = <BoardModel>[].obs;
  // List<BoardModel> get boards => _boards;

  // @override
  // Future<void> onInit() async {
  //   await fetchApi();
  //   super.onInit();
  // }

  // Future<void> fetchApi() async {
  //   await _getBoards(_projectIndexController.activeProject.id!);

  //   _isLoading.value = false;
  //   update();
  // }

  // // get boards
  // Future<void> _getBoards(int i) async {
  //   List<BoardModel>? loaclBoards = await _boardServices.getBoards(
  //     projectId: i,
  //   );

  //   if (loaclBoards != null) {
  //     _boards.value = loaclBoards;

  //     // get all tasks by board id
  //     for (var item in _boards) {
  //       List<TaskModel>? localTasks = await _taskServices.getTasks(
  //         boardId: item.id!,
  //       );

  //       // create listgroupdata per board
  //       // add tasks to listgroupdata
  //       _listGroupData.add(
  //         AppFlowyGroupData(
  //           id: item.id.toString(),
  //           name: item.name!,
  //           items: [],
  //         ),
  //       );

  //       _boardController.addGroups(_listGroupData);

  //       for (var task in localTasks!) {
  //         AppFlowyGroupItem newTask = TextItem(task.title!);
  //         _boardController.addGroupItem(item.id.toString(), newTask);
  //       }

  //       update();
  //     }
  //   }
  // }

  // // create board
  // createBoard(Map<String, dynamic> data) {
  //   final String title = data['title'];

  //   _boardServices
  //       .createBoard(
  //     name: title,
  //     projectId: _projectIndexController.activeProject.id!,
  //     index: _boards.length + 1,
  //   )
  //       .then((value) {
  //     if (value != null) {
  //       _boards.add(value);
  //       _listGroupData.add(
  //         AppFlowyGroupData(
  //           id: value.id.toString(),
  //           name: value.name!,
  //           items: [],
  //         ),
  //       );
  //       _boardController.addGroups(_listGroupData);
  //       update();
  //     }
  //   });
  // }

  // // update board
  // updateBoardName(Map data) async {
  //   final String title = data['title'];
  //   final int id = int.parse(data['id']);

  //   await _boardServices.updateBoard(
  //     board: BoardModel(
  //       id: id,
  //       name: title,
  //     ),
  //   );

  //   // clear
  //   _listGroupData.clear();

  //   _boardController.addListener(() {});

  //   // refitsh boards
  //   Get.showOverlay(
  //     loadingWidget: const BuildOverlay(),
  //     asyncFunction: () async => await fetchApi(),
  //   );
  // }

  // // count tasks in listGroupData
  // int countTasks() {
  //   int count = 0;
  //   for (var element in _listGroupData) {
  //     count += element.items.length;
  //   }
  //   return count;
  // }

  // // create task by board id
  // int countTasksByBoardId(int boardId) {
  //   int count = 0;
  //   for (var element in _listGroupData) {
  //     if (int.parse(element.id) == boardId) {
  //       count += element.items.length;
  //     }
  //   }
  //   return count;
  // }

  // // add a task to a board
  // addTask(Map<String, dynamic> data, AppFlowyGroupData columnData) async {
  //   // string to date

  //   Map<String, dynamic> newMap = {
  //     ...data.map((key, value) => MapEntry(key, value.toString())),
  //     'board_id': int.parse(columnData.id),
  //     'reporter_id': supabase.auth.currentUser!.id,
  //     'assignee_id': supabase.auth.currentUser!.id,
  //     'index': columnData.items.length,

  //     // 'index': countTasksByBoardId(int.parse(columnData.id)),
  //   };

  //   TaskModel task = TaskModel.fromMap(newMap);
  //   TaskModel? newTask = await _taskServices.createTask(task: task);

  //   if (newTask != null) {
  //     AppFlowyGroupItem newTaskItem = TextItem(newTask.title!);
  //     _boardController.addGroupItem(columnData.id, newTaskItem);
  //     update();
  //   }
  // }
}
