import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/view_response.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/models/job_posts_model.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ApplicationsListView extends StatelessWidget {
  const ApplicationsListView({
    super.key,
    required this.filteredJobPosts,
  });

  final List<AppliedJobApplicationModel> filteredJobPosts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                          child: Image.asset(
                            "assets/Images/vodafone.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
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
                              ? acceptedColor
                              : filteredJobPosts[index].jobStatus == 'Pending'
                                  ? pendingColor
                                  : rejectedColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  filteredJobPosts[index].jobTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    Text(
                      " (${filteredJobPosts[index].jobType})",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    Text(filteredJobPosts[index].timeAgo,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
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
                            slideUp(context, const ViewApplicationResponse());
                          },
                          child: const Center(
                              child: SubHeadingText(
                            title: "View Application Response",
                            titleColor: primaryColor,
                          )),
                        )
                      : const Center(
                          child: SubHeadingText(
                          title: "Edit your Application",
                          titleColor: primaryColor,
                        )),
              ],
            ),
          ),
        );
      },
    );
  }
}
