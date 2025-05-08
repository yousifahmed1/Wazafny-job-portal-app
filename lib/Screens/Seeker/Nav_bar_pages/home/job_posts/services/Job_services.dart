// lib/Screens/Seeker/Nav_bar_pages/Home/services/job_service.dart

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_post_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/jobs_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class JobService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  late int userID;
  late String token;

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getRoleId() ?? 0;
  }

  Future<List<JobModel>> getJobs() async {
    await _initialize();
    try {
      log('Fetching jobs from API');
      final response = await _dio.post(
        '/recommended-jobs-posts',
        data: {
          "seeker_id": userID,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      log('Jobs API response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jobResponse = JobResponse.fromJson(response.data);
        return jobResponse.jobs;
      } else {
        log('Failed to load jobs: ${response.statusCode}');
        throw Exception('Failed to load jobs: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('Dio error fetching jobs: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Error fetching jobs: $e');
      throw Exception('Error fetching jobs: $e');
    }
  }

  Future<JobPostModel> getJobPostDetails({required int jobId}) async {
    await _initialize();
    try {
      final response = await _dio.get(
        '/show-job-post/$jobId/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return JobPostModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load job details');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching job details: $e');
    }
  }

  Future<String> applyToJob({
    required String firstName,
    required String lastName,
    required String phone,
    required String country,
    required String city,
    required String emailAddress,
    required File resume,
    required List<QuestionsAnswerModel> questionsAnswers,
    required int jobId,
  }) async {
    await _initialize();

    String fileName = resume.path.split('/').last;

    // Start building fields as Map
    Map<String, dynamic> fields = {
      "seeker_id": userID, // Include user_id in the FormData
      "first_name": firstName,
      "last_name": lastName,
      "email": emailAddress,
      "country": country,
      "city": city,
      "phone": phone,
      "job_id": jobId,
    };

    // Add answers as answers[questionId] format
    if (questionsAnswers.isNotEmpty) {
      for (var answer in questionsAnswers) {
        fields['answers[${answer.questionId}]'] = answer.answer ?? '';
      }
    }

    // Create FormData
    FormData formData = FormData.fromMap(fields)
      ..files.add(
        MapEntry(
          "resume",
          await MultipartFile.fromFile(resume.path, filename: fileName),
        ),
      );

    try {
      final response = await _dio.post(
        '/create-application', // correct API endpoint?
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type':
                'multipart/form-data', // correct type for file upload
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data['message'] is String) {
          log("${response.statusCode}");
          return data['message']; // Return success message
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
