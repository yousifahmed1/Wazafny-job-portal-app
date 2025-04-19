import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/repo/profile_repo.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/get_profile_data.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/constants.dart';
// SeekerProfileModel will be used inside the provider, so no need to import directly here

void main() {
  final dio = Dio();
  final profileService = GetProfileData(dio);
  final profileRepo = ProfileRepository(profileService);

  runApp(MyApp(profileRepo: profileRepo));
}

class MyApp extends StatelessWidget {
  final ProfileRepository profileRepo;

  const MyApp({super.key, required this.profileRepo});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Add ProfileCubit here
        BlocProvider(
          create: (_) => ProfileCubit(profileRepo)..fetchProfile(),
        ),
        // You can add other cubits here if needed in the future
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