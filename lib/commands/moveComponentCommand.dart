import 'dart:math';

import 'package:petris/commands/baseCommand.dart';
import 'package:petris/components/baseComponent.dart';
import 'package:petris/components/boardWidgetComponent.dart';

import '../logics/tetrisBlockLogic.dart';

class MoveComponentCommand implements BaseCommand {
  @override
  void execute(BaseComponent component) {
    component = component as BoardWidgetComponent;
    TetrisBlockLogic.moveTo(
        direction: component.tetrisBlockModel.gravity,
        tetrisBlockModel: component.tetrisBlockModel);
  }

  @override
  void undo(BaseComponent component) {
    component = component as BoardWidgetComponent;
    TetrisBlockLogic.moveTo(
        direction: component.tetrisBlockModel.gravity * -1,
        tetrisBlockModel: component.tetrisBlockModel);
  }
}
