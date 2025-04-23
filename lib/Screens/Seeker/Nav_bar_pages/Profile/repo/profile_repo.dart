import 'dart:io';

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
      about: about, // Pass links to the service
    );
  }

  Future<String> uploadCoverImage({
    required File cover,
  }) async {
    return await profileServices.uploadCoverImage(
      cover: cover,
    );
  }

  Future<String> deleteCover() async {
    return await profileServices.deleteCover(); // Use the deleteService
  }

  Future<String> uploadProfileImage({
    required File image,
  }) async {
    return await profileServices.uploadProfileImage(
      image: image,
    );
  }

  Future<String> deleteProfileImage() async {
    return await profileServices.deleteProfileImage(); // Use the deleteService
  }

  Future<String> uploadResume({
    required File resume,
  }) async {
    return await profileServices.uploadResume(
      resume: resume,
    );
  }

  Future<String> deleteResume() async {
    return await profileServices.deleteResume(); // Use the deleteService
  }


  Future<String> addExperience({
    required String company,
    required String jobTitle,
    required String jobTime,
    required String startDate,
    required String endDate,
  }) async {
    return await profileServices.addExperience(
      company: company,
      jobTitle: jobTitle,
      jobTime: jobTime,
      startDate: startDate,
      endDate: endDate,
    );
  }

Future<String> deleteExperience({required int experienceId}) async {
    return await profileServices.deleteExperience(
        experienceId: experienceId); // Use the deleteService
  }

  Future<String> updateExperience({

    required String company,
    required int experienceId,
    required String jobTitle,
    required String jobTime,
    required String startDate,
    required String endDate,
  }) async {
    return await profileServices.updateExperience(
      experienceId: experienceId,
      company: company,
      jobTitle: jobTitle,
      jobTime: jobTime,
      startDate: startDate,
      endDate: endDate,
    );
  }

}
