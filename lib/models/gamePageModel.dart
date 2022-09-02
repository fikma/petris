import 'dart:async';

import 'package:petris/components/baseComponent.dart';

class GamePageModel {
  late Timer loop;
  List<BaseComponent> components = [];
  bool isRunning = true;
  bool gameStatePaused = true;

  int tickTime = 0;
  Stopwatch timer = Stopwatch();
}
