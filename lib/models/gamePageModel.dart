import 'dart:async';

import 'package:petris/components/baseComponent.dart';

class GamePageModel {
  late Timer loop;
  List<BaseComponent> components = [];
  bool isRunning = true;

  double tickTime = 0.0;
}
