import 'dart:convert';

import 'package:flutterpp/App/Models/board_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoardProvider {
  final supabase = Supabase.instance.client;

  // create board
  Future<BoardModel?> createBoard({
    required String name,
    required int projectId,
    required int index,
  }) async {
    List<Map> data = await supabase.from('boards').insert([
      {
        'name': name,
        'project_id': projectId,
        'index': index,
        'created_at': DateTime.now().toIso8601String(),
      }
    ]).select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return BoardModel.fromJson(json.decode(localJson));
  }

  // get boards by project id
  Future<List<BoardModel>?> getBoards({required int projectId}) async {
    List<Map> data = await supabase
        .from('boards')
        .select('*')
        .eq('project_id', projectId)
        .order('index', ascending: true)
        .select();

    if (data.isEmpty) return [];

    List<BoardModel> boards = [];
    for (var item in data) {
      var localJson = json.encode(item);
      boards.add(BoardModel.fromJson(json.decode(localJson)));
    }

    return boards;
  }

  // update board
  Future<BoardModel?> updateBoard({required BoardModel board}) async {
    Map boardMap = board.toMap();

    boardMap.removeWhere((key, value) => value == null);

    List<Map> data = await supabase
        .from('boards')
        .update(boardMap)
        .eq('id', board.id!)
        .select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return BoardModel.fromJson(json.decode(localJson));
  }

  // delete board
  Future<bool> deleteBoard({required int boardId}) async {
    List<Map> data = await supabase
        .from('boards')
        .delete()
        .eq(
          'id',
          boardId,
        )
        .select();

    if (data.isEmpty) return false;
    return true;
  }
}
