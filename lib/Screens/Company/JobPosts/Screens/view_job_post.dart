import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_post_model.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';

class ConpanyViewJobPost extends StatefulWidget {
  const ConpanyViewJobPost({super.key, required this.jobId});
  final int jobId;

  @override
  State<ConpanyViewJobPost> createState() => _ConpanyViewJobPostState();
}

class _ConpanyViewJobPostState extends State<ConpanyViewJobPost> {
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<JobPostCubit>().fetchJobPostDetails(jobId: widget.jobId);
  //   ();
  // }

  final jobPost = JobPostModel(
    profileImg: 'https://example.com/profile1.png',
    jobpost: JobPost(
      jobId: 1,
      jobTitle: 'Flutter Developer',
      jobAbout: 'Develop mobile apps using Flutter framework.',
      jobTime: 'Full-time',
      jobType: 'On-Site',
      jobCountry: 'Egypt',
      jobCity: 'Cairo',
      companyId: 101,
      createdAt: '2025-05-01',
    ),
    company: Company(
      companyName: 'Tech Solutions',
      userId: 201,
    ),
    skills: [
      Skill(skillId: 1, skill: 'Flutter'),
      Skill(skillId: 2, skill: 'Dart'),
      Skill(skillId: 3, skill: 'Firebase'),
    ],
    sections: [
      Section(
          sectionId: 1,
          sectionName: 'Requirements',
          sectionDescription: '3+ years of Flutter experience.'),
      Section(
          sectionId: 2,
          sectionName: 'Benefits',
          sectionDescription: 'Flexible hours and health insurance.'),
    ],
    questions: [
      Question(questionId: 1, question: 'Why do you want this job?'),
      Question(
          questionId: 2, question: 'Do you have experience with Firebase?'),
    ],
    timeAgo: '2d',
    applyStatus: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompanyJobpostAppBar(
        onBackPressed: () => Navigator.pop(context),
        onDeletePressed: () {},
        onEditPressed: () {},
        title: "Job Post Details",
        buttonColor: darkerPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(jobPost.sections.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    HeadingText(title: jobPost.sections[index].sectionName),
                    const SizedBox(height: 10),
                    Paragraph(
                      paragraph: jobPost.sections[index].sectionDescription,
                    ),
                    const SizedBox(height: 15), // Separator between items
                  ],
                );
              }),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return BlocBuilder<JobPostCubit, JobPostState>(
  //     builder: (context, state) {
  //       if (state is JobPostLoading) {
  //         return const Scaffold(
  //             body: Center(child: CircularProgressIndicator()));
  //       } else if (state is JobPostLoaded) {
  //         final jobPost = state.jobPostModel;
  //         return Scaffold(
  //           backgroundColor: Colors.white,
  //           appBar: CustomAppBar1(
  //             onBackPressed: () => Navigator.pop(context),
  //           ),
  //           body: Padding(
  //             padding: const EdgeInsets.all(20),
  //             child: ListView(
  //               children: [
  //                 Row(
  //                   children: [
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.circular(10),
  //                       //image
  //                       child: Image.network(
  //                         jobPost.profileImg,
  //                         fit: BoxFit.fill,
  //                         height: 50,
  //                         width: 50,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     //company name
  //                     Text(
  //                       jobPost.company.companyName,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 15,
  //                       ),
  //                     ),
  //                     const Spacer(),
  //                     //company name
  //                     jobPost.applyStatus
  //                         ? const Text(
  //                             "ALready Applied",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.w700,
  //                                 fontSize: 15,
  //                                 color: greenColor),
  //                           )
  //                         : const SizedBox(),
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 //job title
  //                 HeadingText(title: jobPost.jobpost.jobTitle),
  //                 Row(
  //                   children: [
  //                     Text("${jobPost.jobpost.jobCity}, "),
  //                     Text("${jobPost.jobpost.jobCountry} , "),
  //                     Text("${jobPost.jobpost.jobTime} ago")
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 const HeadingText(title: "Skills"),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 //skills
  //                 Wrap(
  //                   spacing: 15, // Space between items
  //                   runSpacing: 10, // Space between lines
  //                   children: List.generate(jobPost.skills.length, (index) {
  //                     return Container(
  //                       decoration: BoxDecoration(
  //                           color: lightPrimary,
  //                           borderRadius: BorderRadius.circular(12)),
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 15, vertical: 8),
  //                         child: Text(
  //                           jobPost.skills[index].skill,
  //                           style: const TextStyle(
  //                             color: darkerPrimary,
  //                             fontWeight: FontWeight.w600,
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   }),
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 const CustomLine(),
  //                 const SizedBox(height: 20),
  //                 //about
  //                 const HeadingText(title: "About the job"),
  //                 const SizedBox(height: 8),
  //                 Paragraph(
  //                   paragraph: jobPost.jobpost.jobAbout,
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children:
  //                       List.generate(jobPost.sections.length, (index) {
  //                     return Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const SizedBox(height: 15),
  //                         HeadingText(
  //                             title: jobPost.sections[index].sectionName),
  //                         const SizedBox(height: 10),
  //                         Paragraph(
  //                           paragraph:
  //                               jobPost.sections[index].sectionDescription,
  //                         ),
  //                         const SizedBox(
  //                             height: 15), // Separator between items
  //                       ],
  //                     );
  //                   }),
  //                 ),
  //                 const SizedBox(height: 80),
  //               ],
  //             ),
  //           ),
  //         );

  //       } else if (state is JobPostError) {
  //         return Center(child: Text(state.error));
  //       } else {
  //         return Container();
  //       }
  //     },
  //   );
  // }
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
