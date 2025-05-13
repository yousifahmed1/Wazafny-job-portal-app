import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_state.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_post_preview.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/widgets/jobs_card.dart';
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
    return BlocBuilder<SeekerJobCubit, JobState>(
      builder: (context, state) {
        if (state is JobInitial) {
          // Automatically fetch jobs when screen loads
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<SeekerJobCubit>().fetchJobs();
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
                      job.company.companyName
                          .toLowerCase()
                          .contains(searchLower) ||
                      job.jobCity.toLowerCase().contains(searchLower) ||
                      job.jobCountry.toLowerCase().contains(searchLower) ||
                      job.jobType.toLowerCase().contains(searchLower);
                }).toList();

          if (filteredJobs.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SeekerJobCubit>().fetchJobs();
              },
              child: Center(
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
                          backgroundColor: darkerPrimary,
                        ),
                        child: const Text('Clear Search',
                            style: TextStyle(color: Colors.white)),
                      ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<SeekerJobCubit>().fetchJobs();
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 105), //navbar height
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredJobs.length,
              itemBuilder: (context, index) {
                final job = filteredJobs[index];
                return InkWell(
                  onTap: () =>
                      slideTo(context, JobPostPreview(jobId: job.jobId)),
                  overlayColor: WidgetStateColor.transparent,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: JobsCard(job: job),
                  ),
                );
              },
            ),
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
                  onPressed: () => context.read<SeekerJobCubit>().fetchJobs(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkerPrimary,
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
