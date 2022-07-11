import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late CountDownWidgetModel model;

  // widget state
  late Timer timer;
  Duration countDownDuration = const Duration(seconds: 1);
  bool hidden = true;
  String text = "Start";
  bool countStarted = false;
  int counter = 3;

  @override
  Widget build(BuildContext context) {
    model = GamePageInheritedWidget.of(context)!.getCountDownWidgetModel;

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
    model.timer = Timer.periodic(model.countDownDuration, (timer) {
      setState(() {
        model.text = model.counter.toString();
        model.countStarted = true;
      });

      if (model.counter < 0) {
        model.timer.cancel();
        setState(() {
          model.hidden = false;
        });
      }
      model.counter--;
    });
  }
}
