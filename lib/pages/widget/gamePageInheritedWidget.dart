import 'package:flutter/widgets.dart';
import 'package:petris/models/countDownWidgetModel.dart';

// ioc container untuk gamePage only
class GamePageInheritedWidget extends InheritedWidget {
  final CountDownWidgetModel _countDownWidgetModel = CountDownWidgetModel();

  GamePageInheritedWidget({Key? key, required super.child}) : super(key: key);

  CountDownWidgetModel get getCountDownWidgetModel => _countDownWidgetModel;

  static GamePageInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GamePageInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
