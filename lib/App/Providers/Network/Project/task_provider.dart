import 'dart:convert';

import 'package:flutterpp/App/Models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskProvider {
  final supabase = Supabase.instance.client;

  // create task
  Future<TaskModel?> createTask({
    required TaskModel task,
  }) async {
    List<Map> data = await supabase.from('tasks').insert([
      {
        'title': task.title,
        'board_id': task.boardId,
        'reporter_id': task.reporterId,
        'assignee_id': task.assigneeId,
        'index': task.index,
        'status': task.status,
        'priority': task.priority,
        'due_date': task.dueDate,
        'start_date': task.startDate,
        'original_estimate': task.originalEstimate,
        'environment': task.environment,
        'description': task.description,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }
    ]).select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return TaskModel.fromJson(json.decode(localJson));
  }

  // get tasks by board id
  Future<List<TaskModel>?> getTasks({required int boardId}) async {
    List<Map> data = await supabase
        .from('tasks')
        .select('*')
        .eq('board_id', boardId)
        .order('index', ascending: true)
        .select();

    if (data.isEmpty) return [];

    List<TaskModel> tasks = [];
    for (var item in data) {
      var localJson = json.encode(item);
      tasks.add(TaskModel.fromJson(json.decode(localJson)));
    }

    return tasks;
  }

  // update task
  Future<TaskModel?> updateTask({required TaskModel task}) async {
    Map updateData = task.toMap();
    updateData.removeWhere((key, value) => value == null);

    List<Map> data = await supabase
        .from('tasks')
        .update(updateData)
        .eq('id', task.id)
        .select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return TaskModel.fromJson(json.decode(localJson));
  }

  // delete task
  Future<bool> deleteTask({required int taskId}) async {
    List<Map> data = await supabase
        .from('tasks')
        .delete()
        .eq(
          'id',
          taskId,
        )
        .select();

    if (data.isEmpty) return false;
    return true;
  }

  // delete task by board id
  Future<bool> deleteTaskByBoardId({required int boardId}) async {
    List<Map> data = await supabase
        .from('tasks')
        .delete()
        .eq(
          'board_id',
          boardId,
        )
        .select();

    if (data.isEmpty) return false;
    return true;
  }
}
