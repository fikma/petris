import 'package:flutter/material.dart';
import 'package:petris/components/game_page_component.dart';
import 'package:petris/logics/input_event_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/count_down_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/main_menu_models.dart';
import 'package:petris/models/tetris_block_model.dart';
import 'package:petris/pages/widget/board_widget.dart';
import 'package:petris/pages/widget/hud_widget.dart';
import 'package:petris/pages/widget/main_menu_widget.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  final GamePageModel gamePageModel = GamePageModel();
  final MainMenuModel mainMenuModel = MainMenuModel();
  final HudWidgetModel hudWidgetModel = HudWidgetModel();
  final TetrisBlockModel tetrisBlockModel = TetrisBlockModel();
  final BoardWidgetModel boardWidgetModel = BoardWidgetModel();
  final CountDownWidgetModel countDownWidgetModel = CountDownWidgetModel();

  late final GamePageComponent gamePageComponent = GamePageComponent(
    gamePageModel: gamePageModel,
    boardWidgetModel: boardWidgetModel,
    tetrisBlockModel: tetrisBlockModel,
  );
  late final InputEventLogic inputEventLogic = InputEventLogic(
    boardWidgetModel: boardWidgetModel,
    gamePageModel: gamePageModel,
    mainMenuModel: mainMenuModel,
    tetrisBlockModel: tetrisBlockModel,
  );

  @override
  Widget build(BuildContext context) {
    gamePageComponent.update();

    return Scaffold(
      body: Container(
        // TODO: pindahkan ke model
        color: Colors.grey[900],
        child: Stack(
          children: [
            Focus(
              autofocus: true,
              focusNode: boardWidgetModel.boardFocus,
              onKeyEvent: inputEventLogic.keyBoardInputHandle,
              child: Listener(
                onPointerDown: inputEventLogic.pointerDownHandle,
                onPointerMove: inputEventLogic.pointerMoveHandle,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BoardWidget(
                      mainMenuModel: mainMenuModel,
                      gamePageModel: gamePageModel,
                      hudWidgetModel: hudWidgetModel,
                      boardWidgetModel: boardWidgetModel,
                      tetrisBlockModel: tetrisBlockModel,
                      countDownWidgetModel: countDownWidgetModel,
                    ),
                    const Divider(
                      // height: 5.0,
                      color: Colors.black54,
                    ),
                    HudWidget(
                      hudWidgetModel: hudWidgetModel,
                      boardWidgetModel: boardWidgetModel,
                      tetrisBlockModel: tetrisBlockModel,
                      inputEventLogic: inputEventLogic,
                    ),
                  ],
                ),
              ),
            ),
            MainMenuWidget(
              mainMenuModel: mainMenuModel,
              gamePageModel: gamePageModel,
              hudWidgetModel: hudWidgetModel,
              boardWidgetModel: boardWidgetModel,
              countDownWidgetModel: countDownWidgetModel,
            ),
          ],
        ),
      ),
    );
  }
}
