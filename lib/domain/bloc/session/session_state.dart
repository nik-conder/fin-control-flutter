import 'package:equatable/equatable.dart';
import 'package:fin_control/data/models/session.dart';

class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

class SessionInitial extends SessionState {}

class SessionLoaded extends SessionState {
  final Session session;

  const SessionLoaded({required this.session});

  SessionLoaded copyWith({
    Session? session,
  }) {
    return SessionLoaded(
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props => [session];
}

class SessionError extends SessionState {
  final String message;

  const SessionError(this.message);
}
