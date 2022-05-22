import 'package:flutter/material.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class SingleBlockWidget extends StatefulWidget {
  final SingleBlockWidgetModel model;
  const SingleBlockWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<SingleBlockWidget> createState() => _SingleBlockWidgetState();
}

class _SingleBlockWidgetState extends State<SingleBlockWidget> {
  final Color color = Colors.red;

  _SingleBlockWidgetState() {}

  void update() {
    print("test");
  }

  @override
  Widget build(BuildContext context) {
    widget.model.update = update;

    return Container(
      width: widget.model.size,
      height: widget.model.size,
      color: widget.model.color,
      child: Text(
        '${widget.model.position.x}:${widget.model.position.y}',
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.redAccent[50],
        ),
      ),
    );
  }
}
