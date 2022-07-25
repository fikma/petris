import 'dart:async';

import 'package:petris/components/baseComponent.dart';
import 'package:petris/configs/boardConfig.dart';
import 'package:petris/models/gamePageModel.dart';

class GamePageComponent implements BaseComponent {
  GamePageModel pageState;

  GamePageComponent({required this.pageState});

  @override
  void update() {
    pageState.loop = Timer.periodic(BoardConfig.loopDuration, (timer) {
      if (!pageState.paused) {
        for (var element in pageState.components) {
          element.update();
        }
        print("game running");
      } else {
        print("paused");
      }
    });
  }
}
