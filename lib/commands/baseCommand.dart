import 'package:petris/components/baseComponent.dart';

abstract class BaseCommand {
  void execute(BaseComponent component);
  void undo(BaseComponent component);
}
