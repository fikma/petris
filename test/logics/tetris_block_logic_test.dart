import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:petris/logics/tetris_block_logic.dart';
import 'package:petris/models/single_block_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';
import 'package:petris/utils/board_config.dart';

void main() {
  var tetrisBlockModel = TetrisBlockModel();
  var logic = TetrisBlockLogic();
  test("build tetrominos dengan random block yang dipilih", () {
    tetrisBlockModel.blocks = logic.buildTetrominoes(
      tetrisShapeList: TetrisShapeList,
      blockSize: BoardConfig.blockSize,
    );

    expect(tetrisBlockModel.blocks.length, 4);
  });

  test("build tetrominoes tertarget", () {
    var expectedValueO = [
      SingleBlockWidgetModel(
          position: const Point(0, 0), size: BoardConfig.blockSize),
      SingleBlockWidgetModel(
          position: const Point(1, 0), size: BoardConfig.blockSize),
      SingleBlockWidgetModel(
          position: const Point(0, 1), size: BoardConfig.blockSize),
      SingleBlockWidgetModel(
          position: const Point(1, 1), size: BoardConfig.blockSize),
    ];
    tetrisBlockModel.blocks = logic.buildTetrominoesByType(
      tetrisShapeList: TetrisShapeList,
      tetrisShape: TetrisShape.o,
      blockSize: BoardConfig.blockSize,
    );

    for (var i = 0; i < expectedValueO.length; i++) {
      var valueX = tetrisBlockModel.blocks[i].position.x;
      var valueY = tetrisBlockModel.blocks[i].position.y;
      var expectedValueX = expectedValueO[i].position.x;
      var expectedValueY = expectedValueO[i].position.y;

      expect(valueX, expectedValueX);
      expect(valueY, expectedValueY);
    }
  });

  test("invertTetrisBlock test", () {
    var expectedValueO = [
      SingleBlockWidgetModel(
          position: const Point(1, 0), size: BoardConfig.blockSize),
      SingleBlockWidgetModel(
          position: const Point(0, 0), size: BoardConfig.blockSize),
      SingleBlockWidgetModel(
          position: const Point(1, 1), size: BoardConfig.blockSize),
      SingleBlockWidgetModel(
          position: const Point(0, 1), size: BoardConfig.blockSize),
    ];

    tetrisBlockModel.blocks = logic.invertBlockTetris(tetrisBlockModel.blocks);

    for (var i = 0; i < tetrisBlockModel.blocks.length; i++) {
      var valueX = tetrisBlockModel.blocks[i].position.x;
      var valueY = tetrisBlockModel.blocks[i].position.y;
      var expectedValueX = expectedValueO[i].position.x;
      var expectedValueY = expectedValueO[i].position.y;

      expect(valueX, expectedValueX);
      expect(valueY, expectedValueY);
    }
  });
}
