import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:wazafny/Screens/Company/home/widgets/stat_card.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/jobs_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/widgets/jobs_card.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
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
  // Example statistics data (replace with database data later)
  final List<Map<String, String>> statsData = [
    {"title": "Total Job Posted", "value": "68"},
    {"title": "Total Followers", "value": "1.2k"},
    {"title": "Total Active Jobs", "value": "5"},
    {"title": "Applications Received", "value": "103"},
  ];

  final List<JobModel> jobList = [
    JobModel(
      jobId: 1,
      title: 'Flutter Developer',
      jobAbout: 'Develop mobile apps using Flutter.',
      jobType: 'Full-time',
      jobCountry: 'Egypt',
      jobCity: 'Cairo',
      timeAgo: '2d',
      score: 4.5,
      company: Company(
        companyId: 101,
        companyName: 'Tech Solutions',
        profileImg:
            'https://yt3.googleusercontent.com/nOh0J8CqQ-GQS87JMx21dKd87Pf78dN6DX-C_PX6JxQF-pdj25_6TqVwOw_RtWEAI4wQ8USc=s900-c-k-c0x00ffffff-no-rj',
      ),
      skills: ['Flutter', 'Dart', 'Firebase'],
    ),
    JobModel(
      jobId: 2,
      title: 'Backend Developer',
      jobAbout: 'Work with Laravel and MySQL databases.',
      jobType: 'Remote',
      jobCountry: 'Egypt',
      jobCity: 'Alexandria',
      timeAgo: '5d',
      score: 4.0,
      company: Company(
        companyId: 102,
        companyName: 'Code Masters',
        profileImg:
            'https://yt3.googleusercontent.com/nOh0J8CqQ-GQS87JMx21dKd87Pf78dN6DX-C_PX6JxQF-pdj25_6TqVwOw_RtWEAI4wQ8USc=s900-c-k-c0x00ffffff-no-rj',
      ),
      skills: ['Laravel', 'MySQL', 'API Development'],
    ),
  ];

  // Example job post data (replace with database data later)

  var companyName = "".obs;
  Future<void> _getCompanyName() async {
    companyName.value = await AuthRepository().getCompanyName() ?? "";
  }

  @override
  void initState() {
    super.initState();
    _getCompanyName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 105),
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
                    Obx(() => Text(
                          companyName.value,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color: darkerPrimary),
                        )),
                  ],
                ),
                const Spacer(),
                const SettingsIcon(),
              ],
            ),

            const SizedBox(height: 20),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: primaryColor,
            //       minimumSize: Size(double.infinity, 50),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     child: Text(
            //       "Create New Post",
            //       style: TextStyle(
            //         fontSize: 23.7,
            //         color: whiteColor,
            //       ),
            //     ),
            //   ),
            // ),
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
                        title: statsData[0]['title']!,
                        value: statsData[0]['value']!,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        title: statsData[1]['title']!,
                        value: statsData[1]['value']!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: statsData[2]['title']!,
                        value: statsData[2]['value']!,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        title: statsData[3]['title']!,
                        value: statsData[3]['value']!,
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
            ...jobList.map((post) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: JobsCard(
                    job: post,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

  // Job Post Card Widget
  // class JobPostCard extends StatelessWidget {
  //   final String companyName;
  //   final String jobTitle;
  //   final String location;
  //   final String timeAgo;
  //   final String logoUrl;

  //   const JobPostCard({
  //     super.key,
  //     required this.companyName,
  //     required this.jobTitle,
  //     required this.location,
  //     required this.timeAgo,
  //     required this.logoUrl,
  //   });

  //   @override
  //   Widget build(BuildContext context) {
  //     return Container(
  //       margin: const EdgeInsets.only(bottom: 12),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       padding: const EdgeInsets.all(16),
  //       child: Row(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(8),
  //             child: Image.network(
  //               logoUrl,
  //               width: 38,
  //               height: 38,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   companyName,
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 13,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 5),
  //                 Text(
  //                   jobTitle,
  //                   style: TextStyle(
  //                     fontSize: 15.5,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 5),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.location_pin, size: 14, color: Colors.grey[600]),
  //                     const SizedBox(width: 4),
  //                     Text(
  //                       location,
  //                       style: TextStyle(
  //                         fontSize: 11.5,
  //                         color: Colors.grey[600],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Text(
  //             timeAgo,
  //             style: TextStyle(fontSize: 11, color: Colors.grey[600]),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
