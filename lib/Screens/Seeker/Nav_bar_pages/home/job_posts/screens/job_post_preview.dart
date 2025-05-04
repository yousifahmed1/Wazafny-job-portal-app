import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_apply/apply_job_post.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/widgets/apply_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';

class JobPostPreview extends StatefulWidget {
  const JobPostPreview({super.key, required this.jobId});
  final int jobId;

  @override
  State<JobPostPreview> createState() => _JobPostPreviewState();
}

class _JobPostPreviewState extends State<JobPostPreview> {
  @override
  void initState() {
    super.initState();
    context.read<JobPostCubit>().fetchJobPostDetails(jobId: widget.jobId);
    ();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobPostCubit, JobPostState>(
      builder: (context, state) {
        if (state is JobPostLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is JobPostLoaded) {
          final jobPost = state.jobPostModel;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar1(
              onBackPressed: () => Navigator.pop(context),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            //image
                            child: Image.network(
                              jobPost.profileImg,
                              fit: BoxFit.fill,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          //company name
                          Text(
                            jobPost.company.companyName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          //company name
                          jobPost.applyStatus
                              ? const Text(
                                  "ALready Applied",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: greenColor),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //job title
                      HeadingText(title: jobPost.jobpost.jobTitle),
                      Row(
                        children: [
                          Text("${jobPost.jobpost.jobCity}, "),
                          Text("${jobPost.jobpost.jobCountry} , "),
                          Text("${jobPost.jobpost.jobTime} ago")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const HeadingText(title: "Skills"),
                      const SizedBox(
                        height: 10,
                      ),
                      //skills
                      Wrap(
                        spacing: 15, // Space between items
                        runSpacing: 10, // Space between lines
                        children: List.generate(jobPost.skills.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: lightPrimary,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                jobPost.skills[index].skill,
                                style: const TextStyle(
                                  color: darkPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomLine(),
                      const SizedBox(height: 20),
                      //about
                      const HeadingText(title: "About the job"),
                      const SizedBox(height: 8),
                      Paragraph(
                        paragraph: jobPost.jobpost.jobAbout,
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children:
                            List.generate(jobPost.sections.length, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              HeadingText(
                                  title: jobPost.sections[index].sectionName),
                              const SizedBox(height: 10),
                              Paragraph(
                                paragraph:
                                    jobPost.sections[index].sectionDescription,
                              ),
                              const SizedBox(
                                  height: 15), // Separator between items
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
                //if applystatus is true show apply button
                !jobPost.applyStatus
                    ? Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ApplyButton(
                          onTap: () async {
                            final result = await slideUp2(
                              context,
                              ApplyJobPost(
                                jobPostModel: jobPost,
                              ),
                            );

                            if (result == true) {
                              // Re-fetch job post details to update applyStatus
                              context
                                  .read<JobPostCubit>()
                                  .fetchJobPostDetails(jobId: widget.jobId);
                            }
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        } else if (state is JobPostError) {
          return Center(child: Text(state.error));
        } else {
          return Container();
        }
      },
    );
  }
}
