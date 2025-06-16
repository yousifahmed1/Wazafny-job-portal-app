// lib/main.dart

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_Job_posts_cubit/company_job_posts_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_job_post_cubit/company_view_job_post_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/job_application_view_model_cubit/job_application_view_model_cubit.dart';
import 'package:wazafny/Screens/Company/Profile/cubits/company_profile_cubit.dart';
import 'package:wazafny/Screens/Company/Dashboard/cubit/dashboard_cubit.dart';
import 'package:wazafny/Screens/Company/nav_bar_company.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/cubit/job_applications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/repo/profile_repo.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/services/profile_service.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/cubit/cubit/company_view_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/nav_bar.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/core/constants/constants.dart';

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
      final userID = await authRepo.getUserId();
      final roleID = await authRepo.getRoleId();
      final role = await authRepo.getRole();

      log("Token : $token");
      log("Role : $role");
      log("UserID : $userID");
      log("RoleID : $roleID");
      // Set token if available
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    // Services
    final profileService = ProfileService();

    // Repositories
    final profileRepo = ProfileRepository(profileService);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SeekerProfileCubit(profileRepo)..fetchProfile(),
        ),
        BlocProvider(
          create: (_) => SeekerJobCubit(),
        ),
        BlocProvider(
          create: (_) => SeekerCompanyViewCubit(),
        ),
        BlocProvider(
          create: (_) => SeekerJobPostCubit(),
        ),
        BlocProvider(
          create: (_) => SeekerJobApplicationsCubit(),
        ),
        BlocProvider(
          create: (_) => SeekerNotificationsCubit(),
        ),
        BlocProvider(
          create: (_) => CompanyDashboardCubit(),
        ),
        BlocProvider(
          create: (_) => CompanyJobPostsCubit(),
        ),
        BlocProvider(
          create: (_) => CompanyApplicationCubit(),
        ),
        BlocProvider(
          create: (_) => CompanyJobApplicationCubit(),
        ),
        BlocProvider(
          create: (_) => CompanyProfileCubit(),
        ),
        BlocProvider(
          create: (_) => CompanyViewJobPostCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          fontFamily: 'Somar Sans',
          primaryColor: primaryColor,
          colorScheme: const ColorScheme.light(
            primary: primaryColor,
          ),
        ),
        home: FutureBuilder<String?>(
          future: authRepo.getRole(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final role = snapshot.data;
            if (!isLoggedIn) {
              return const WelcomePage();
            }

            return role == "Seeker"
                ? const NavBarSeeker()
                : const NavBarCompany();
          },
        ),
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
