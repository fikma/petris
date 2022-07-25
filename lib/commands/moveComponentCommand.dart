import 'package:petris/commands/baseCommand.dart';
import 'package:petris/components/baseComponent.dart';
import 'package:petris/components/boardWidgetComponent.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class MoveComponentCommand implements BaseCommand {
  TetrisBlockLogic tetrisBlockLogic;
  TetrisBlockModel tetrisBlockModel;

  MoveComponentCommand(this.tetrisBlockLogic, this.tetrisBlockModel);

  @override
  void execute(BaseComponent component) {
    component = component as BoardWidgetComponent;
    tetrisBlockLogic.moveTo(
      direction: component.tetrisBlockModel.gravity,
      tetrisBlockModel: tetrisBlockModel,
    );
  }

  @override
  void undo(BaseComponent component) {
    component = component as BoardWidgetComponent;
    var g = component.tetrisBlockModel.gravity;
    g.x *= -1;
    g.y *= -1;
    tetrisBlockLogic.moveTo(
      direction: g,
      tetrisBlockModel: tetrisBlockModel,
    );
  }
}
