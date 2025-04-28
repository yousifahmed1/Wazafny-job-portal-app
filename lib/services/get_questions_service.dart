import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/models/questions_model.dart';

class GetQuestions {
  final Dio dio = Dio();
   late int userID;
  late String token;


  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getSeekerId() ?? 0;
  }

  Future<List<QuestionsModel>> getQuestions({required int jobID}) async {
        await _initialize(); // ✅ Always ensure token/userID are ready

    try {
      final response = await dio.get(
        'https://wazafny.online/api/show-job-post-questions/34',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            // Accept 200 and 404 as valid status codes (don't throw DioException)
            return status != null && (status == 200 || status == 404);
          },
        ),
      );

      // Check the status code
      if (response.statusCode == 200|| response.statusCode == 204) {
        // Ensure response.data is a list
        if (response.data is List) {
          List<dynamic> questions = response.data;
          List<QuestionsModel> questionsList = questions
              .map((index) => QuestionsModel.fromJson(index))
              .toList();
          return questionsList;
        } else {
          log('Unexpected response format: ${response.data}');
          return [];
        }
      } else if (response.statusCode == 404) {
        // Handle "Job post not found" case
        log('Job post not found: ${response.data['message']}');
        return []; // Return empty list for 404
      } else {
        // Handle other unexpected status codes
        log('Unexpected status code: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      // Handle network or other Dio errors
      log('Dio error: ${e.message}');
      if (e.response != null) {
        log('Server error response: ${e.response?.data}');
      }
      return [];
    } catch (e) {
      // Handle any other unexpected errors
      log('Unexpected error: $e');
      return [];
    }
  }
}