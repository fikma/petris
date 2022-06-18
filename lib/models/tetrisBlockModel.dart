import 'dart:math';

import 'package:petris/models/singleBlockWidgetModel.dart';

class TetrisBlockModel {
  List<SingleBlockWidgetModel> blocks = [
    SingleBlockWidgetModel(
      position: Point(0, 0),
    ),
    SingleBlockWidgetModel(
      position: Point(0, 1),
    ),
    SingleBlockWidgetModel(
      position: Point(0, 2),
    ),
    SingleBlockWidgetModel(
      position: Point(0, 3),
    ),
  ];
}
