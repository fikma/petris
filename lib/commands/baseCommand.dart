import 'package:petris/components/baseComponent.dart';

abstract class BaseCommand {
  void execute(Object component);
  void undo(Object component);
}
