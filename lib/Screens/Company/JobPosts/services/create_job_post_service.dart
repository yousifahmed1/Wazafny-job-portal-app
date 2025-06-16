import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/create_job_post_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class CreateJobPostService {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  late int roleID;
  late String token;

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    roleID = await AuthRepository().getRoleId() ?? 0;
  }

  Future<String> createJobPost(CreateJobPostModel jobPost) async {
    await _initialize();

    try {
      final response = await dio.post(
        '/create-job-post',
        data: jobPost.toJson(),
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
          return data['message'];
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else if (response.statusCode == 400) {
        return 'Complete your profile first';
      } else {
        throw Exception('Failed to create job post');
      }
    } catch (e) {
      throw Exception('Error creating job post: $e');
    }
  }
}
