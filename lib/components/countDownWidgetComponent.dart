import 'package:petris/components/baseComponent.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

import '../models/gamePageModel.dart';

class CountDownWidgetComponent extends BaseComponent {
  GamePageModel gamePageModel;
  CountDownWidgetModel countDownWidgetModel;

  CountDownWidgetComponent({
    required this.gamePageModel,
    required this.countDownWidgetModel,
  }) {
    gamePageModel.components.add(this);
  }

  @override
  void update() {
    if (countDownWidgetModel.countStarted) {
      if (gamePageModel.timer.elapsedMilliseconds >= BoardConfig.tickTime) {
        countDownWidgetModel.text = countDownWidgetModel.counter.toString();
        countDownWidgetModel.updateCallback!();

        if (countDownWidgetModel.counter < 0) {
          countDownWidgetModel.visible = false;
          countDownWidgetModel.updateCallback!();

          gamePageModel.gameStatePaused = false;
          countDownWidgetModel.nextFocus.requestFocus();
        }

        countDownWidgetModel.counter--;
      }
    }
  }
}
