import 'dart:async';

import 'dart:developer' as developer;
import 'package:fin_control/data/models/session.dart';
import 'package:fin_control/data/repository/session_repository.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/domain/bloc/session/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final _sessionRepository = GetIt.instance<SessionRepository>();

  StreamController<Session> sessionStream = StreamController<Session>();

  Stream<Session> get session => sessionStream.stream;

  SessionBloc() : super(SessionInitial()) {
    on<SessionCreateEvent>(_sessionCreate);
    on<SessionDeleteEvent>(_sessionDelete);
  }

  _sessionGet(SessionLoad event, Emitter<SessionState> emit) async {
    try {
      return await _sessionRepository.getSession();
    } catch (e) {
      developer.log('', time: DateTime.now(), error: e.toString());
      return Session(id: 0, profileId: 0);
    }
  }

  _sessionDelete(SessionDeleteEvent event, Emitter<SessionState> emit) async {
    try {
      await _sessionRepository.deleteSessions();
    } catch (e) {
      emit(const SessionError("Error delete"));
    }
  }

  _sessionCreate(SessionCreateEvent event, Emitter<SessionState> emit) async {
    try {
      await _sessionRepository.deleteSessions();
      await _sessionRepository
          .insertSession(Session(profileId: event.profile.id!));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    sessionStream.close();
    super.close();
  }
}
