import 'package:flutter/material.dart';
import 'package:petris/components/gamePageComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/inputLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/pages/widget/CountDownWidget.dart';
import 'package:petris/pages/widget/boardWidget.dart';

class GamePage extends StatelessWidget {
  GamePage() {
    boardFocus = FocusNode();
    inputLogic = InputLogic(tetrisBlockModel, boardWidgetModel);
  }

  final TetrisBlockModel tetrisBlockModel = TetrisBlockModel();
  final GamePageModel gamePageModel = GamePageModel();
  final BoardWidgetModel boardWidgetModel = BoardWidgetModel();
  final CountDownWidgetModel countDownWidgetModel = CountDownWidgetModel();

  late final BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();
  late final GamePageComponent gamePageComponent =
      GamePageComponent(gamePageModel: gamePageModel);

  late FocusNode boardFocus;
  late InputLogic inputLogic;

  @override
  Widget build(BuildContext context) {
    gamePageComponent.update();

    return Stack(
      children: [
        Focus(
          autofocus: true,
          focusNode: boardFocus,
          onKeyEvent: inputLogic.keyBoardInputHandle,
          child: GestureDetector(
            onPanDown: inputLogic.gestureStartHandle,
            onPanUpdate: (DragUpdateDetails details) {
              inputLogic.gestureUpdateHandle(details);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("helo"),
                BoardWidget(
                  boardWidgetModel: boardWidgetModel,
                  gamePageModel: gamePageModel,
                  tetrisBlockModel: tetrisBlockModel,
                  boardWidgetLogic: boardWidgetLogic,
                ),
              ],
            ),
          ),
        ),
        CountDownWidget(
          gamePageModel: gamePageModel,
          countDownWidgetModel: countDownWidgetModel,
          nextFocus: boardFocus,
        ),
      ],
    );
  }
}
