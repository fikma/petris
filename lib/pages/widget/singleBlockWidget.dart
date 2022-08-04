import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

class SingleBlockWidget extends StatefulWidget {
  SingleBlockWidgetModel model;
  BoardWidgetModel boardWidgetModel;

  BoardWidgetLogic boardWidgetLogic;
  SingleBlockWidget({
    required this.model,
    required this.boardWidgetModel,
    required this.boardWidgetLogic,
  });

  @override
  State<SingleBlockWidget> createState() => _SingleBlockWidgetState();
}

class _SingleBlockWidgetState extends State<SingleBlockWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.boardWidgetLogic.setSingleBlockCallback(
      boardWidgetModel: widget.boardWidgetModel,
      callback: (String hello) {
        setState(() {});
      },
      x: widget.model.position.x.toInt(),
      y: widget.model.position.y.toInt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.model.size,
      height: widget.model.size,
      color: widget.model.color,
      child: Center(
        child: (kDebugMode)
            ? Text(
                '${widget.model.position.x}:${widget.model.position.y}',
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
