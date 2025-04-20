import 'package:dio/dio.dart';
import 'dart:developer';
import '../model/profile_model.dart';

class ProfileService {
  final Dio dio;
  final int seeker_id;

  ProfileService(this.dio, {required this.seeker_id});

  // Future<SeekerProfileModel> fetchProfile() async {
  //   try {
  //     final response =
  //         await dio.get('https://wazafny.online/api/show-seeker-profile/2');
  //     if (response.statusCode == 200 && response.data != null) {
  //       return SeekerProfileModel.fromJson(response.data);
  //     }
  //     throw Exception('Failed to load profile');
  //   } catch (e) {
  //     log('Error fetching profile: $e');
  //     throw Exception('Failed to fetch profile');
  //   }
  // }


Future<String> updateAbout({
    required String About,

  }) async {
    try {
      final response = await dio.post(
        'https://wazafny.online/api/update-about',
        data: {
          "seeker_id": seeker_id, // Replace with dynamic ID later
          "about": About
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data['message'] is String) {
          log("${response.statusCode}");
          return data['message']; // Return success message
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
  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String headline,
    required String country,
    required String city,
    List<LinkModel>? links,
  }) async {
    try {
      final response = await dio.post(
        'https://wazafny.online/api/update-personal-info',
        data: {
          "seeker_id": seeker_id, // Replace with dynamic ID later
          "first_name": firstName,
          "last_name": lastName,
          "headline": headline,
          "country": country,
          "city": city,
          "links": links != null
              ? links.map((link) {
            return {
              'link_name': link.name,
              'link': link.link,
              ...link.linkID != null ? {'link_id': link.linkID} : {},
            };
          }).toList()
              : [],
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data['message'] is String) {
          log("${response.statusCode}");
          return data['message']; // Return success message
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

  // Future<bool> deleteLink(int linkId) async {
  //   try {
  //     final response =
  //         await dio.delete('https://wazafny.online/api/delete-link/$linkId');

  //     if (response.statusCode == 200 &&
  //         response.data['message'] == 'Link deleted successfully') {
  //       log("${response.statusCode}");
  //         return response.data['message']; // Successfully deleted
  //     }
  //     throw Exception('Failed to delete link');
  //   } catch (e) {
  //     log('Error deleting link: $e');
  //     throw Exception('Failed to delete link');
  //   }
  // }

  Future<String> deleteLink({required int linkId}) async {
    try {
      final response = await dio.delete(
        'https://wazafny.online/api/delete-link/$linkId',
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data['message'] is String) {
          log("${response.statusCode}");
          return data['message']; // Return success message
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      }

      throw Exception('Failed to delete link');
    } catch (e) {
      log('Error deleting link: $e');
      throw Exception('Failed to delete link');
    }
  }
}
