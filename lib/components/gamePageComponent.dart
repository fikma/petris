import 'dart:async';

import 'package:petris/components/baseComponent.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/gamePageModel.dart';

class GamePageComponent extends BaseComponent {
  GamePageModel gamePageModel;

  GamePageComponent({required this.gamePageModel});

  @override
  void update(GamePageModel? gamePageModel) {
    this.gamePageModel.timer.start();
    this.gamePageModel.loop = Timer.periodic(BoardConfig.loopDuration, (timer) {
      if (this.gamePageModel.isRunning) {
        for (var element in this.gamePageModel.components) {
          element.update(this.gamePageModel);
        }
      } else {
        print("paused");
      }
      if (this.gamePageModel.timer.elapsedMilliseconds >=
          BoardConfig.tickTime) {
        this.gamePageModel.timer.reset();
      }
    });
  }
}
