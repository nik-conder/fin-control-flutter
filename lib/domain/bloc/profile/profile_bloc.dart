import 'dart:async';
import 'dart:developer' as developer;
import 'package:fin_control/data/models/profile.dart';
import 'package:fin_control/data/repository/profiles_repository.dart';
import 'package:fin_control/domain/bloc/profile/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfilesRepository _profilesRepository;

  final _notesController = StreamController<List<Profile>>.broadcast();

  // Input stream. We add our notes to the stream using this variable.
  StreamSink<List<Profile>> get _inNotes => _notesController.sink;

  // Output stream. This one will be used within our pages to display the notes.
  Stream<List<Profile>> get notes => _notesController.stream;

  // Input stream for adding new notes. We'll call this from our pages.
  final _addNoteController = StreamController<Profile>.broadcast();
  StreamSink<Profile> get inAddNote => _addNoteController.sink;

  ProfileBloc(this._profilesRepository) : super(ProfilesInitial()) {
    on<TextFieldNameEvent>(
      (event, emit) {
        developer.log('name: ${event.name}');
        emit(TextFieldNameState(event.name));
      },
    );
    on<CreateProfileEvent>(_createProfile);
    on<LoadProfiles>(_loadProfiles);

    _profilesRepository.getAllProfiles().listen((event) {
      print('event: $event');
      _inNotes.add(event);
    });

    _profilesSubscription =
        _profilesRepository.getAllProfiles().listen((event) {
      print('event: $event');
      _inNotes.add(event);
      //add(List.of(Profile(name: '', id: 0)));
    });
  }

  var controller = StreamController<List<Profile>>();

  late final StreamSubscription<List<Profile>> _profilesSubscription;

  _loadProfiles(LoadProfiles event, Emitter<ProfileState> emit) {
    emit(event.users.isNotEmpty
        ? ProfilesLoaded(event.users)
        : ProfilesLoading());
  }

  _createProfile(CreateProfileEvent event, Emitter<ProfileState> emit) {
    try {
      final profile = Profile(name: event.name);

      final result = _profilesRepository.insertProfile(profile);

      developer.log('всё ок', time: DateTime.now());
      developer.log('Inserted Rows: $result', time: DateTime.now());
      emit(CreateProfileSuccess());
      _inNotes.add(List.generate(1, (index) => profile));
    } catch (e) {
      developer.log('',
          time: DateTime.now(), error: 'Ошибка при создании профиля');
      emit(CreateProfileError('Error'));
    }
  }

  @override
  Future<void> close() {
    _profilesSubscription.cancel();
    _notesController.close();
    _addNoteController.close();
    return super.close();
  }
}
