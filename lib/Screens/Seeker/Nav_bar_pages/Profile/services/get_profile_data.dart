import 'dart:developer';

import 'package:dio/dio.dart';
import '../model/profile_model.dart';

class GetProfileData {
  final Dio dio;

  GetProfileData(this.dio);

  Future<SeekerProfileModel> fetchProfile() async {
    try {
      final response = await dio.get('https://wazafny.online/api/show-seeker-profile/2');

      if (response.statusCode == 200 && response.data != null) {
        return SeekerProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      log('Error fetching profile: $e');
      throw Exception('Something went wrong while fetching profile');
    }
  }
}
