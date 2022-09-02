import 'dart:async';

import 'package:flutter/widgets.dart';

class CountDownWidgetModel {
  late Timer? timer;
  bool visible = true;
  String text = "Start";
  bool countStarted = false;
  int counter = 3;
  late FocusNode nextFocus;

  Function? updateCallback;
}
