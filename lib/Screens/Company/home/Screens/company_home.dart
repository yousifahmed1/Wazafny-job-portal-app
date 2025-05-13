import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/home/cubit/dashboard_cubit.dart';
import 'package:wazafny/Screens/Company/home/cubit/dashboard_state.dart';
import 'package:wazafny/Screens/Company/home/widgets/stat_card.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/settings.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class CompanyDashboardPage extends StatefulWidget {
  const CompanyDashboardPage({super.key});

  @override
  State<CompanyDashboardPage> createState() => _CompanyDashboardPageState();
}

class _CompanyDashboardPageState extends State<CompanyDashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isInistialized = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyDashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardInitial && !isInistialized) {
          isInistialized = true;
          context.read<CompanyDashboardCubit>().fetchStats();

          return const Center(child: CircularProgressIndicator());
        }
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DashboardError) {
          return Center(child: Text(state.error));
        }
        if (state is DashboardLoaded) {
          final dashboardData = state.dashboardData;
          final stats = dashboardData.stats;
          final latestJobs = dashboardData.latestJobs;
          final companyName = dashboardData.companyName;
          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 105),
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SubHeadingText(
                            titleColor: darkerPrimary,
                            title: "Welcome",
                          ),
                          Text(
                            companyName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 25,
                                color: darkerPrimary),
                          )
                        ],
                      ),
                      const Spacer(),
                      const SettingsIcon(),
                    ],
                  ),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {},
                    child: const Button1(
                      text: "Create New Post",
                      btnColor: primaryColor,
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Statistics Section as Rows

                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              title: "Total Job Posted",
                              value: stats.jobsCount.toString(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              title: "Total Followers",
                              value: stats.followersCount.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              title: "Total Active Jobs",
                              value: stats.activeJobsCount.toString(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              title: "Applications Received",
                              value: stats.applicationsCount.toString(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const HeadingText1(
                    title: "Latest Job Post",
                  ),
                  const SizedBox(height: 12),

                  // Job Posts with Company Logo
                  ...latestJobs.map((post) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        // margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  //time ago
                                  Text(
                                    "${post.timeAgo} ago",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: darkerPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //job title
                              Text(
                                post.jobTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: darkerPrimary,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // job location + job type
                              Row(
                                children: [
                                  Text(
                                    "${post.jobCity}, ${post.jobCountry} (${post.jobType})",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: darkerPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
