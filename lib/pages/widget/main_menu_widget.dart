import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/count_down_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/pages/widget/count_down_widget.dart';
import 'package:petris/utils/board_config.dart';

import '../../models/main_menu_models.dart';

class MainMenuWidget extends StatefulWidget {
  final MainMenuModel mainMenuModel;
  final GamePageModel gamePageModel;
  final CountDownWidgetModel countDownWidgetModel;
  final BoardWidgetModel boardWidgetModel;
  final HudWidgetModel hudWidgetModel;

  const MainMenuWidget({
    super.key,
    required this.mainMenuModel,
    required this.gamePageModel,
    required this.countDownWidgetModel,
    required this.boardWidgetModel,
    required this.hudWidgetModel,
  });

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  late Row row1, row2;

  @override
  void initState() {
    super.initState();

    widget.mainMenuModel.updateCallback = () {
      setState(() {});
    };

    int x = BoardConfig.xSize * BoardConfig.blockSize;
    int y = 4 * BoardConfig.blockSize;
    widget.mainMenuModel.size = Point(x, y);

    var resumeButton = ElevatedButton(
        onPressed: () {
          setState(() {
            widget.mainMenuModel.visible = false;
            widget.gamePageModel.gameStatePaused = false;
            BoardWidgetLogic().resetBoard(
              boardList: widget.boardWidgetModel.boardList,
            );
          });
        },
        child: const Text("resume"));
    row1 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        resumeButton,
      ],
    );

    var monochromeButton =
        ElevatedButton(onPressed: () {}, child: const Text("Monochrome"));
    var randomColor =
        ElevatedButton(onPressed: () {}, child: const Text("Random Color"));
    row2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        monochromeButton,
        randomColor,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var mainMenuWidget = Center(
      child: Container(
        width: widget.mainMenuModel.size.x * 1.0,
        height: widget.mainMenuModel.size.y * 1.0,
        color: widget.mainMenuModel.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            row1,
            const Center(
              child: Text("Warna tetris block."),
            ),
            row2,
          ],
        ),
      ),
    );

    var countDownWidget = CountDownWidget(
      gamePageModel: widget.gamePageModel,
      hudWidgetModel: widget.hudWidgetModel,
      boardWidgetModel: widget.boardWidgetModel,
      nextFocus: widget.boardWidgetModel.boardFocus,
      countDownWidgetModel: widget.countDownWidgetModel,
    );

    var mainWidget =
        (widget.mainMenuModel.isCountDown) ? countDownWidget : mainMenuWidget;
    return Visibility(
      visible: widget.mainMenuModel.visible,
      child: mainWidget,
    );
  }
}
