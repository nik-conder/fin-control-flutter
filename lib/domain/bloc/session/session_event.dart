import 'package:fin_control/data/models/profile.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionCreateEvent extends SessionEvent {
  final Profile profile;

  SessionCreateEvent(this.profile);
}

class SessionDeleteEvent extends SessionEvent {}

class SessionGetEvent extends SessionEvent {}
