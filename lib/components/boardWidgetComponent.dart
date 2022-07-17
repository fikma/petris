import 'package:petris/components/baseComponent.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class BoardWidgetComponent implements BaseComponent {
  late TetrisBlockModel state;
  late BoardWidgetModel boardWidgetModel;
  late GamePageModel gamePageModel;

  BoardWidgetComponent({
    required this.gamePageModel,
    required this.state,
    required this.boardWidgetModel,
  }) {
    gamePageModel.components.add(this);
  }
  @override
  void update() {
    TetrisBlockLogic.clear(
      tetrisBlockModel: state,
      boards: boardWidgetModel.boardList,
    );

    TetrisBlockLogic.rotate(tetrisBlockModel: state);

    TetrisBlockLogic.setTetrisBlockToBoard(
      tetrisBlockModel: state,
      boards: boardWidgetModel.boardList,
    );
  }
}
