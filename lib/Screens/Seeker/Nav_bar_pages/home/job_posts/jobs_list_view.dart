import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_state.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_post_preview.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';

class JobsListView extends StatelessWidget {
  final String searchQuery;

  const JobsListView({
    super.key,
    this.searchQuery = '',
  });

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
          // Filter jobs based on search query
          final filteredJobs = searchQuery.isEmpty
              ? state.jobs
              : state.jobs.where((job) {
                  final searchLower = searchQuery.toLowerCase();
                  return job.title.toLowerCase().contains(searchLower) ||
                      job.company.companyName.toLowerCase().contains(searchLower) ||
                      job.jobCity.toLowerCase().contains(searchLower) ||
                      job.jobCountry.toLowerCase().contains(searchLower) ||
                      job.jobType.toLowerCase().contains(searchLower);
                }).toList();

          if (filteredJobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No jobs found matching your search',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (searchQuery.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        // Clear search - this would be handled by the parent widget
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkPrimary,
                      ),
                      child: const Text('Clear Search', 
                        style: TextStyle(color: Colors.white)),
                    ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 105), //navbar height
            physics: const BouncingScrollPhysics(),
            itemCount: filteredJobs.length,
            itemBuilder: (context, index) {
              final job = filteredJobs[index];
              return InkWell(
                onTap: () => slideTo(context, JobPostPreview(jobId: job.jobId)),
                overlayColor: WidgetStateColor.transparent,
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
                                  //company profile
                                  child: Image.network(
                                    job.company.profileImg,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                //company name
                                Text(
                                  job.company.companyName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            //time ago
                            Text(
                              "${job.timeAgo} ago",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //job title
                        Text(
                          job.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // job location + job type
                        Row(
                          children: [
                            Text(
                              "${job.jobCity}, ${job.jobCountry} (${job.jobType})",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
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