import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

class HudWidgetModel {
  double fontSize = 14;
  int blockSize = 10;
  Function? updateCallback;
  double singleBlockSize = 10;

  final TetrisBlockModel tetrisBlockModel;
  late final List<List<SingleBlockWidgetModel>> boardList;
  late TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks;

  HudWidgetModel({required this.tetrisBlockModel});
}
