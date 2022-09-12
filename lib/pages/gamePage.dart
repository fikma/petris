import 'package:flutter/material.dart';
import 'package:petris/components/gamePageComponent.dart';
import 'package:petris/logics/inputEventLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/pages/widget/CountDownWidget.dart';
import 'package:petris/pages/widget/boardWidget.dart';
import 'package:petris/pages/widget/hudWidget.dart';

class GamePage extends StatelessWidget {
  GamePage() {
    boardFocus = FocusNode();
    inputEventLogic = InputEventLogic(tetrisBlockModel, boardWidgetModel);

    hudWidgetModel = HudWidgetModel(tetrisBlockModel: tetrisBlockModel);
  }

  final TetrisBlockModel tetrisBlockModel = TetrisBlockModel();
  final GamePageModel gamePageModel = GamePageModel();
  final BoardWidgetModel boardWidgetModel = BoardWidgetModel();
  final CountDownWidgetModel countDownWidgetModel = CountDownWidgetModel();
  late final HudWidgetModel hudWidgetModel;

  late final GamePageComponent gamePageComponent = GamePageComponent(
    gamePageModel: gamePageModel,
    boardWidgetModel: boardWidgetModel,
  );

  late FocusNode boardFocus;
  late InputEventLogic inputEventLogic;

  @override
  Widget build(BuildContext context) {
    gamePageComponent.update();

    return Scaffold(
      body: Stack(
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
                  HudWidget(
                    hudWidgetModel: hudWidgetModel,
                  ), // todo: HUD
                  BoardWidget(
                    boardWidgetModel: boardWidgetModel,
                    gamePageModel: gamePageModel,
                    tetrisBlockModel: tetrisBlockModel,
                    countDownWidgetModel: countDownWidgetModel,
                    hudWidgetModel: hudWidgetModel,
                  ),
                  Container()
                ],
              ),
            ),
          ),
          CountDownWidget(
            boardWidgetModel: boardWidgetModel,
            countDownWidgetModel: countDownWidgetModel,
            hudWidgetModel: hudWidgetModel,
            gamePageModel: gamePageModel,
            nextFocus: boardFocus,
          ),
        ],
      ),
    );
  }
}
