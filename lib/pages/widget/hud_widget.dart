import 'package:flutter/cupertino.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/utils/board_config.dart';

class HudWidget extends StatefulWidget {
  final HudWidgetModel hudWidgetModel;
  final BoardWidgetModel boardWidgetModel;

  const HudWidget({
    super.key,
    required this.hudWidgetModel,
    required this.boardWidgetModel,
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

    widget.hudWidgetModel.boardList = boardWidgetLogic.initBoardList(
      blockSize: 10,
      blockColor: HudConfig.boardColor,
      xSize: 4,
      ySize: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: xGridSize dan yGridSize harus berasal dari hudWidgetModel
    var board = boardWidgetLogic.generateBoard(
      boardList: widget.hudWidgetModel.boardList,
      xGridSize: 4,
      yGridSize: 4,
      boardWidgetModel: widget.boardWidgetModel,
    );
    var nextBlocks = Container(
      child: board,
    );
    var container = SizedBox(
      width: (BoardConfig.xSize * BoardConfig.blockSize).toDouble(),
      child: Row(
        children: [
          Text(
            "next",
            style: TextStyle(
              fontSize: widget.hudWidgetModel.fontSize,
            ),
          ),
          Container(),
          nextBlocks,
        ],
      ),
    );

    return container;
  }
}
