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
      // Create a custom JSON structure for create operation
      final createData = {
        'job_title': jobPost.jobTitle,
        'job_about': jobPost.about,
        'job_time': jobPost.employmentType,
        'job_type': jobPost.jobType,
        'job_country': jobPost.country,
        'job_city': jobPost.city,
        'company_id': jobPost.companyID,
        'skills': jobPost.skills,
        'questions': jobPost.questions
            .map((q) => q.question)
            .toList(), // Just the question strings
        'sections': jobPost.extraSections,
      };

      final response = await dio.post(
        '/create-job-post',
        data: createData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      final data = response.data;
      if (data is Map<String, dynamic> && data['message'] is String) {
        return data['message'];
      } else {
        throw Exception('Unexpected response format: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return 'Complete your profile first';
      }
      throw Exception('Error creating job post: ${e.message}');
    } catch (e) {
      throw Exception('Error creating job post: $e');
    }
  }

  Future<String> updateJobPost(int jobId, CreateJobPostModel jobPost) async {
    await _initialize();
    try {
      final response = await dio.put(
        '/update-job-post-info/$jobId',
        data: jobPost.toJson(), // Use the original toJson() method for update
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      final data = response.data;
      if (data is Map<String, dynamic> && data['message'] is String) {
        return data['message'];
      } else {
        throw Exception('Unexpected response format: \\${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error updating job post: \\${e.message}');
    } catch (e) {
      throw Exception('Error updating job post: $e');
    }
  }
}
