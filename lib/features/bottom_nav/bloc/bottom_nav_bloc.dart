import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_event.dart';

part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState()) {
    on<TriggerAppEvent>(triggerAppEvent);
  }

  FutureOr<void> triggerAppEvent(
      TriggerAppEvent event, Emitter<BottomNavState> emit) {
    emit(BottomNavState(index: event.index));
    print(event.index);
  }
}
