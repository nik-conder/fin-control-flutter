import 'package:fin_control/domain/bloc/debug/debug_event.dart';
import 'package:fin_control/domain/bloc/debug/debug_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class DebugBloc extends Bloc<DebugEvent, DebugState> {
  DebugBloc() : super(DebugInitial()) {
    on<DebugOnEvent>(_debugOn);
  }

  _debugOn(DebugOnEvent event, Emitter<DebugState> emit) {
    if (kDebugMode) {
      emit(state.copyWith(debugOn: !state.debugOn));
      developer.log("debugOn: ${state.debugOn}", name: "DebugBloc");
    } else {
      developer.log("debug mode is not avilable!",
          name: "DebugBloc", level: 2000);
    }
  }
}
