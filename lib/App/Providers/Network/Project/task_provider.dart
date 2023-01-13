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
        'description': task.description,
        'board_id': task.boardId,
        'reporter_id': task.reporterId,
        'assignee_id': task.assigneeId,
        'status': task.status ?? 'todo',
        'start_date': task.startDate ?? DateTime.now().toIso8601String(),
        'due_date': task.dueDate,
        'original_estimate': task.originalEstimate,
        'priority': task.priority,
        'environment': task.environment,
        'created_at': DateTime.now().toIso8601String(),
      },
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
    // update where value not null
    Map<String, dynamic> updateData = {
      'title': task.title,
      'description': task.description,
      'board_id': task.boardId,
      'reporter_id': task.reporterId,
      'assignee_id': task.assigneeId,
      'status': task.status,
      'start_date': task.startDate,
      'due_date': task.dueDate,
      'original_estimate': task.originalEstimate,
      'priority': task.priority,
      'environment': task.environment,
      'updated_at': DateTime.now().toIso8601String(),
    };

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
