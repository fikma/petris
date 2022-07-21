import 'dart:async';

class CountDownWidgetModel {
  late Timer timer;
  bool hidden = true;
  String text = "Start";
  bool countStarted = false;
  int counter = 3;
}
