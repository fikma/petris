import 'package:flutter/widgets.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

// ioc container untuk gamePage only
class GamePageInheritedWidget extends InheritedWidget {
  final BoardWidgetModel _boardWidgetModel = BoardWidgetModel();
  final TetrisBlockModel _tetrisBlockModel = TetrisBlockModel();

  GamePageInheritedWidget({Key? key, required super.child}) : super(key: key);

  BoardWidgetModel get getBoardWidgetModel => _boardWidgetModel;
  TetrisBlockModel get getTetrisBlockModel => _tetrisBlockModel;

  static GamePageInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GamePageInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
