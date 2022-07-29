import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petris/configs/boardConfig.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';

class CountDownWidget extends StatefulWidget {
  CountDownWidgetModel countDownWidgetModel;
  GamePageModel gamePageModel;
  FocusNode nextFocus;

  CountDownWidget({
    required this.gamePageModel,
    required this.countDownWidgetModel,
    required this.nextFocus,
  });

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  @override
  Widget build(BuildContext context) {
    var mainWidget = (widget.countDownWidgetModel.countStarted)
        ? Text(widget.countDownWidgetModel.text)
        : ElevatedButton(
            onPressed: CountDownCallback,
            child: Text(widget.countDownWidgetModel.text),
          );
    return Visibility(
      visible: widget.countDownWidgetModel.hidden,
      child: Center(
        child: mainWidget,
      ),
    );
  }

  void CountDownCallback() {
    widget.countDownWidgetModel.timer =
        Timer.periodic(BoardConfig.loopDuration, (timer) {
      setState(() {
        widget.countDownWidgetModel.text =
            widget.countDownWidgetModel.counter.toString();
        widget.countDownWidgetModel.countStarted = true;
      });

      if (widget.countDownWidgetModel.counter < 0) {
        widget.countDownWidgetModel.timer.cancel();
        setState(() {
          widget.countDownWidgetModel.hidden = false;
        });

        widget.gamePageModel.isRunning = false;
        widget.nextFocus.requestFocus();
      }
      widget.countDownWidgetModel.counter--;
    });
  }
}
