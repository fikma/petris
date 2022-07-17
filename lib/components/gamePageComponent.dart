import 'dart:async';

import 'package:petris/components/baseComponent.dart';
import 'package:petris/models/gamePageModel.dart';

class GamePageComponent implements BaseComponent {
  final GamePageModel pageState;

  GamePageComponent({required this.pageState});

  @override
  void update() {
    pageState.loop = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!pageState.paused) {
        for (var element in pageState.components) {
          element.update();
        }
      } else {
        print("paused");
      }
    });
  }
}
