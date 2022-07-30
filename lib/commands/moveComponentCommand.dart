import 'package:petris/commands/baseCommand.dart';
import 'package:petris/configs/vector.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class MoveComponentCommand {
  late Vector direction;

  MoveComponentCommand(this.tetrisBlockModel);

  @override
  void execute(Vector direction) {
    this.direction = direction;
    TetrisBlockLogic().moveTo(
      direction: this.direction,
      tetrisBlockModel: tetrisBlockModel,
    );
  }

  void undo() {
    var g = direction;
    g.x *= -1;
    g.y *= -1;
    TetrisBlockLogic().moveTo(
      direction: g,
      tetrisBlockModel: tetrisBlockModel,
    );
  }

  late TetrisBlockModel tetrisBlockModel;
}
