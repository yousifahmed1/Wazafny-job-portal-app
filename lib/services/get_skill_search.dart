import 'package:dio/dio.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/api_constants.dart';

class GetSearchSkills {
  late int userID;
  late String token;
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  GetSearchSkills() {
    _initialize();
  }

  Future<void> _initialize() async {
    token = await AuthRepository().getToken() ?? "";
    userID = await AuthRepository().getRoleId() ?? 0;
  }

  Future<List<String>> getSkills() async {
    await _initialize();
    final response = await dio.get(
      '/skill-search',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    List<String> skills = [];
    for (var i = 0; i < response.data.length; i++) {
      skills.add(response.data[i]['skill']);
    }

    return skills;
  }
}
