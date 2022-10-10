import 'package:flutter/material.dart';
import 'package:petris/components/base_component.dart';

class GamePageModel {
  List<BaseComponent> components = [];
  bool gameStatePaused = true;
  bool isGameOver = true;

  Color bodyBackgroundColor = Color(Colors.grey[900]!.value);

  int tickTime = 0;
  Stopwatch stopwatch = Stopwatch();
}
