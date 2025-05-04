import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/model/notifications_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class NotificationsServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  late int userID;
  late String token;

  NotificationsServices() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getSeekerId() ?? 0;
  }

  Future<List<NotificationModel>> fetchNotofications() async {
    await _initialize(); // ✅ Always ensure token/userID are ready

    try {
      final response = await dio.get(
        '/show-notifications/$userID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List notificationsJson = response.data['notifications'];

        List<NotificationModel> notifications = notificationsJson
            .map((applicationsJson) =>
                NotificationModel.fromJson(applicationsJson))
            .toList();

        return notifications;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Failed to load Notifications');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<String> deleteAllNotifications() async {
    await _initialize(); // ✅ Always ensure token/userID are ready

    try {
      final response = await dio.delete(
        '/delete-all-notifications/$userID',
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
          log("${response.statusCode}");
          return data['message']; // Return success message
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      }

      throw Exception('Failed to delete Notifications');
    } catch (e) {
      log('Error deleting link: $e');
      throw Exception('Failed to delete Notifications');
    }
  }
}
