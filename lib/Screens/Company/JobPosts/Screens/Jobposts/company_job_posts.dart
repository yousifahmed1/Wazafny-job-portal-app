import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/CreateJobPost/create_job_post.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_Job_posts_cubit/company_job_posts_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/company_job_posts_model.dart';
import 'package:wazafny/Screens/Company/JobPosts/widgets/Job_post_card.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';

class CompanyJobPostPage extends StatelessWidget {
  const CompanyJobPostPage({super.key});

  // A function to simulate fetching job data
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyJobPostsCubit, CompanyJobPostsState>(
      builder: (context, state) {
        if (state is CompanyJobPostsInitial) {
          // Automatically fetch job posts when screen loads
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<CompanyJobPostsCubit>().fetchCompanyJobPosts();
          });
          return const Center(child: Text('Loading job posts...'));
        } else if (state is CompanyJobPostsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CompanyJobPostsError) {
          return Center(child: Text(state.message));
        } else if (state is CompanyJobPostsLoaded) {
          List<CompanyJobPostsModel> jobs = state.posts;
          return Scaffold(
            body: Stack(
              children: [
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Job Post",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: darkerPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<CompanyJobPostsCubit>()
                                .fetchCompanyJobPosts();
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.only(
                                bottom: 95, left: 16, right: 16),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: jobs.length,
                            itemBuilder: (context, index) {
                              final job = jobs[index];
                              return JobPostCard(
                                jobId: job.jobId,
                                title: job.jobTitle,
                                status: job.jobStatus,
                                statusColor: job.jobStatus == "Active"
                                    ? greenColor
                                    : redColor,
                                date: job.createdAt,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Custom floating action button
                Positioned(
                  bottom: 120,
                  right: 20,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          slideTo(context, const CreateJobPost());
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
