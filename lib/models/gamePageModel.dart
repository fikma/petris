import 'dart:async';

import 'package:petris/components/baseComponent.dart';

class GamePageModel {
  late Timer loop;
  List<BaseComponent> components = [];
  bool paused = true;
}
