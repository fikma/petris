import 'package:petris/models/single_block_widget_model.dart';

class BoardWidgetModel {
  int rowCount = 20, columnCount = 10;
  late final List<List<SingleBlockWidgetModel>> boardList;
}
