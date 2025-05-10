import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Company/JobPosts/widgets/Job_post_card.dart';
import 'package:wazafny/core/constants/constants.dart';

// Entry point of the app

// Class to represent a Job object
class Job {
  final String title;
  final String status;
  final String date;

  Job({required this.title, required this.status, required this.date});
}

// Main screen widget for job posts
class JobPostPage extends StatelessWidget {
  const JobPostPage({super.key});

  // A function to simulate fetching job data
  List<Job> fetchJobs() {
    return [
      Job(
          title: "Flutter Mobile App Developer",
          status: "Active",
          date: "05/08/2025"),
      Job(
          title: "Cyber Security Engineer",
          status: "Closed",
          date: "01/01/2025"),
      Job(
        title: "Backend Developer",
        status: "Active",
        date: "01/01/2025",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Job> jobs = fetchJobs(); // Get the list of jobs

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align content center horizontally
          children: [
            const SizedBox(height: 20), // Add vertical space
            const Center(
              child: Text(
                "Job Post",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: darkerPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                // Horizontal padding for list
                padding:
                    const EdgeInsets.only(bottom: 105, left: 16, right: 16),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: jobs.length, // Number of job cards
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return JobPostCard(
                    title: job.title,
                    status: job.status,
                    statusColor: job.status == "Active"
                        ? greenColor
                        : redColor, // Status color logic
                    date: job.date,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

