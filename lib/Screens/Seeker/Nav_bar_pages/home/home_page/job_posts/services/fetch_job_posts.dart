// lib/Screens/Seeker/Nav_bar_pages/Home/services/job_service.dart

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/model/job_post_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';

class JobService {
  final Dio _dio = Dio();

  late int userID;
  late String token;
  final String _baseApiUrl =
      'https://wazafny.online/api'; // Update this to match your API URL

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getSeekerId() ?? 0;
  }

  Future<List<JobModel>> getJobs() async {
    await _initialize();
    try {
      log('Fetching jobs from API');
      final response = await _dio.post(
        '$_baseApiUrl/recommended-jobs-posts',
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
}
