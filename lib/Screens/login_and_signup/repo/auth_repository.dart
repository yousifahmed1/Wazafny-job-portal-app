import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class AuthRepository {
  final Dio dio = Dio(
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
        data: {'email': email, 'password': password, "role": role},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final roleId = response.data['role_id']; // adjust based on your API
        final userId = response.data['user_id']; // adjust based on your API

        final respnseTwo = await _getSeekerMainData(roleId, token);

        final firstName = respnseTwo['firstName'];
        final lastName = respnseTwo['lastName'];

        await _saveFirstNameAndLastName(firstName, lastName);
        await _saveTokenAndId(token, roleId, userId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> signUpSeeker({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/register/Seeker',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
        },
      );

      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } on DioException catch (e) {
      print('Registration failed: ${e.message}');
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'error': e.message,
      };
    }
  }

  Future<Map<String, dynamic>> signUpCompany({
    required String companyName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/register/Company',
        data: {
          'company_name': companyName,
          'email': email,
          'password': password,
        },
      );

      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } on DioException catch (e) {
      print('Registration failed: ${e.message}');
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'error': e.message,
      };
    }
  }

  Future<Map<String, dynamic>> _getSeekerMainData(
      int userID, String token) async {
    try {
      final response = await dio.get(
        '/show-personal-info/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          "firstName": response.data['first_name'],
          "lastName": response.data['last_name'],
        };
      } else {
        throw Exception('Failed to load main data');
      }
    } catch (e) {
      log('Error fetching main data: $e');
      throw Exception('Something went wrong while fetching main data');
    }
  }

  Future<bool> logoutService() async {
    final userID = await getRoleId();
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
  Future<void> _saveTokenAndId(String token, int roleId, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setInt('role_id', roleId);
    await prefs.setInt('user_id', userId);
  }

  Future<void> _saveFirstNameAndLastName(
      String firstName, String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', firstName);
    await prefs.setString('last_name', lastName);
  }

  /// Clear stored login data
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('role_id');
    await prefs.remove('first_name');
    await prefs.remove('last_name');
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
  Future<int?> getRoleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role_id');
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<String?> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('first_name');
  }

  Future<String?> getLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_name');
  }
}
