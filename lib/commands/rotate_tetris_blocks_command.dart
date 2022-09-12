import 'package:petris/logics/tetris_block_logic.dart';

import '../models/single_block_widget_model.dart';

class RotateTetrisBlocksCommand {
  List<SingleBlockWidgetModel> tetrisBlocks;
  TetrisBlockLogic tetrisBlockLogic = TetrisBlockLogic();

  RotateTetrisBlocksCommand({required this.tetrisBlocks});

  void execute() {
    tetrisBlocks = tetrisBlockLogic.rotate(
      tetrisBlocks: tetrisBlocks,
      rotationOriginIndex: 1,
      rotateClockwise: true,
    );
  }

  void undo() {
    tetrisBlocks = tetrisBlockLogic.rotate(
      tetrisBlocks: tetrisBlocks,
      rotationOriginIndex: 1,
      rotateClockwise: false,
    );
  }
}
