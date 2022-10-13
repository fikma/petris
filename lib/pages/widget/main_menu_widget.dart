import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/logics/input_event_logic.dart';
import 'package:petris/pages/widget/check_box_widget.dart';
import 'package:petris/utils/board_config.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/count_down_widget_model.dart';

import '../../models/main_menu_models.dart';

class MainMenuWidget extends StatefulWidget {
  final MainMenuModel mainMenuModel;
  final GamePageModel gamePageModel;
  final CountDownWidgetModel countDownWidgetModel;
  final BoardWidgetModel boardWidgetModel;
  final HudWidgetModel hudWidgetModel;

  final InputEventLogic inputEventLogic;

  const MainMenuWidget({
    super.key,
    required this.mainMenuModel,
    required this.gamePageModel,
    required this.countDownWidgetModel,
    required this.boardWidgetModel,
    required this.hudWidgetModel,
    required this.inputEventLogic,
  });

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  late Row row1, row2, row3;

  @override
  void initState() {
    super.initState();

    widget.mainMenuModel.updateCallback = () {
      setState(() {});
    };

    int x = BoardConfig.xSize * BoardConfig.blockSize;
    int y = 4 * BoardConfig.blockSize;
    widget.mainMenuModel.size = Point(x, y);

    // IconButton(onPressed: onPressed, );

    var resumeButton = ElevatedButton(
      onPressed: () {
        setState(widget.inputEventLogic.resumeButtonCallback);
      },
      style: IconButton.styleFrom(
        shadowColor: Colors.black,
        elevation: 5.0,
      ),
      child: const Icon(Icons.play_arrow),
    );
    row1 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        resumeButton,
      ],
    );

    var monochromeButton = ElevatedButton(
        onPressed: widget.inputEventLogic.monochromeButtonHandle,
        child: const Text("Monochrome"));

    var randomColorButton = ElevatedButton(
        onPressed: widget.inputEventLogic.randomColorButtonHandle,
        child: const Text("Random Color"));
    row2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        monochromeButton,
        randomColorButton,
      ],
    );

    row3 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Enable experimental gesture : ",
          style: TextStyle(color: Colors.white),
        ),
        CheckBoxWidget(inputEventLogic: widget.inputEventLogic),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var mainMenuWidget = Center(
      child: Container(
        width: widget.mainMenuModel.size.x * 1.0,
        height: widget.mainMenuModel.size.y * 1.5,
        color: widget.mainMenuModel.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            row1,
            const Center(
              child: Text(
                "Warna tetris block.",
                style: TextStyle(color: Colors.white),
              ),
            ),
            row2,
            row3,
          ],
        ),
      ),
    );

    return Visibility(
      visible: widget.mainMenuModel.visible,
      child: mainMenuWidget,
    );
  }
}
