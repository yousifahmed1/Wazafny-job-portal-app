import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/applications_list_view.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/models/job_posts_model.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

import '../../../../../widgets/text_fields/search_field.dart'; // Assuming primaryColor is defined here

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = [
    "All",
    "Accepted",
    "Pending",
    "Rejected",
  ];

  final Set<String> selectedCategories = {'All'}; // Default selected

  List<AppliedJobApplicationModel> jobPosts = [
    AppliedJobApplicationModel(
      companyImage: 'assets/images/google.png',
      companyName: 'Google',
      jobTitle: 'SECURITY ENG',
      jobStatus: 'Accepted',
      jobLocation: 'Mountain View, CA',
      jobType: 'Full-time',
      timeAgo: '2d',
    ),

    AppliedJobApplicationModel(
      companyImage: 'assets/images/microsoft.png',
      companyName: 'Microsoft',
      jobTitle: 'Backend Developer',
      jobStatus: 'Pending',
      jobLocation: 'Redmond, WA',
      jobType: 'Remote',
      timeAgo: '1w',
    ),

    AppliedJobApplicationModel(
      companyImage: 'assets/images/amazon.png',
      companyName: 'Amazon',
      jobTitle: 'Data Analyst',
      jobStatus: 'Rejected',
      jobLocation: 'Seattle, WA',
      jobType: 'Hybrid',
      timeAgo: '5d',
    ),
    AppliedJobApplicationModel(
      companyImage: 'assets/images/meta.png',
      companyName: 'Meta',
      jobTitle: 'UI/UX Designer',
      jobStatus: 'Pending',
      jobLocation: 'Menlo Park, CA',
      jobType: 'On-site',
      timeAgo: '3d',
    ),
    AppliedJobApplicationModel(
      companyImage: 'assets/images/apple.png',
      companyName: 'Apple',
      jobTitle: 'iOS Developer',
      jobStatus: 'Accepted',
      jobLocation: 'Cupertino, CA',
      jobType: 'Full-time',
      timeAgo: '2w',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredJobPosts = selectedCategories.isEmpty ||
            selectedCategories.contains("All")
        ? jobPosts
        : jobPosts
            .where((jobPost) => selectedCategories.contains(jobPost.jobStatus))
            .toList();
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Column(
          children: [
            //search bar and profile circle
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Search Bar
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: SearchTextField(controller: _searchController),
                    ),
                  ),

                  const SizedBox(width: 12),

                  //Profile Circle
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: darkPrimary,
                    child: Text(
                      "YA",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            const HeadingText1(title: "My Applications"),

            const SizedBox(
              height: 15,
            ),

            //filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Wrap(
                    spacing: 15,
                    children: categories
                        .map((category) => FilterChip(
                              label: Text(category),
                              selected: selectedCategories.contains(category),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedCategories.add(category);
                                  } else {
                                    selectedCategories.remove(category);
                                  }
                                });
                              },
                              elevation: 0,
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5 ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              selectedColor: primaryColor,
                              backgroundColor: Colors.white,
                              checkmarkColor: Colors.white,
                              labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: selectedCategories.contains(category)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            //job posts
            Expanded(
              child: ApplicationsListView(filteredJobPosts: filteredJobPosts),
            ),
          ],
        ),
      ),
    );
  }
}