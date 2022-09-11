import 'package:flutter/cupertino.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

class HudWidget extends StatefulWidget {
  final HudWidgetModel hudWidgetModel;
  const HudWidget({
    required this.hudWidgetModel,
    Key? key,
  }) : super(key: key);

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

    widget.hudWidgetModel.boardList = BoardWidgetLogic().initBoardList(
      blockSize: 10,
      blockColor: HudConfig.boardColor,
      xSize: 4,
      ySize: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    var board = BoardWidgetLogic().generateBoard(
      boardList: widget.hudWidgetModel.boardList,
      xGridSize: 4,
      yGridSize: 4,
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
          nextBlocks,
        ],
      ),
    );

    return container;
  }
}
