import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/logics/input_event_logic.dart';
import 'package:petris/logics/tetris_block_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';
import 'package:petris/pages/widget/control_buttons.dart';
import 'package:petris/utils/board_config.dart';

class HudWidget extends StatefulWidget {
  final HudWidgetModel hudWidgetModel;
  final BoardWidgetModel boardWidgetModel;
  final TetrisBlockModel tetrisBlockModel;

  final InputEventLogic inputEventLogic;

  const HudWidget({
    super.key,
    required this.hudWidgetModel,
    required this.boardWidgetModel,
    required this.tetrisBlockModel,
    required this.inputEventLogic,
  });

  @override
  State<HudWidget> createState() => _HudWidgetState();
}

class _HudWidgetState extends State<HudWidget> {
  final BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  @override
  void initState() {
    super.initState();

    widget.hudWidgetModel.updateCallback = () {
      setState(() {});
    };

    widget.tetrisBlockModel.nextBlocks.add(TetrisBlockLogic().reset(
      tetrisBlocks: widget.tetrisBlockModel.currentBlocks,
    ));
    widget.tetrisBlockModel.nextBlocks.add(TetrisBlockLogic().reset(
      tetrisBlocks: widget.tetrisBlockModel.currentBlocks,
    ));

    widget.tetrisBlockModel.currentBlocks =
        widget.tetrisBlockModel.nextBlocks.removeFirst();

    widget.hudWidgetModel.tetrisBlocks =
        widget.tetrisBlockModel.nextBlocks.first;
  }

  @override
  Widget build(BuildContext context) {
    var nextBlocks = boardWidgetLogic.generateBoard(
      boardList: widget.hudWidgetModel.boardList,
      xGridSize: widget.hudWidgetModel.tetrisBlocks.tetrisSize.x.toInt(),
      yGridSize: widget.hudWidgetModel.tetrisBlocks.tetrisSize.y.toInt(),
      boardWidgetModel: widget.boardWidgetModel,
    );

    var container = Container(
      // Todo: fix magic numbers
      width: BoardConfig.xSize * BoardConfig.blockSize * 1.0,
      // height: BoardConfig.ySize * 5.0,
      color: (kDebugMode) ? Colors.amber : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Next:",
            style: TextStyle(
              fontSize: widget.hudWidgetModel.fontSize,
              color: widget.hudWidgetModel.fontColor,
            ),
          ),
          nextBlocks,
          SizedBox(
            width: 40,
            height: 30,
            child: ElevatedButton(
              onPressed: widget.inputEventLogic.pauseButtonHandle,
              // child: const Text("Pause"))
              child: const Icon(Icons.pause, size: 10.0),
            ),
          ),
          ControlButtons(
            inputEventLogic: widget.inputEventLogic,
          ),
        ],
      ),
    );

    return container;
  }
}
