import 'package:fin_control/data/dataProvider/dao/profiles_dao.dart';
import 'package:fin_control/data/models/profile.dart';

class ProfilesRepository {
  final ProfilesDAO profilesDao;

  ProfilesRepository(this.profilesDao);

  Future<int> insertProfile(Profile profile) async {
    return await profilesDao.insertProfile(profile);
  }

  Future<String> getName(int id) async {
    return await profilesDao.getName(id);
  }

  Stream<Profile> getProfile(int id) {
    return profilesDao.getProfile(id);
  }
}
