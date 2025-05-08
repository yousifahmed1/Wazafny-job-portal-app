import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/model/job_applications_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/screens/view_response.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_apply/apply_job_post.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ApplicationsListView extends StatelessWidget {
  const ApplicationsListView({
    super.key,
    required this.filteredJobPosts,
  });

  final List<JobApplicationModel> filteredJobPosts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 105), //navbar height
      physics: const AlwaysScrollableScrollPhysics(),

      itemCount: filteredJobPosts.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          //company image
                          child: Image.network(
                            filteredJobPosts[index].companyImage,
                            fit: BoxFit.fill,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        //job title
                        Text(
                          filteredJobPosts[index].jobTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SubHeadingText(
                      title: filteredJobPosts[index].jobStatus,
                      titleColor:
                          filteredJobPosts[index].jobStatus == 'Accepted'
                              ? greenColor
                              : filteredJobPosts[index].jobStatus == 'Pending'
                                  ? orangeColor
                                  : redColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                //company name
                Row(
                  children: [
                    Text(
                      filteredJobPosts[index].companyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "(${filteredJobPosts[index].jobType})",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      filteredJobPosts[index].jobLocation,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    Text(filteredJobPosts[index].timeAgo,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                if (filteredJobPosts[index].jobStatus == 'Accepted' ||
                    filteredJobPosts[index].jobStatus == 'Pending')
                  filteredJobPosts[index].jobStatus == 'Accepted'
                      ? InkWell(
                          onTap: () {
                            slideUp(
                                context,
                                ViewApplicationResponse(
                                  jobApplicationModel: filteredJobPosts[index],
                                ));
                          },
                          child: const Center(
                              child: SubHeadingText(
                            title: "View Application Response",
                            titleColor: primaryColor,
                          )),
                        )
                      : InkWell(
                          onTap: () {
                            slideUp(
                                context,
                                ApplyJobPost(
                                    editMode: true,
                                    applicationID:
                                        filteredJobPosts[index].applicationId));
                          },
                          child: const Center(
                              child: SubHeadingText(
                            title: "Edit your Application",
                            titleColor: primaryColor,
                          )),
                        ),
              ],
            ),
          ),
        );
      },
    );
  }
}
