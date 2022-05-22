import 'package:flutter/widgets.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';

// ioc container untuk gamePage only
class GamePageInheritedWidget extends InheritedWidget {
  final BoardWidgetModel _boardWidgetModel = BoardWidgetModel();

  final BoardWidgetLogic _boardWidgetLogic =
      new BoardWidgetLogic(BoardWidgetModel());

  GamePageInheritedWidget({required super.child});

  BoardWidgetModel get getBoardWidgetModel => _boardWidgetModel;
  BoardWidgetLogic get getBoardWidgetLogic => _boardWidgetLogic;

  static GamePageInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GamePageInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
