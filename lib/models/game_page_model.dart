import 'package:flutter/material.dart';
import 'package:petris/components/base_component.dart';

class GamePageModel {
  List<BaseComponent> components = [];
  bool gameStatePaused = true;
  bool isGameOver = true;
  bool isGestureEnabled = false;

  Color bodyBackgroundColor = Color(Colors.grey[900]!.value);

  Stopwatch stopwatch = Stopwatch();
}
