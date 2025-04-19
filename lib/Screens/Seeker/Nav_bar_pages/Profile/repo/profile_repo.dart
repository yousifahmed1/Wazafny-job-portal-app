import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/profile_service.dart';
import '../model/profile_model.dart';
import '../services/get_profile_data.dart';

class ProfileRepository {
  final GetProfileData getService;
  final ProfileService updateService;

  ProfileRepository(this.getService, this.updateService);

  Future<SeekerProfileModel> getProfileData() async {
    return await getService.fetchProfile();
  }

  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String headline,
    required String country,
    required String city,
  }) async {
    return await updateService.updateProfile(
      firstName: firstName,
      lastName: lastName,
      headline: headline,
      country: country,
      city: city,
    );
  }
}
