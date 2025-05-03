// lib/main.dart

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/repo/profile_repo.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/profile_service.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/company/cubit/cubit/company_view_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/nav_bar.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/constants.dart';

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
      final userID = await authRepo.getSeekerId();

      log("Token : $token");
      log("UserID : $userID");

      // Set token if available
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    // Services
    final profileService = ProfileService(dio);
    
    // Repositories
    final profileRepo = ProfileRepository(profileService);


    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProfileCubit(profileRepo)..fetchProfile(),
        ),
        BlocProvider(
          create: (_) => JobCubit(),
        ),
        BlocProvider(
          create: (_) => CompanyViewCubit(),
        ),
        BlocProvider(
          create: (_) => JobPostCubit(),
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
          return const MaterialApp(
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