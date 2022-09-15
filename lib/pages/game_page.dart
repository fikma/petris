import 'package:flutter/material.dart';
import 'package:petris/components/game_page_component.dart';
import 'package:petris/logics/input_event_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/count_down_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';
import 'package:petris/pages/widget/count_down_widget.dart';
import 'package:petris/pages/widget/board_widget.dart';
import 'package:petris/pages/widget/hud_widget.dart';

class GamePage extends StatelessWidget {
  GamePage({Key? key}) : super(key: key);

  final TetrisBlockModel tetrisBlockModel = TetrisBlockModel();
  final GamePageModel gamePageModel = GamePageModel();
  final BoardWidgetModel boardWidgetModel = BoardWidgetModel();
  final CountDownWidgetModel countDownWidgetModel = CountDownWidgetModel();
  final HudWidgetModel hudWidgetModel = HudWidgetModel();

  late final GamePageComponent gamePageComponent = GamePageComponent(
    gamePageModel: gamePageModel,
    boardWidgetModel: boardWidgetModel,
  );
  late final InputEventLogic inputEventLogic =
      InputEventLogic(tetrisBlockModel, boardWidgetModel);

  @override
  Widget build(BuildContext context) {
    gamePageComponent.update();

    return Scaffold(
      body: Stack(
        children: [
          Focus(
            autofocus: true,
            focusNode: boardWidgetModel.boardFocus,
            onKeyEvent: inputEventLogic.keyBoardInputHandle,
            child: Listener(
              onPointerDown: inputEventLogic.pointerDownHandle,
              onPointerUp: inputEventLogic.pointerUpHandle,
              onPointerMove: inputEventLogic.pointerMoveHandle,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            nextFocus: boardWidgetModel.boardFocus,
          ),
        ],
      ),
    );
  }
}
