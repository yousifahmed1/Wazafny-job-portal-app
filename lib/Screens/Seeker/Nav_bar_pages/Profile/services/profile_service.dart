import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:developer';
import '../model/profile_model.dart';

class ProfileService {
  final Dio dio;
  final int userID;
  final String token;

  ProfileService(
    this.dio, {
    required this.userID,
    required this.token,
  });

  //updateAbout
  Future<String> updateAbout({
    required String about,
  }) async {
    try {
      final response = await dio.post(
        'https://wazafny.online/api/update-about/token',
        data: {
          "seeker_id": userID, // Replace with dynamic ID later
          "about": about
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  //updateProfile
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
          "seeker_id": userID, // Replace with dynamic ID later
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
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  Future<String> deleteLink({required int linkId}) async {
    try {
      final response = await dio.delete(
        'https://wazafny.online/api/delete-link/$linkId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  Future<String> uploadCoverImage({
    required File cover,
  }) async {
    String fileName = cover.path.split('/').last;

    FormData formData = FormData.fromMap({
      "cover_img": await MultipartFile.fromFile(cover.path, filename: fileName),
      "user_id": userID, // Include user_id in the FormData
    });
    try {
      final response = await dio.post(
        'https://wazafny.online/api/update-cover-img',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  Future<String> deleteCover() async {
    try {
      final response = await dio.delete(
        'https://wazafny.online/api/delete-cover-img/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  Future<String> uploadProfileImage({
    required File image,
  }) async {
    String fileName = image.path.split('/').last;

    FormData formData = FormData.fromMap({
      "profile_img":
          await MultipartFile.fromFile(image.path, filename: fileName),
      "user_id": userID, // Include user_id in the FormData
    });
    try {
      final response = await dio.post(
        'https://wazafny.online/api/update-profile-img',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  Future<String> deleteProfileImage() async {
    try {
      final response = await dio.delete(
        'https://wazafny.online/api/delete-profile-img/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  Future<String> uploadResume({
    required File resume,
  }) async {
    String fileName = resume.path.split('/').last;

    FormData formData = FormData.fromMap({
      "resume": await MultipartFile.fromFile(resume.path, filename: fileName),
      "seeker_id": userID, // Include user_id in the FormData
    });
    try {
      final response = await dio.post(
        'https://wazafny.online/api/update-resume',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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

  Future<String> deleteResume() async {
    try {
      final response = await dio.delete(
        'https://wazafny.online/api/delete-resume/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
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
