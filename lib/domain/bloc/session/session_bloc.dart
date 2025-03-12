import 'package:fin_control/core/logger.dart';
import 'package:fin_control/data/models/session.dart';
import 'package:fin_control/data/repository/session_repository.dart';
import 'package:fin_control/domain/bloc/session/session_event.dart';
import 'package:fin_control/domain/bloc/session/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final _sessionRepository = GetIt.instance<SessionRepository>();

  SessionBloc() : super(SessionInitial()) {
    on<SessionGetEvent>(_sessionGet);
    on<SessionCreateEvent>(_sessionCreate);
    on<SessionDeleteEvent>(_sessionDelete);
    _init();
  }

  _init() {
    add(SessionGetEvent());
  }

  _sessionGet(SessionGetEvent event, Emitter<SessionState> emit) async {
    try {
      final session = await _sessionRepository.getSession();
      if (session != null) {
        emit(SessionLoaded(session: session));
      } else {
        emit(const SessionError("Error get"));
      }
    } catch (e) {
      logger.e(e);
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
      logger.e(e);
    }
  }

  void dispose() {
    super.close();
  }
}
