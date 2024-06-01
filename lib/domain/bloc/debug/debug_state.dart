import 'package:equatable/equatable.dart';

class DebugState extends Equatable {
  const DebugState({
    this.debugOn = false,
  });

  final bool debugOn;

  DebugState copyWith({
    bool? debugOn,
  }) {
    return DebugState(
      debugOn: debugOn ?? this.debugOn,
    );
  }

  @override
  List<Object> get props => [debugOn];
}

class DebugInitial extends DebugState {}
