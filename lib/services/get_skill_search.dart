import 'package:dio/dio.dart';

class GetSearchSkills {
  final dio = Dio();
  final token = "117|VQGaaToigEEzlSmwmBXhzk0buTINWlviUv0d4qk18d77ff70";

  Future<List<String>> getSkills() async {
    final response = await dio.get(
      'https://wazafny.online/api/skill-search',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    List<String> skills=[];
    for (var i = 0; i < response.data.length; i++) {
      skills.add(response.data[i]['skill']);
    }


    return skills;
  }
}
