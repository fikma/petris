import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petris/configs/boardConfig.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class CountDownWidget extends StatefulWidget {
  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late CountDownWidgetModel model;
  late GamePageModel gamePageModel;

  @override
  Widget build(BuildContext context) {
    model = GamePageInheritedWidget.of(context)!.getCountDownWidgetModel;
    gamePageModel = GamePageInheritedWidget.of(context)!.getGamePageModel;

    var mainWidget = (model.countStarted)
        ? Text(model.text)
        : ElevatedButton(
            onPressed: CountDownCallback,
            child: Text(model.text),
          );
    return Visibility(
      visible: model.hidden,
      child: Center(
        child: mainWidget,
      ),
    );
  }

  void CountDownCallback() {
    model.timer = Timer.periodic(BoardConfig.loopDuration, (timer) {
      setState(() {
        model.text = model.counter.toString();
        model.countStarted = true;
      });

      if (model.counter < 0) {
        model.timer.cancel();
        setState(() {
          model.hidden = false;
        });

        gamePageModel.paused = false;
      }
      model.counter--;
    });
  }
}
