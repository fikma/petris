import 'dart:math';

abstract class BaseCommand {
  Object? tetrisModel;

  void execute(Point direction);
  void undo();
}
