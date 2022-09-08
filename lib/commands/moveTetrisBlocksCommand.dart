import 'dart:math';

import '../logics/tetrisBlockLogic.dart';
import '../models/singleBlockWidgetModel.dart';

class MoveTetrisBlocksCommand {
  late Point direction;
  List<SingleBlockWidgetModel> tetrisBlocks;

  MoveTetrisBlocksCommand({required this.tetrisBlocks});

  void execute(Point direction) {
    this.direction = Point(direction.x, direction.y);
    tetrisBlocks = TetrisBlockLogic().moveTo(
      direction: this.direction,
      tetrisBlocks: tetrisBlocks,
    );
  }

  void undo() {
    var g = direction * -1;
    tetrisBlocks = TetrisBlockLogic().moveTo(
      direction: g,
      tetrisBlocks: tetrisBlocks,
    );
  }
}
