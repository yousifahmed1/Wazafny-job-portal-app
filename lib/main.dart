import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/repo/profile_repo.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/get_profile_data.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/nav_bar.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/profile_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _determineStartScreen() async {
    final authRepo = AuthRepository();
    final isLoggedIn = await authRepo.isLoggedIn();

    // Create Dio
    final dio = Dio();

    if (isLoggedIn) {
      final token = await authRepo.getToken();
      // Set token if available
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    final profileService = ProfileService(dio);
    final profileRepo = ProfileRepository(profileService);

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
        home: isLoggedIn ? const NavBar() : const WelcomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _determineStartScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Something went wrong')),
            ),
          );
        } else {
          return snapshot.data!;
        }
      },
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
