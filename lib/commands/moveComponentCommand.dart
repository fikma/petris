import 'dart:math';

import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class MoveComponentCommand {
  late Point direction;

  MoveComponentCommand(this.tetrisBlockModel);

  void execute(Point direction) {
    this.direction = Point(direction.x, direction.y);
    TetrisBlockLogic().moveTo(
      direction: this.direction,
      tetrisBlockModel: tetrisBlockModel,
    );
  }

  void undo() {
    var g = direction * -1;
    TetrisBlockLogic().moveTo(
      direction: g,
      tetrisBlockModel: tetrisBlockModel,
    );
  }

  late TetrisBlockModel tetrisBlockModel;
}
