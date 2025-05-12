import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/company_job_posts_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class CompanyJobPostServices {
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

  Future<List<CompanyJobPostsModel>> getCompanyJobPosts() async {
    await _initialize();

    try {
      final response = await dio.get(
        '/show-job-posts/$roleID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List jobsJson = response.data['jobposts'];
        List<CompanyJobPostsModel> jobs = jobsJson
            .map((jobsJson) => CompanyJobPostsModel.fromJson(jobsJson))
            .toList();
        return jobs;
      } else {
        throw Exception('Failed to load company job posts');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
