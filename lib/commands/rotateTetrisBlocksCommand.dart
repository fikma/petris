import 'package:petris/logics/tetrisBlockLogic.dart';

import '../models/singleBlockWidgetModel.dart';

class RotateTetrisBlocksCommand {
  List<SingleBlockWidgetModel> tetrisBlocks;

  RotateTetrisBlocksCommand({required this.tetrisBlocks});

  void execute() {
    // TODO: implement execute
    tetrisBlocks = TetrisBlockLogic().rotate(
      tetrisBlocks: tetrisBlocks,
      rotationOriginIndex: 1,
      rotateClockwise: true,
    );
  }

  void undo() {
    // TODO: implement undo
    tetrisBlocks = TetrisBlockLogic().rotate(
      tetrisBlocks: tetrisBlocks,
      rotationOriginIndex: 1,
      rotateClockwise: false,
    );
  }
}
