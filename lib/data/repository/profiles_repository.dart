import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/models/profile.dart';
import 'dart:developer' as developer;

class ProfilesRepository {
  final ProfilesDAO profilesDao;

  ProfilesRepository(this.profilesDao);

  Future<int> insertProfile(Profile profile) async {
    return await profilesDao.insertProfile(profile);
  }

  Future<String> getName(int id) async {
    return await profilesDao.getName(id);
  }

  Future<Profile> getProfile(int id) {
    return profilesDao.getProfile(id);
  }

  Stream<List<Profile>> getAllProfiles() async* {
    yield* profilesDao.getAllProfiles();
  }
}
