import 'package:dio/dio.dart';

class SignUpService {
  final dio = Dio();

  Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {

    try {
      final response = await dio.post(
        'https://wazafny.online/api/register/Seeker',
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
}
