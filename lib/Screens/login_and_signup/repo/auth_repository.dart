import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class AuthRepository {
  final Dio dio =Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  AuthRepository();

  /// Login and save token + seekerId if successful
  Future<bool> login(String email, String password, String role) async {
    try {
      final response = await dio.post(
        '/login', // Replace with your actual endpoint
        data: {
          'email': email,
          'password': password,
          "role" : role
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final seekerId = response.data['user_id']; // adjust based on your API

        await _saveTokenAndId(token, seekerId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> logoutService() async {
    final userID = await getSeekerId();
    final token = await getToken();

    try {
      final response = await dio.post(
        '/logout', // Replace with your actual endpoint
        data: {
          'user_id': userID,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      log(response.toString());

      if (response.statusCode == 200) {

         // adjust based on your API

        await logout();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('logout error: $e');
      return false;
    }
  }

  /// Save both token and seeker ID
  Future<void> _saveTokenAndId(String token, int seekerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setInt('seeker_id', seekerId);
  }

  /// Clear stored login data
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('seeker_id');
  }

  /// Check if token exists
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }

  /// Get token if needed for authenticated requests
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// Get seeker/user ID
  Future<int?> getSeekerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('seeker_id');
  }
}
