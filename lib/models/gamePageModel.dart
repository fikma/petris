import 'package:petris/components/baseComponent.dart';

class GamePageModel {
  List<BaseComponent> components = [];
  bool isRunning = true;
  bool gameStatePaused = true;

  int tickTime = 0;
  Stopwatch stopwatch = Stopwatch();
}
