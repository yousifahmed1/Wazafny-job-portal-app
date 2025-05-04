import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_post_preview.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';

class CompanyViewPosts extends StatefulWidget {
  const CompanyViewPosts({
    super.key,
    required this.company,
  });
  final CompanyModel company;

  @override
  State<CompanyViewPosts> createState() => _CompanyViewPostsState();
}

class _CompanyViewPostsState extends State<CompanyViewPosts> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 20),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: widget.company.jobPosts!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => slideTo(context, JobPostPreview(jobId: widget.company.jobPosts![index].jobId,)),
          overlayColor: WidgetStateColor.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.company.profileImg != null &&
                                    widget.company.profileImg != ""
                                ? Image.network(
                                    widget.company.profileImg!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    "assets/Images/Profile-default-image.svg",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.company.companyName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(widget.company.jobPosts![index].timeAgo),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.company.jobPosts![index].jobTitle,
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
                        widget.company.jobPosts![index].jobCountry,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.company.jobPosts![index].jobType,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: widget.company.jobPosts![index].jobStatus ==
                                  "Active"
                              ? lightGreenColor
                              : lightRedColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Text(
                            widget.company.jobPosts![index].jobStatus,
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    widget.company.jobPosts![index].jobStatus ==
                                            "Active"
                                        ? greenColor
                                        : redColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
