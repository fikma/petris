import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petris/components/countDownWidgetComponent.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';

class CountDownWidget extends StatefulWidget {
  CountDownWidgetModel countDownWidgetModel;
  GamePageModel gamePageModel;

  CountDownWidget({
    required this.gamePageModel,
    required this.countDownWidgetModel,
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
    CountDownWidgetComponent(
      gamePageModel: widget.gamePageModel,
      countDownWidgetModel: widget.countDownWidgetModel,
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
