import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/model/job_applications_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class JobApplicationServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  late int userID;
  late String token;

  JobApplicationServices() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getRoleId() ?? 0;
  }

  Future<List<JobApplicationModel>> fetchSeekerJobApplications() async {
    await _initialize(); // ✅ Always ensure token/userID are ready

    try {
      final response = await dio.get(
        '/show-applications-seeker/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List applicationsJson = response.data['applications'];

        List<JobApplicationModel> applications = applicationsJson
            .map((applicationsJson) =>
                JobApplicationModel.fromJson(applicationsJson))
            .toList();

        return applications;
      } else {
        throw Exception('Failed to load applications');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<JobApplyModel> showJobApplication({required int applicationId}) async {
    await _initialize();
    try {
      final response = await dio.get(
        '/show-application-seeker/$applicationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        // Log the response data for debugging
        log("API Response: ${response.data}");
        log("Country from API: ${response.data['country']}");

        // here we assume the API structure is { "companies": [ {...}, {...} ] }
        return JobApplyModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load application');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<String> updateApplication({
    required String firstName,
    required String lastName,
    required String phone,
    required String country,
    required String city,
    required String emailAddress,
    File? resume,
    required List<QuestionsAnswerModel> questionsAnswers,
    required int applicationId,
  }) async {
    await _initialize();

    // Debug logging
    log("Updating application with country: $country");
    log("Updating application with city: $city");
    log("Updating application with firstName: $firstName");

    // Start building fields
    Map<String, dynamic> fields = {
      "first_name": firstName,
      "last_name": lastName,
      "email": emailAddress,
      "country": country,
      "city": city,
      "phone": phone,
    };

    log("Fields being sent: $fields");

    // Add answers
    if (questionsAnswers.isNotEmpty) {
      for (var answer in questionsAnswers) {
        fields['answers[${answer.questionId}]'] = answer.answer ?? '';
      }
    }

    // Create FormData
    FormData formData = FormData.fromMap(fields);

    // Add file only if resume is not null
    if (resume != null) {
      String fileName = resume.path.split('/').last;
      formData.files.add(
        MapEntry(
          "resume",
          await MultipartFile.fromFile(resume.path, filename: fileName),
        ),
      );
    }

    try {
      final response = await dio.post(
        '/update-application/$applicationId',
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
          return data['message'];
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      }

      throw Exception('Failed to apply to job');
    } catch (e) {
      log('Error applying to job: $e');
      throw Exception('Failed to apply to job');
    }
  }
}
