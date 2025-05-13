import 'package:dio/dio.dart';
import 'package:wazafny/Screens/Company/Dashboard/models/latests_jobs.dart';
import 'package:wazafny/Screens/Company/Dashboard/models/stats_model.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class DashboardServices {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  late int roleID;
  late String token;

  DashboardServices() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    roleID = await AuthRepository().getRoleId() ?? 0;
  }

  Future<StatsModel> getStats() async {
    await _initialize();
    print(roleID);

    try {
      final response = await dio.get(
        '/show-statics/$roleID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return StatsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load stats');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<List<LatestJobsModel>> getLatestJobs() async {
    await _initialize();

    try {
      final response = await dio.get(
        '/lastest-job-posts/$roleID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return List<LatestJobsModel>.from(
            (response.data as List).map((x) => LatestJobsModel.fromJson(x)));
      } else {
        throw Exception('Failed to load latest jobs');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
