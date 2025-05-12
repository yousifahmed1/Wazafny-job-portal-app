import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/Job_applications_model.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/job_application_view_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class ApplicationService {
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

  Future<CompanyJobApplicationModel> getJobApplication(
      {required int jobId}) async {
    await _initialize();

    try {
      final response = await dio.get(
        '/show-applications-company/$jobId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return CompanyJobApplicationModel.fromJson(response.data);
      } else if (response.statusCode == 204) {
      // Return an empty model if no content
      return CompanyJobApplicationModel(
        jobTitle: "",
        applications: [],
      );
    } else {
        throw Exception('Failed to load job applications');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
  Future<JobApplicationViewModel> showJobApplication({required int applicationId}) async {
    await _initialize();
    try {
      final response = await dio.get(
        '/show-application-company/$applicationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return JobApplicationViewModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load application');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }


}
