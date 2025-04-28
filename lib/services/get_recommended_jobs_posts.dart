import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/company/model/company_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';

class GetRecommendedJobsPosts {
  final Dio dio = Dio();
  late int userID;
  late String token;

  GetRecommendedJobsPosts() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getSeekerId() ?? 0;
  }


  Future<Map<String, dynamic>> getRecommendedJobsPosts() async {
    await _initialize(); // ✅ Always ensure token/userID are ready

    try {
      final response = await dio.get(
        'https://wazafny.online/api/recommended-jobs-posts',
        data: {
          "seeker_id": userID, // Replace with dynamic ID later
          
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      log(response.data.toString());

      if (response.statusCode == 200) {
        // here we assume the API structure is { "companies": [ {...}, {...} ] }

        return response.data;
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
