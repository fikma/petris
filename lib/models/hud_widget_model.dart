import 'package:flutter/material.dart';
import 'package:petris/models/single_block_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';

class HudWidgetModel {
  double fontSize = 18;
  int blockSize = 10;
  Function? updateCallback;
  double singleBlockSize = 10;
  Color fontColor = Color(Colors.grey[50]!.value);

  List<List<SingleBlockWidgetModel>> boardList = [];
  late TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks;
}
