import 'package:flutterpp/App/Models/task_model.dart';
import 'package:flutterpp/App/Providers/Network/Project/task_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';

class TaskServices {
  final TaskProvider _taskProvider = TaskProvider();
  final CallPipeline _callPipeline = CallPipeline();

  // create task
  Future<TaskModel?> createTask({
    required TaskModel task,
  }) async {
    TaskModel? res = await _callPipeline.futurePipeline(
      future: () => _taskProvider.createTask(
        task: task,
      ),
      name: 'createTask',
    );

    return res;
  }

  // get tasks by board id
  Future<List<TaskModel>?> getTasks({required int boardId}) async {
    List<TaskModel>? tasks = await _callPipeline.futurePipeline(
      future: () => _taskProvider.getTasks(boardId: boardId),
      name: 'getTasks',
    );

    return tasks;
  }

  // update task
  Future<TaskModel?> updateTask({required TaskModel task}) async {
    TaskModel? updatedTask = await _callPipeline.futurePipeline(
      future: () => _taskProvider.updateTask(task: task),
      name: 'updateTask',
    );

    return updatedTask;
  }

  // delete task
  Future<bool?> deleteTask({required int taskId}) async {
    bool? res = await _callPipeline.futurePipeline(
      future: () => _taskProvider.deleteTask(taskId: taskId),
      name: 'deleteTask',
    );

    return res;
  }

  // delete tasks by board id
  Future<bool?> deleteTasks({required int boardId}) async {
    bool? res = await _callPipeline.futurePipeline(
      future: () => _taskProvider.deleteTaskByBoardId(boardId: boardId),
      name: 'deleteTasks',
    );

    return res;
  }
}
