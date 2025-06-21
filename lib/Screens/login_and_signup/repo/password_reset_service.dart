import 'package:dio/dio.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class PasswordResetService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  /// Send password reset OTP to email
  Future<Map<String, dynamic>> sendPasswordResetOtp(
      {required String email}) async {
    try {
      final response = await dio.post(
        '/generate-otp',
        data: {'email': email},
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'error': e.message,
      };
    }
  }

  /// Verify OTP for password reset
  Future<Map<String, dynamic>> verifyPasswordResetOtp(
      {required String email, required String otp}) async {
    try {
      final response = await dio.post(
        '/verify-otp',
        data: {'email': email, 'otp': otp},
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'error': e.message,
      };
    }
  }

  /// Reset password
  Future<Map<String, dynamic>> resetPassword(
      {required String email,
      required String newPassword,
      required String otp}) async {
    try {
      final response = await dio.post(
        '/reset-password',
        data: {'email': email, 'password': newPassword},
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'error': e.message,
      };
    }
  }
}
