import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/single_block_widget_model.dart';

class SingleBlockWidget extends StatefulWidget {
  final SingleBlockWidgetModel singleBlockWidgetModel;
  final BoardWidgetModel boardWidgetModel;

  const SingleBlockWidget({
    super.key,
    required this.singleBlockWidgetModel,
    required this.boardWidgetModel,
  });

  @override
  State<SingleBlockWidget> createState() => _SingleBlockWidgetState();
}

class _SingleBlockWidgetState extends State<SingleBlockWidget> {
  BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.singleBlockWidgetModel.updateCallback = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    var blockColor = (widget.boardWidgetModel.isBlockMonochrome &&
            widget.singleBlockWidgetModel.isPartOfTetrisBlocks)
        ? widget.singleBlockWidgetModel.monoColor
        : widget.singleBlockWidgetModel.color;

    return Container(
      width: widget.singleBlockWidgetModel.size * 1.0,
      height: widget.singleBlockWidgetModel.size * 1.0,
      decoration: BoxDecoration(
        border: Border.all(width: .8),
        color: blockColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Center(
        child: (kDebugMode)
            ? Text(
                '${widget.singleBlockWidgetModel.position.x}:${widget.singleBlockWidgetModel.position.y}\n${widget.singleBlockWidgetModel.type.index}',
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
    );
  }
}
