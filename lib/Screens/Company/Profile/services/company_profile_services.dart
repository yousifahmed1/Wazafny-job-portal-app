import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class CompanyProfileServices {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  late int roleID;
  late String token;
  late int userID;

  CompanyProfileServices() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    roleID = await AuthRepository().getRoleId() ?? 0;
    userID = await AuthRepository().getUserId() ?? 0;
  }

  Future<CompanyModel> getCompanyProfile() async {
    await _initialize();

    try {
      final response = await dio.get(
        '/show-company-profile/$roleID', // You'll need to edit this endpoint
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return CompanyModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load company profile');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<String> uploadCompanyProfileImage(File image) async {
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
            'Content-Type': 'multipart/form-data',
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

      throw Exception('Failed to update profile image');
    } catch (e) {
      log('Error updating profile image: $e');
      throw Exception('Failed to update profile image');
    }
  }

  Future<String> uploadCompanyCoverImage(File image) async {
    String fileName = image.path.split('/').last;

    FormData formData = FormData.fromMap({
      "cover_img": await MultipartFile.fromFile(image.path, filename: fileName),
      "user_id": userID, // Include user_id in the FormData
    });

    try {
      final response = await dio.post(
        '/update-cover-img',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
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

      throw Exception('Failed to update cover image');
    } catch (e) {
      log('Error updating cover image: $e');
      throw Exception('Failed to update cover image');
    }
  }

  Future<String> deleteCompanyProfileImage() async {
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

      throw Exception('Failed to delete profile image');
    } catch (e) {
      log('Error deleting profile image: $e');
      throw Exception('Failed to delete profile image');
    }
  }

  Future<String> deleteCompanyCoverImage() async {
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

      throw Exception('Failed to delete cover image');
    } catch (e) {
      log('Error deleting cover image: $e');
      throw Exception('Failed to delete cover image');
    }
  }

  Future<void> updateCompanyInfo({
    required String name,
    required String email,
    required String headline,
    String? website,
  }) async {
    await _initialize();

    try {
      final response = await dio.post(
        '/update-presonal-info',
        data: {
          'company_id': roleID,
          'company_name': name,
          'company_email': email,
          'headline': headline,
          'company_website_link': website,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update company info');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<void> updateCompanyExtraInfo({
    String? industry,
    String? size,
    String? headquarters,
    int? founded,
    String? country,
    String? city,
    String? about,
  }) async {
    await _initialize();

    try {
      final response = await dio.post(
        '/update-extra-info',
        data: {
          "company_id": roleID,
          'company_industry': industry,
          'company_size': size,
          'company_heads': headquarters,
          'company_founded': founded,
          'company_country': country,
          'company_city': city,
          'about': about,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update company extra information');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
