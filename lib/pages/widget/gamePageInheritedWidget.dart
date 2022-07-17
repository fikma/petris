import 'package:flutter/widgets.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

// ioc container untuk gamePage only
class GamePageInheritedWidget extends InheritedWidget {
  final BoardWidgetModel _boardWidgetModel = BoardWidgetModel();
  final TetrisBlockModel _tetrisBlockModel = TetrisBlockModel();
  final CountDownWidgetModel _countDownWidgetModel = CountDownWidgetModel();
  final GamePageModel _gamePageModel = GamePageModel();

  GamePageInheritedWidget({Key? key, required super.child}) : super(key: key);

  BoardWidgetModel get getBoardWidgetModel => _boardWidgetModel;
  TetrisBlockModel get getTetrisBlockModel => _tetrisBlockModel;
  CountDownWidgetModel get getCountDownWidgetModel => _countDownWidgetModel;
  GamePageModel get getGamePageModel => _gamePageModel;

  static GamePageInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GamePageInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
