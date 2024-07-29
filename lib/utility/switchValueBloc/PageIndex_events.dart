

abstract class SwitchValueGraphEvent {}
class UpdateSwitchValueGraph extends SwitchValueGraphEvent {
  late bool switchValue;
  UpdateSwitchValueGraph(this.switchValue);
}
