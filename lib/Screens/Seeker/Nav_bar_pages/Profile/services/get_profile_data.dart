import 'dart:developer';

import 'package:dio/dio.dart';
import '../model/profile_model.dart';

class GetProfileData {
  final Dio dio;
  final int seeker_id;
  final String token;

  GetProfileData(
    this.dio, {
    required this.seeker_id,
    required this.token,
  });

  Future<SeekerProfileModel> fetchProfile() async {
    try {
      final response = await dio.get(
        'https://wazafny.online/api/show-seeker-profile/$seeker_id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

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
