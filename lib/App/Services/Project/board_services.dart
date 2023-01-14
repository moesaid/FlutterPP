import 'package:flutterpp/App/Models/board_model.dart';
import 'package:flutterpp/App/Providers/Network/Project/board_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';

class BoardServices {
  final BoardProvider _boardProvider = BoardProvider();
  final CallPipeline _callPipeline = CallPipeline();

  // get board by project id
  Future<List<BoardModel>?> getBoards({required int projectId}) async {
    List<BoardModel>? boards = await _callPipeline.futurePipeline(
      future: () => _boardProvider.getBoards(projectId: projectId),
      name: 'getBoards',
    );

    return boards;
  }

  // create board
  Future<BoardModel?> createBoard({
    required String name,
    required int projectId,
    required int index,
  }) async {
    BoardModel? board = await _callPipeline.futurePipeline(
      future: () => _boardProvider.createBoard(
        name: name,
        projectId: projectId,
        index: index,
      ),
      name: 'createBoard',
    );

    return board;
  }

  // update board
  Future<BoardModel?> updateBoard({required BoardModel board}) async {
    BoardModel? updatedBoard = await _callPipeline.futurePipeline(
      future: () => _boardProvider.updateBoard(board: board),
      name: 'updateBoard',
    );

    return updatedBoard;
  }
}
