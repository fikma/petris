import 'package:petris/components/baseComponent.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

import '../models/gamePageModel.dart';

class CountDownWidgetComponent extends BaseComponent {
  CountDownWidgetModel countDownWidgetModel;
  final GamePageModel gamePageModel;

  CountDownWidgetComponent({
    required this.gamePageModel,
    required this.countDownWidgetModel,
  }) {
    gamePageModel.components.add(this);
  }

  @override
  void update() {
    if (countDownWidgetModel.countStarted) {
      if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
        countDownWidgetModel.text = countDownWidgetModel.counter.toString();
        countDownWidgetModel.updateCallback!();

        if (countDownWidgetModel.counter < 0) {
          countDownWidgetModel.visible = false;
          countDownWidgetModel.updateCallback!();
          countDownWidgetModel.counter = 3;
          countDownWidgetModel.countStarted = false;

          gamePageModel.gameStatePaused = false;
          countDownWidgetModel.nextFocus.requestFocus();
        }

        countDownWidgetModel.counter--;
      }
    }
  }
}
