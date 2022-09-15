import 'package:petris/models/single_block_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';

class HudWidgetModel {
  double fontSize = 14;
  int blockSize = 10;
  Function? updateCallback;
  double singleBlockSize = 10;

  List<List<SingleBlockWidgetModel>> boardList = [];
  late TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks;
}
