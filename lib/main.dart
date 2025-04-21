import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/repo/profile_repo.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/get_profile_data.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/profile_service.dart';

void main() {
  // Configure Dio with base options
  final dio = Dio();

  final seeker_id = 2;
  final token = "44|WCgd0QxfZ140X00nv46qZji8Th83zURTq7BIb5Yo26a111b6";

  // Instantiate services with seekerId
  final getProfileService = GetProfileData(dio, seeker_id: seeker_id, token: token);
  final profileService = ProfileService(dio, userID: seeker_id, token: token);
  final profileRepo = ProfileRepository(getProfileService, profileService);

  runApp(MyApp(profileRepo: profileRepo));
}

class MyApp extends StatelessWidget {
  final ProfileRepository profileRepo;

  const MyApp({super.key, required this.profileRepo});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProfileCubit(profileRepo)..fetchProfile(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          fontFamily: 'Somar Sans',
        ),
        home: const WelcomePage(),
      ),
    );
  }
}


// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(),
//   ),
// );
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//         scaffoldBackgroundColor: scaffoldColor,
//         fontFamily: 'Somar Sans',
//
//       ),
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       debugShowCheckedModeBanner: false,
//       home: NavBar(),
//     );
//   }
// }