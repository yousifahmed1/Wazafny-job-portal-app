import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/repo/profile_repo.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/get_profile_data.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/constants.dart';
// SeekerProfileModel will be used inside the provider, so no need to import directly here

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/repo/profile_repo.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/get_profile_data.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/profile_service.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/constants.dart';

void main() {
  // Configure Dio with base options
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://wazafny.online/api/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Dynamic seekerId (replace with actual retrieval logic)
  const seekerId = 123; // TODO: Retrieve from auth or secure storage

  // Instantiate services with seekerId
  final getProfileService = GetProfileData(dio, );
  final profileService = ProfileService(dio,);
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