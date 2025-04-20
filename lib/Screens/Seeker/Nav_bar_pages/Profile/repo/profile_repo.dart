import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/profile_service.dart';
import '../model/profile_model.dart';
import '../services/get_profile_data.dart';

class ProfileRepository {
  final GetProfileData getService;
  final ProfileService profileServices;


  ProfileRepository(this.getService, this.profileServices);

  Future<SeekerProfileModel> getProfileData() async {
    return await getService.fetchProfile();
  }

  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String headline,
    required String country,
    required String city,
    String? resume,
    List<LinkModel>? links, // Add links as a parameter
  }) async {
    return await profileServices.updateProfile(
      firstName: firstName,
      lastName: lastName,
      headline: headline,
      country: country,
      city: city,
      links: links, // Pass links to the service
    );
  }

  Future<String> deleteLink({required int linkId}) async {
    return await profileServices.deleteLink(
        linkId: linkId); // Use the deleteService
  }

  Future<String> updateAbout({
    required String about,


  }) async {
    return await profileServices.updateAbout(
      About: about, // Pass links to the service
    );
  }
  
}
