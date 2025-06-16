import 'package:dio/dio.dart';
import 'package:wazafny/core/constants/api_constants.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'dart:developer';

class SignupService {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  late String token;
  late int roleID;

  SignupService() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    roleID = await AuthRepository().getRoleId() ?? 0;
  }

  Future<String> updateHeadline({
    required String headline,
  }) async {
    await _initialize();

    try {
      final response = await dio.post(
        '/create-headline',
        data: {
          "seeker_id": roleID,
          "headline": headline,
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
          log("Headline updated successfully: ${response.statusCode}");
          return data['message'];
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      }

      throw Exception('Failed to update headline');
    } catch (e) {
      log('Error updating headline: $e');
      throw Exception('Failed to update headline');
    }
  }

  Future<String> updateLocation({
    required String country,
    required String city,
  }) async {
    await _initialize();

    try {
      final response = await dio.post(
        '/create-location',
        data: {
          "seeker_id": roleID,
          "country": country,
          "city": city,
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
          log("Location updated successfully: ${response.statusCode}");
          return data['message'];
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      }

      throw Exception('Failed to update location');
    } catch (e) {
      log('Error updating location: $e');
      throw Exception('Failed to update location');
    }
  }
}
