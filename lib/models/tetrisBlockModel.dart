import 'dart:math';

import 'package:petris/models/singleBlockWidgetModel.dart';

class TetrisBlockModel {
  List<SingleBlockWidgetModel> blocks = [
    SingleBlockWidgetModel(
      position: Point(0, 1),
    ),
    SingleBlockWidgetModel(
      position: Point(1, 1),
    ),
    SingleBlockWidgetModel(
      position: Point(2, 1),
    ),
    SingleBlockWidgetModel(
      position: Point(3, 1),
    ),
  ];
}
