import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/components/baseComponent.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class BoardWidgetComponent implements BaseComponent {
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;
  GamePageModel gamePageModel;

  TetrisBlockLogic tetrisBlockLogic = TetrisBlockLogic();

  BoardWidgetComponent({
    required this.gamePageModel,
    required this.boardWidgetModel,
    required this.tetrisBlockModel,
  }) {
    gamePageModel.components.add(this);
  }
  @override
  void update() {
    tetrisBlockLogic.clear(
      boardWidgetModel: boardWidgetModel,
      tetrisBlockModel: tetrisBlockModel,
    );

    MoveComponentCommand(tetrisBlockLogic, tetrisBlockModel).execute(this);
    if (tetrisBlockLogic.isBlockOutsideBoard(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    )) {
      tetrisBlockModel = tetrisBlockLogic.reset(tetrisBlockModel);
    }

    tetrisBlockLogic.setTetrisBlockToBoard(
      boardWidgetModel: boardWidgetModel,
      tetrisBlockModel: tetrisBlockModel,
    );

    tetrisBlockModel.display();
  }
}
