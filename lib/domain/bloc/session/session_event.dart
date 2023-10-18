import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/models/session.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionCreateEvent extends SessionEvent {
  final Profile profile;

  SessionCreateEvent(this.profile);
}

class SessionDeleteEvent extends SessionEvent {}

class SessionLoadSuccessEvent extends SessionEvent {
  final Session session;

  SessionLoadSuccessEvent(this.session);
}

class SessionLoad extends SessionEvent {}
