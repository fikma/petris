import 'package:flutter/material.dart';
import 'package:petris/components/countDownWidgetComponent.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/hudWidgetModel.dart';

class CountDownWidget extends StatefulWidget {
  BoardWidgetModel boardWidgetModel;
  CountDownWidgetModel countDownWidgetModel;
  GamePageModel gamePageModel;
  HudWidgetModel hudWidgetModel;

  CountDownWidget({
    required this.boardWidgetModel,
    required this.gamePageModel,
    required this.countDownWidgetModel,
    required this.hudWidgetModel,
    required FocusNode nextFocus,
  }) {
    countDownWidgetModel.nextFocus = nextFocus;
  }

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  @override
  void initState() {
    super.initState();

    CountDownWidgetComponent(
      boardWidgetModel: widget.boardWidgetModel,
      gamePageModel: widget.gamePageModel,
      countDownWidgetModel: widget.countDownWidgetModel,
      hudWidgetModel: widget.hudWidgetModel,
    );

    widget.countDownWidgetModel.updateCallback = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    var mainWidget = (widget.countDownWidgetModel.countStarted)
        ? Text(widget.countDownWidgetModel.text)
        : ElevatedButton(
            onPressed: () {
              widget.countDownWidgetModel.counter = 3;
              widget.countDownWidgetModel.countStarted = true;
              widget.gamePageModel.gameStatePaused = true;
            },
            child: Text(widget.countDownWidgetModel.text),
          );
    return Visibility(
      visible: widget.countDownWidgetModel.visible,
      child: Center(
        child: mainWidget,
      ),
    );
  }
}
