import 'package:flutter/material.dart';

class BoardConfig {
  static int xSize = 10;
  static int ySize = 20;

  static int blockSize = 30;
  static Duration loopDuration = const Duration(milliseconds: 150);
  static int tickTime = 700;

  static Color boardColor = Color(Colors.grey[900]!.value);
}

class HudConfig {
  static Color boardColor = Color(Colors.grey[900]!.value);
  static const int tetrisBlockSize = 10;
}
