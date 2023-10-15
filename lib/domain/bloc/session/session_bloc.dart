import 'dart:async';

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
    _sessionRepository.getSession().listen((event) {
      print("ОТПРАВЛЕНО В СТРИМ");
      sessionStream.add(event);
    });
  }

  _sessionDelete(SessionDeleteEvent event, Emitter<SessionState> emit) async {
    try {
      final deleteSession = await _sessionRepository.deleteSessions();

      if (deleteSession == 1) {
        emit(SessionInitial());
      }
    } catch (e) {
      emit(const SessionError("Error delete"));
    }
  }

  _sessionCreate(SessionCreateEvent event, Emitter<SessionState> emit) async {
    try {
      await _sessionRepository.insertSession(Session(profileId: 1));
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
