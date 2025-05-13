import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_Job_posts_cubit/company_job_posts_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/job_application_view_model_cubit/job_application_view_model_cubit.dart';
import 'package:wazafny/Screens/Company/Profile/cubits/company_profile_cubit.dart';
import 'package:wazafny/Screens/Company/home/cubit/dashboard_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/cubit/job_applications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/cubit/cubit/company_view_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_cubit.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateColor.transparent,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 150,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () async {
                          final response =
                              await AuthRepository().logoutService();
                          log(response.toString());
                          if (response) {
                            final role = await AuthRepository().getRole();
                            if (role == "Company") {
                              context.read<CompanyDashboardCubit>().reset();
                              context.read<CompanyProfileCubit>().reset();
                              context
                                  .read<CompanyJobApplicationCubit>()
                                  .reset();
                              context.read<CompanyApplicationCubit>().reset();
                              context.read<CompanyJobPostsCubit>().reset();
                            } else if (role == "Seeker") {
                              context.read<SeekerProfileCubit>().reset();
                              context.read<SeekerCompanyViewCubit>().reset();
                              context.read<SeekerJobCubit>().reset();
                              context.read<SeekerJobPostCubit>().reset();
                              context
                                  .read<SeekerJobApplicationsCubit>()
                                  .reset();
                              context.read<SeekerNotificationsCubit>().reset();
                            }
                            // Reset dashboard state

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()),
                            );
                          } else {
                            log("Error logging out");
                          }
                        },
                        child: const Row(
                          children: [
                            HeadingText(title: "Logout"),
                            Spacer(),
                            Icon(
                              Icons.logout_sharp,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: SvgPicture.asset(
        'assets/Icons/settings.svg',
        width: 50,
        height: 50,
      ),
      //const CircleAvatar(
      //   radius: 30,
      //   backgroundColor: darkerPrimary,
      //   child: Text(
      //     "YA",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.w600,
      //       fontSize: 22,
      //     ),
      //   ),
      // ),
    );
  }
}
