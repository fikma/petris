import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

class SingleBlockWidget extends StatefulWidget {
  final SingleBlockWidgetModel singleBlockWidgetModel;

  SingleBlockWidget({
    required this.singleBlockWidgetModel,
  });

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
      width: widget.singleBlockWidgetModel.size,
      height: widget.singleBlockWidgetModel.size,
      color: widget.singleBlockWidgetModel.color,
      child: Center(
        child: (kDebugMode)
            ? Text(
                '${widget.singleBlockWidgetModel.position.x}:${widget.singleBlockWidgetModel.position.y}',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.red,
                ),
              )
            : Container(),
      ),
    );
  }
}
