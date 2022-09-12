import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/single_block_widget_model.dart';

class SingleBlockWidget extends StatefulWidget {
  final SingleBlockWidgetModel singleBlockWidgetModel;

  const SingleBlockWidget({
    Key? key,
    required this.singleBlockWidgetModel,
  }) : super(key: key);

  @override
  State<SingleBlockWidget> createState() => _SingleBlockWidgetState();
}

class _SingleBlockWidgetState extends State<SingleBlockWidget> {
  BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.singleBlockWidgetModel.updateCallback = (String hello) {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.singleBlockWidgetModel.size).toDouble(),
      height: (widget.singleBlockWidgetModel.size).toDouble(),
      color: widget.singleBlockWidgetModel.color,
      child: Center(
        child: (kDebugMode)
            ? Text(
                '${widget.singleBlockWidgetModel.position.x}:${widget.singleBlockWidgetModel.position.y}',
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.red,
                ),
              )
            : Container(),
      ),
    );
  }
}
