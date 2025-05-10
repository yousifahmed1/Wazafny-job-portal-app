import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/jobs_model.dart';
import 'package:wazafny/core/constants/constants.dart';

class JobsCard extends StatelessWidget {
  const JobsCard({
    super.key,
    required this.job,
  });

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      // margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
                      borderRadius: BorderRadius.circular(5),
                      //company profile
                      child: Image.network(
                        job.company.profileImg,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //company name
                    Text(
                      job.company.companyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: darkerPrimary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                //time ago
                Text(
                  "${job.timeAgo} ago",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: darkerPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //job title
            Text(
              job.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: darkerPrimary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // job location + job type
            Row(
              children: [
                Text(
                  "${job.jobCity}, ${job.jobCountry} (${job.jobType})",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: darkerPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
