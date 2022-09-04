import 'package:flutter/material.dart';
import 'package:petris/components/gamePageComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/inputEventLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/pages/widget/CountDownWidget.dart';
import 'package:petris/pages/widget/boardWidget.dart';

class GamePage extends StatelessWidget {
  GamePage() {
    boardFocus = FocusNode();
    inputEventLogic = InputEventLogic(tetrisBlockModel, boardWidgetModel);
  }

  final TetrisBlockModel tetrisBlockModel = TetrisBlockModel();
  final GamePageModel gamePageModel = GamePageModel();
  final BoardWidgetModel boardWidgetModel = BoardWidgetModel();
  final CountDownWidgetModel countDownWidgetModel = CountDownWidgetModel();

  late final GamePageComponent gamePageComponent =
      GamePageComponent(gamePageModel: gamePageModel);

  late FocusNode boardFocus;
  late InputEventLogic inputEventLogic;

  @override
  Widget build(BuildContext context) {
    gamePageComponent.update(null);

    return Stack(
      children: [
        Focus(
          autofocus: true,
          focusNode: boardFocus,
          onKeyEvent: inputEventLogic.keyBoardInputHandle,
          child: Listener(
            onPointerDown: inputEventLogic.pointerDownHandle,
            onPointerUp: inputEventLogic.pointerUpHandle,
            onPointerMove: inputEventLogic.pointerMoveHandle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("helo"), // todo: HUD
                BoardWidget(
                  boardWidgetModel: boardWidgetModel,
                  gamePageModel: gamePageModel,
                  tetrisBlockModel: tetrisBlockModel,
                  countDownWidgetModel: countDownWidgetModel,
                ),
                Container()
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
