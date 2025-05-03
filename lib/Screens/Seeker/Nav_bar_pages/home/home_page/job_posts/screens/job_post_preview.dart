import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/screens/job_apply/apply_job_post.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';

class JobPostPreview extends StatelessWidget {
  const JobPostPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar1(
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/Images/vodafone.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Vodafone Egypt",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const HeadingText(title: "Flutter Mobile App Developer"),
                  const Row(
                    children: [
                      Text("Cairo, "),
                      Text("Egypt , "),
                      Text("4 days ago")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const HeadingText(title: "Skills"),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 15, // Space between items
                    runSpacing: 10, // Space between lines
                    children: List.generate(4, (index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: lightPrimary,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(
                            "Flutter",
                            style: TextStyle(
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
                  const HeadingText(title: "About the job"),
                  const SizedBox(height: 8),
                  const Paragraph(
                    paragraph:
                        "We’re seeking an experienced Mobile Software Engineer with a passion for development and a team-oriented attitude, ready to bring powerful software to life.",
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(5, (index) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          HeadingText(title: "Requirements"),
                          SizedBox(height: 10),
                          Paragraph(
                            paragraph:
                                "We’re seeking an experienced Mobile Software Engineer with a passion for development and a team-oriented attitude, ready to bring powerful software to life.",
                          ),
                          SizedBox(height: 15), // Separator between items
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set your container color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // Shadow color
                    spreadRadius: 10, // Spread of the shadow
                    blurRadius: 50, // Blur effect
                    offset: const Offset(0, 0), // Position of the shadow (x, y)
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    slideUp(context, const ApplyJobPost());
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Apply Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}
