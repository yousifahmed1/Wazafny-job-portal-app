import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/CreateJobPost/create_job_post.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_Job_posts_cubit/company_job_posts_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_job_post_cubit/company_view_job_post_cubit.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/delete_dialog.dart';

class ConpanyViewJobPost extends StatefulWidget {
  const ConpanyViewJobPost({super.key, required this.jobId});
  final int jobId;

  @override
  State<ConpanyViewJobPost> createState() => _ConpanyViewJobPostState();
}

class _ConpanyViewJobPostState extends State<ConpanyViewJobPost> {
  @override
  void initState() {
    super.initState();
    context
        .read<CompanyViewJobPostCubit>()
        .fetchJobPostDetails(jobId: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompanyJobpostAppBar(
        onBackPressed: () => Navigator.pop(context),
        onDeletePressed: () {
          showDialog(
            context: context,
            builder: (context) => DeleteDialog(
              onConfirm: () {
                Navigator.pop(context); // Close dialog
                context
                    .read<CompanyViewJobPostCubit>()
                    .deleteJobPost(jobId: widget.jobId);

                context.read<CompanyJobPostsCubit>().fetchCompanyJobPosts();
              },
              title: "Delete Job Post",
              description: "Are you sure you want to delete this job post?",
            ),
          );
        },
        onEditPressed: () {
          final state = context.read<CompanyViewJobPostCubit>().state;
          if (state is CompanyViewJobPostLoaded) {
            final jobPost = state.jobPost;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateJobPost(
                  editMode: true,
                  jobPostToEdit: jobPost,
                ),
              ),
            );
          }
        },
        title: "Job Post Details",
        buttonColor: darkerPrimary,
      ),
      body: BlocConsumer<CompanyViewJobPostCubit, CompanyViewJobPostState>(
        listener: (context, state) {
          if (state is CompanyViewJobPostDeleted) {
            Navigator.pop(context); // Return to previous screen after deletion
          }
        },
        builder: (context, state) {
          if (state is CompanyViewJobPostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyViewJobPostError) {
            return Center(child: Text(state.message));
          } else if (state is CompanyViewJobPostLoaded) {
            final jobPost = state.jobPost;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  //job title
                  HeadingText(title: jobPost.jobpost.jobTitle),
                  Row(
                    children: [
                      Text("${jobPost.jobpost.jobCity}, "),
                      Text("${jobPost.jobpost.jobCountry} , "),
                      Text("${jobPost.jobpost.jobTime}")
                    ],
                  ),
                  const SizedBox(height: 20),
                  const HeadingText(title: "Skills"),
                  const SizedBox(height: 10),
                  //skills
                  Wrap(
                    spacing: 15,
                    runSpacing: 10,
                    children: List.generate(jobPost.skills.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: lightPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Text(
                            jobPost.skills[index].skill,
                            style: const TextStyle(
                              color: darkerPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  const CustomLine(),
                  const SizedBox(height: 20),
                  //about
                  const HeadingText(title: "About the job"),
                  const SizedBox(height: 8),
                  Paragraph(paragraph: jobPost.jobpost.jobAbout),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(jobPost.sections.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          HeadingText(
                              title: jobPost.sections[index].sectionName),
                          const SizedBox(height: 10),
                          Paragraph(
                              paragraph:
                                  jobPost.sections[index].sectionDescription),
                          const SizedBox(height: 15),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CompanyJobpostAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  final String? title; // Make it nullable and optional
  final Color? buttonColor;
  final double? txtSize;

  const CompanyJobpostAppBar({
    super.key,
    required this.onBackPressed,
    this.title, // Optional parameter
    this.buttonColor,
    this.txtSize,
    required this.onDeletePressed,
    required this.onEditPressed, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,

        // centerTitle: true,
        elevation: 0,
        title: title != null
            ? Text(
                title!,
                style: TextStyle(
                  color: darkPrimary,
                  fontSize: txtSize ?? 25,
                  fontWeight: FontWeight.w700,
                ),
              )
            : null, // If title is null, no title is displayed
        leading: IconButton(
          enableFeedback: false,
          onPressed: onBackPressed,
          icon: SvgPicture.asset(
            "assets/Icons/backArrow.svg",
            width: 30,
            height: 30,
            color: buttonColor ?? darkPrimary,
          ),
        ),
        actions: [
          IconButton(
            enableFeedback: false,
            onPressed: onDeletePressed,
            icon: SvgPicture.asset(
              "assets/Icons/delete_icon.svg",
              width: 30,
              height: 30,
              color: redColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              enableFeedback: false,
              onPressed: onEditPressed,
              icon: SvgPicture.asset(
                "assets/Icons/edit_icon.svg",
                width: 30,
                height: 30,
                color: buttonColor ?? darkPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 20.0); // Default AppBar height + padding
}
