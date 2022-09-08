import 'dart:collection';

import 'package:petris/models/tetrisBlockModel.dart';

class HudWidgetModel {
  double fontSize = 14;
  int blockSize = 10;
  Function? updateCallback;
  double singleBlockSize = 10;

  final TetrisBlockModel tetrisBlockModel;

  HudWidgetModel({required this.tetrisBlockModel});
}
