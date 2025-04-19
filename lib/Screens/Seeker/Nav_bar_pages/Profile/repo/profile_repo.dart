import '../model/profile_model.dart';
import '../services/get_profile_data.dart';

class ProfileRepository {
  final GetProfileData service;

  ProfileRepository(this.service);

  Future<SeekerProfileModel> getProfileData() async {
    return await service.fetchProfile();
  }
}
