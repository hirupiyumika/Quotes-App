import '../db_helper/objectbox_helper.dart';
import '../model/profile.dart';
import '../objectbox.g.dart';

class ProfileService {
  ProfileService._internal();

  factory ProfileService.getInstance() {
    return _profileService;
  }

  static final ProfileService _profileService = ProfileService._internal();

  static Store store = ObjectboxHelper.getStore();
  final Box<Profile> profileBox = store.box<Profile>();

  Profile? getProfileById(int profileId) {
    return profileBox.get(profileId);
  }

  int createProfile(Profile profile) {
    profileBox.put(profile);
    return profile.id;
  }

  void updateProfile(Profile profile) {
    profileBox.put(profile);
  }

  void deleteProfileById(profileId) {
    profileBox.remove(profileId);
  }
}