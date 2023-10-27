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

  final StreamController<Session> _sessionStream = StreamController<Session>();

  Stream<Session> get session => _sessionStream.stream;

  SessionBloc() : super(SessionInitial()) {
    on<SessionGetEvent>(_sessionGet);
    on<SessionCreateEvent>(_sessionCreate);
    on<SessionDeleteEvent>(_sessionDelete);
  }

  _sessionGet(SessionGetEvent event, Emitter<SessionState> emit) async {
    try {
      final session = _sessionRepository.getSession();
      session.then((value) => {
            if (value != null) _sessionStream.sink.add(value),
          });
    } catch (e) {
      developer.log('', time: DateTime.now(), error: e.toString());
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
      add(SessionGetEvent());
    } catch (e) {
      developer.log('', time: DateTime.now(), error: e.toString());
    }
  }

  void dispose() {
    _sessionStream.close();
    super.close();
  }
}
