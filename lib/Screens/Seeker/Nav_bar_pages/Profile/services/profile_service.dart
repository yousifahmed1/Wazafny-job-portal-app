import 'package:dio/dio.dart';
import 'dart:developer';
import '../model/profile_model.dart';

class ProfileService {
  final Dio dio;

  ProfileService(this.dio);

  Future<SeekerProfileModel> fetchProfile() async {
    try {
      final response = await dio.get('https://wazafny.online/api/show-seeker-profile/2');
      if (response.statusCode == 200 && response.data != null) {
        return SeekerProfileModel.fromJson(response.data);
      }
      throw Exception('Failed to load profile');
    } catch (e) {
      log('Error fetching profile: $e');
      throw Exception('Failed to fetch profile');
    }
  }

  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String headline,
    required String country,
    required String city,
    String? about,
    List<LinkModel>? links,
  }) async {
    try {
      final response = await dio.post(
        'https://wazafny.online/api/update-personal-info',
        data: {
          "seeker_id": 2, // Replace with dynamic ID later
          "first_name": firstName,
          "last_name": lastName,
          "headline": headline,
          "country": country,
          "city": city,
          "links": [
          ],
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data['message'] is String) {

          print(data);
          log("${response.statusCode}");
          return data['message'];
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      }

      throw Exception('Failed to update profile');
    } catch (e) {
      log('Error updating profile: $e');
      throw Exception('Failed to update profile');
    }
  }
}
