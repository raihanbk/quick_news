part of 'bottom_nav_bloc.dart';

@immutable
abstract class BottomNavEvent {}

class TriggerAppEvent extends BottomNavEvent {
  final int index;

  TriggerAppEvent(this.index) : super();
}
