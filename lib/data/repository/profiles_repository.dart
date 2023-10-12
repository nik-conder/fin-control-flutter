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

  Future<Profile> getProfile(int id) {
    return profilesDao.getProfile(id);
  }

  Stream<List<Profile>> getAllProfiles() async* {
    yield* profilesDao.getAllProfiles();
  }

  Stream<double> getBalance(int id) async* {
    yield* profilesDao.getBalance(id);
  }

  Future<num> updateBalance(int id, double balance) async {
    return profilesDao.updateBalance(id, balance);
  }
}
