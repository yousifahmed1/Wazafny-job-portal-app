import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';
import 'dart:developer';
import '../model/profile_model.dart';

class ProfileService {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  late int userID;
  late String token;
  // var token = AuthRepository().getToken();

  ProfileService() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getSeekerId() ?? 0;
  }

  Future<SeekerProfileModel> fetchProfile() async {
    _initialize();

    try {
      final response = await dio.get(
        '/show-seeker-profile/$userID',
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

  Future<String> updateAbout({
    required String about,
  }) async {
    try {
      final response = await dio.post(
        '/update-about',
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
        '/update-personal-info',
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

  Future<String> deleteLink({
    required int linkId,
  }) async {
    try {
      final response = await dio.delete(
        '/delete-link/$linkId',
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
        '/update-cover-img',
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
        '/delete-cover-img/$userID',
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
        '/update-profile-img',
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
        '/delete-profile-img/$userID',
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
        '/update-resume',
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
        '/delete-resume/$userID',
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

  Future<String> addExperience({
    required String company,
    required String jobTitle,
    required String jobTime,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await dio.post(
        '/create-experience',
        data: {
          "seeker_id": userID,
          "company": company,
          "job_title": jobTitle,
          "job_time": jobTime,
          "start_date": startDate,
          "end_date": endDate
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

  Future<String> deleteExperience({
    required int experienceId,
  }) async {
    try {
      final response = await dio.delete(
        '/delete-experience/$experienceId',
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

  Future<String> updateExperience({
    required int experienceId,
    required String company,
    required String jobTitle,
    required String jobTime,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await dio.put(
        '/update-experience/$experienceId',
        data: {
          "company": company,
          "job_title": jobTitle,
          "job_time": jobTime,
          "start_date": startDate,
          "end_date": endDate
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

  Future<String> addUpdateEducation({
    required String university,
    required String college,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await dio.post(
        '/update-education',
        data: {
          "seeker_id": userID,
          "university": university,
          "college": college,
          "start_date": startDate,
          "end_date": endDate
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

  Future<String> deleteEducation() async {
    try {
      final response = await dio.delete(
        '/delete-education/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      log("$response");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data['message'] is String) {
          log("${response.statusCode}");
          return data['message']; // Return success message
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else if (response.statusCode == 404) {
        final data = response.data;

        if (data is Map<String, dynamic> && data['message'] is String) {
          log("${response.statusCode}");
          log("${response.data['message']}");
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

  Future<String> updateSkills({
    required List<String> skills,
  }) async {
    try {
      final response = await dio.post(
        '/update-skills',
        data: {
          "seeker_id": userID,
          "skills": skills,
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
}
