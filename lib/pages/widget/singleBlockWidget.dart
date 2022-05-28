import 'package:flutter/material.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class SingleBlockWidget extends StatefulWidget {
  final SingleBlockWidgetModel model;
  const SingleBlockWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<SingleBlockWidget> createState() => _SingleBlockWidgetState();
}

class _SingleBlockWidgetState extends State<SingleBlockWidget> {
  void updateCallback() {
    print("test");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    BoardWidgetLogic().setSingleBlockCallback(
      widget.model.position.x.toInt(),
      widget.model.position.y.toInt(),
      updateCallback,
      GamePageInheritedWidget.of(context)?.getBoardWidgetModel.boardList,
    );
  }

  @override
  Widget build(BuildContext context) {
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
