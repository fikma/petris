import 'package:flutter/cupertino.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

class HudWidget extends StatefulWidget {
  final HudWidgetModel hudWidgetModel;
  final BoardWidgetModel boardWidgetModel;
  const HudWidget({
    required this.hudWidgetModel,
    required this.boardWidgetModel,
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
  }

  @override
  Widget build(BuildContext context) {
    var nextBlocks = Container();
    var container = Container(
      width: BoardConfig.xSize * BoardConfig.blockSize,
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
