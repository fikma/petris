import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/components/baseComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class BoardWidgetComponent extends BaseComponent {
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

    var moveCommand = MoveComponentCommand(tetrisBlockModel);
    moveCommand.execute(tetrisBlockModel.gravity);

    if (tetrisBlockLogic.isBlockOutsideBoardHeight(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    )) {
      moveCommand.undo();
      BoardWidgetLogic().setBoardBlock(
        boardWidgetModel: boardWidgetModel,
        tetrisBlockModel: tetrisBlockModel,
      );

      tetrisBlockModel = tetrisBlockLogic.reset(
        boardWidgetModel: boardWidgetModel,
        tetrisBlockModel: tetrisBlockModel,
      );
    }

    if (tetrisBlockLogic.isBlockCollideWithTetrominoe(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    )) {
      moveCommand.undo();
      tetrisBlockLogic.clear(
          boardWidgetModel: boardWidgetModel,
          tetrisBlockModel: tetrisBlockModel);

      BoardWidgetLogic().setBoardBlock(
        boardWidgetModel: boardWidgetModel,
        tetrisBlockModel: tetrisBlockModel,
      );

      tetrisBlockModel = tetrisBlockLogic.reset(
        boardWidgetModel: boardWidgetModel,
        tetrisBlockModel: tetrisBlockModel,
      );
    }

    var checkLineResult = BoardWidgetLogic().checkLine(
      boardWidgetModel: boardWidgetModel,
    );
    if (checkLineResult[0] as bool) {
      TetrisBlockLogic().clear(
        boardWidgetModel: boardWidgetModel,
        tetrisBlockModel: tetrisBlockModel,
      );
      BoardWidgetLogic().moveLineDown(
        boardWidgetModel: boardWidgetModel,
        yPositions: checkLineResult[1],
      );
    }

    tetrisBlockLogic.setTetrisBlockToBoard(
      boardWidgetModel: boardWidgetModel,
      tetrisBlockModel: tetrisBlockModel,
    );

    tetrisBlockModel.display();
  }
}
