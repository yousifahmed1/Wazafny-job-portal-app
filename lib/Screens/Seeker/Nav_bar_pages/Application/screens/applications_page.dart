import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/cubit/job_applications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/cubit/job_applications_state.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/model/job_applications_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/widgets/applications_list_view.dart';
import 'package:wazafny/widgets/search_bar_profile_circle.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

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

  // Method to filter applications based on search text
  List<JobApplicationModel> getFilteredApplications(
      List<JobApplicationModel> applications) {
    final searchText = _searchController.text.toLowerCase();
    final filteredByCategory = selectedCategories.isEmpty ||
            selectedCategories.contains("All")
        ? applications
        : applications
            .where((jobPost) => selectedCategories.contains(jobPost.jobStatus))
            .toList();

    // Filtering based on search text
    return filteredByCategory.where((jobPost) {
      return jobPost.jobTitle.toLowerCase().contains(searchText) ||
          jobPost.companyName
              .toLowerCase()
              .contains(searchText); // You can add more fields here
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Search bar and profile circle
            SearchBarProfileCircle(
              searchController: _searchController,
              onSearchChanged: (searchText) {
                setState(() {}); // Rebuild when search text changes
              },
            ),
            const SizedBox(height: 15),
            const HeadingText1(title: "My Applications"),
            const SizedBox(height: 15),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Wrap(
                    spacing: 15,
                    children: categories.map((category) {
                      return FilterChip(
                        label: Text(category),
                        selected: selectedCategories.contains(category),
                        onSelected: (bool selected) {
                          setState(() {
                            if (category == "All") {
                              selectedCategories
                                ..clear()
                                ..add("All");
                            } else {
                              selectedCategories.remove("All");
                              if (selected) {
                                selectedCategories.add(category);
                              } else {
                                selectedCategories.remove(category);
                              }
                              if (selectedCategories.isEmpty) {
                                selectedCategories.add("All");
                              }
                            }
                          });
                        },
                        elevation: 0,
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
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
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Applications list
            Expanded(
              child:
                  BlocBuilder<SeekerJobApplicationsCubit, JobApplicationsState>(
                builder: (context, state) {
                  if (state is JobApplicationsInitial) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<SeekerJobApplicationsCubit>()
                          .fetchJobApplications();
                    });
                    return const Center(child: Text('Loading jobs...'));
                  }
                  if (state is JobApplicationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is JobApplicationsError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is JobApplicationsLoaded) {
                    final filteredJobPosts =
                        getFilteredApplications(state.applications);

                    return RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<SeekerJobApplicationsCubit>()
                            .fetchJobApplications();
                      },
                      child: filteredJobPosts.isEmpty
                          ? ListView(
                              // Needed for RefreshIndicator to work even when list is empty
                              children: const [
                                SizedBox(height: 40),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 100),
                                    child: Text(
                                      "No applications yet",
                                      style: TextStyle(
                                        color: bordersColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ApplicationsListView(
                              filteredJobPosts: filteredJobPosts),
                    );
                  } else {
                    return const SizedBox(); // fallback
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
