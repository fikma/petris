import 'package:flutter/material.dart';
import 'package:petris/components/gamePageComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/pages/widget/CountDownWidget.dart';
import 'package:petris/pages/widget/boardWidget.dart';

class GamePage extends StatelessWidget {
  GamePage({Key? key}) : super(key: key) {
    boardWidgetLogic = BoardWidgetLogic(boardWidgetModel);
  }

  TetrisBlockModel tetrisBlockModel = TetrisBlockModel();
  GamePageModel gamePageModel = GamePageModel();
  BoardWidgetModel boardWidgetModel = BoardWidgetModel();
  CountDownWidgetModel countDownWidgetModel = CountDownWidgetModel();

  late BoardWidgetLogic boardWidgetLogic;

  @override
  Widget build(BuildContext context) {
    var logic = GamePageComponent(pageState: gamePageModel);

    logic.update();

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("helo"),
            BoardWidget(
              boardWidgetModel: boardWidgetModel,
              gamePageModel: gamePageModel,
              tetrisBlockModel: tetrisBlockModel,
              boardWidgetLogic: boardWidgetLogic,
            ),
            Text("helo"),
          ],
        ),
        CountDownWidget(
          gamePageModel: gamePageModel,
          countDownWidgetModel: countDownWidgetModel,
        ),
      ],
    );
  }
}
