import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/create_job_post_model.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class PreviewPage extends StatelessWidget {
  final CreateJobPostModel jobPostData;

  const PreviewPage({
    super.key,
    required this.jobPostData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingText(title: jobPostData.jobTitle ?? ''),
          Row(
            children: [
              Text("${jobPostData.city ?? ''}, "),
              Text("${jobPostData.country ?? ''}"),
            ],
          ),
          const SizedBox(height: 20),
          const HeadingText(title: "Skills"),
          const SizedBox(height: 10),
          Wrap(
            spacing: 15,
            runSpacing: 10,
            children: jobPostData.skills.map((skill) {
              return Container(
                decoration: BoxDecoration(
                  color: lightPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    skill,
                    style: const TextStyle(
                      color: darkerPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ); // <-- add this closing parenthesis for the Container
            }).toList(),
          ),
          const SizedBox(height: 20),
          const CustomLine(),
          const SizedBox(height: 20),
          const HeadingText(title: "About the job"),
          const SizedBox(height: 8),
          Paragraph(paragraph: jobPostData.about ?? ''),
          if (jobPostData.extraSections.isNotEmpty) ...[
            const SizedBox(height: 20),
            ...jobPostData.extraSections.map((section) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingText(title: section['name']?.toString() ?? ''),
                    const SizedBox(height: 10),
                    Paragraph(
                        paragraph: section['description']?.toString() ?? ''),
                    const SizedBox(height: 15),
                  ],
                )),
          ] else ...[
            const SizedBox(height: 14),
          ],
          if (jobPostData.questions.isNotEmpty) ...[
            const SizedBox(height: 20),
            const HeadingText(title: "Questions"),
            const SizedBox(height: 10),
            ...jobPostData.questions.map((question) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubHeadingText1(title: 'Q: $question'),
                    const SizedBox(height: 10),
                  ],
                )),
          ],
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
