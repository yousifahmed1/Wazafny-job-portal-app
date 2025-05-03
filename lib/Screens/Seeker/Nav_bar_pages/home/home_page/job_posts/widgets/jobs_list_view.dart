import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_state.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/screens/job_post_preview.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';

class JobsListView extends StatelessWidget {
  JobsListView({
    super.key,
  });

  final List<Map<String, dynamic>> jobList = [
    {
      'company': 'Vodafone Egypt',
      'postedAgo': '2d',
      'position': 'Flutter Mobile App Developer',
      'location': 'Egypt (Remote)',
      'image':
          "https://d39lxsrz40jt15.cloudfront.net/downloads/EDG2012/o_1bsuejoft1ie9ho010tc1rnlnp9m_w600_h0.png",
    },
    {
      'company': 'Microsoft',
      'postedAgo': '5h',
      'position': 'Software Engineer Intern',
      'location': 'Cairo, Egypt (Hybrid)',
      'image':
          "https://brandlogos.net/wp-content/uploads/2020/03/Microsoft-logo-512x512.png",
    },
    {
      'company': 'Amazon',
      'postedAgo': '1w',
      'position': 'Backend Developer',
      'location': 'Alexandria, Egypt (Remote)',
      'image':
          "https://i.pinimg.com/originals/01/ca/da/01cada77a0a7d326d85b7969fe26a728.jpg",
    },
    {
      'company': 'Orange Egypt',
      'postedAgo': '3d',
      'position': 'Frontend Developer',
      'location': 'Giza, Egypt (On-Site)',
      'image':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Orange_logo.svg/800px-Orange_logo.svg.png",
    },
    {
      'company': 'Valeo',
      'postedAgo': '2w',
      'position': 'Embedded Systems Engineer',
      'location': 'Cairo, Egypt (On-Site)',
      'image': "https://www.neko.com.tr/images/suppliers/valeo.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubit, JobState>(
      builder: (context, state) {
        if (state is JobInitial) {
          // Automatically fetch jobs when screen loads
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<JobCubit>().fetchJobs();
          });
          return const Center(child: Text('Loading jobs...'));
        } else if (state is JobLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is JobLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 105), //navbar height
            physics: const BouncingScrollPhysics(),
            itemCount: state.jobs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => slideTo(context, const JobPostPreview()),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    state.jobs[index].company.profileImg,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  state.jobs[index].company.companyName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "${state.jobs[index].timeAgo} ago",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.jobs[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${state.jobs[index].jobCity}, ${state.jobs[index].jobCountry} (${state.jobs[index].jobType})",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            // Text(
                            //   " (Remote)",
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w500,
                            //     fontSize: 15,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ); // Close the ListView.builder here
        } else if (state is JobError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<JobCubit>().fetchJobs(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPrimary,
                  ),
                  child: const Text('Try Again',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }
        return const SizedBox(); // Empty fallback
      },
    );
  }
}
