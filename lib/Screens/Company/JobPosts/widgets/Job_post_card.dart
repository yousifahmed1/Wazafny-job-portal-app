import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/Applications/view_applications_page.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/view_job_post.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class JobPostCard extends StatelessWidget {
  final int jobId;
  final String title;
  final String status;
  final String date;
  final Color statusColor;

  const JobPostCard({
    super.key,
    required this.title,
    required this.status,
    required this.date,
    required this.statusColor, required this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16), // Internal padding for card content
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, // Light shadow effect
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Job title text
          HeadingText(
            title: title,
            fontSize: 20,
          ),
          const SizedBox(height: 16),
          // Divider line

          Container(
            width: double.infinity,
            height: 1,
            color: linesColor,
          ),
          const SizedBox(height: 16),
          // Row for Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SubHeadingText(
                title: 'Status',
                titleColor: darkerPrimary,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: status == "Active" ? lightGreenColor : lightRedColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SubHeadingText(
                  title: status,
                  titleColor: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Row for Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SubHeadingText(
                title: 'Date',
                titleColor: darkerPrimary,
              ),
              SubHeadingText(
                title: date,
                titleColor: darkerPrimary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Row for Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // "View Applications" button

              InkWell(
                onTap: () {
                  //34
                  slideTo(context, ViewApplicationsPage(jobId: jobId ,));
                },
                child: const RoundedButton(
                  text: "View Applications",
                  height: 40,
                  width: 160,
                  size: 14,
                ),
              ),

              // Container(
              //   width: 140,
              //   height: 40,
              //   child: OutlinedButton(
              //     onPressed: () {}, // Placeholder for button action
              //     style: OutlinedButton.styleFrom(
              //       backgroundColor: Colors.white,
              //       side: const BorderSide(
              //         color: Colors.black,
              //         width: 1.2,
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: const Text(
              //       "View Applications",
              //       style: TextStyle(
              //         fontSize: 11,
              //         fontWeight: FontWeight.w500,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              // // Circular Icon Button with Arrow

              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: darkerPrimary, // Black circular background
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp, // Forward arrow icon
                      color: Colors.white, // White arrow color
                    ),
                    onPressed: () {
                      slideTo(
                          context,
                          const ConpanyViewJobPost(
                            jobId: 31,
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
