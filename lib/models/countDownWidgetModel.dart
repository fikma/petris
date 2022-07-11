import 'dart:async';

class CountDownWidgetModel {
  late Timer timer;
  Duration countDownDuration = const Duration(seconds: 1);
  bool hidden = true;
  String text = "Start";
  bool countStarted = false;
  int counter = 3;
}
