import 'package:fin_control/data/models/session.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionLoadEvent extends SessionEvent {}

class SessionCreateEvent extends SessionEvent {
  final Session session;

  SessionCreateEvent(this.session);
}

class SessionDeleteEvent extends SessionEvent {}
