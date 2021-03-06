import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/components/baseComponent.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class BoardWidgetComponent implements BaseComponent {
  late TetrisBlockModel tetrisBlockModel;
  late BoardWidgetModel boardWidgetModel;
  late GamePageModel gamePageModel;

  BoardWidgetComponent({
    required this.gamePageModel,
    required this.tetrisBlockModel,
    required this.boardWidgetModel,
  }) {
    gamePageModel.components.add(this);
  }
  @override
  void update() {
    TetrisBlockLogic.clear(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    );

    MoveComponentCommand().execute(this);
    if (TetrisBlockLogic.isBlockOutsideBoard(tetrisBlockModel)) {
      MoveComponentCommand().undo(this);
    }

    TetrisBlockLogic.setTetrisBlockToBoard(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    );
  }
}
