import 'package:petris/models/singleBlockWidgetModel.dart';

class BoardWidgetModel {
  int rowCount = 20, columnCount = 10;
  late final List<List<SingleBlockWidgetModel>> _boardList;

  List<List<SingleBlockWidgetModel>> get boardList => _boardList;

  void set boardList(List<List<SingleBlockWidgetModel>> value) {
    _boardList = value;
  }
}
