import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/model/job_apply_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/model/job_post_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/services/Job_services.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/cubits/job_apply_cubit/job_apply_cubit.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/screens/job_apply/apply_job_page_one.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/screens/job_apply/apply_job_page_two.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/screens/job_apply/apply_job_page_three.dart';
import 'package:wazafny/widgets/progress_bar.dart';

class ApplyJobPost extends StatefulWidget {
  const ApplyJobPost({super.key, required this.jobPostModel});
  final JobPostModel jobPostModel; // Accept questions as parameter

  @override
  State<ApplyJobPost> createState() => _ApplyJobPostState();
}

class _ApplyJobPostState extends State<ApplyJobPost> {
  int currentPage = 1;
  int totalPages = 3;
  bool isQuestionsEmpty = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.jobPostModel.questions.isEmpty) {
        isQuestionsEmpty = true;
        totalPages = 2;
      }
    });

    log(totalPages.toString());
    log(isQuestionsEmpty.toString());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  JobApplyModel jobApplyModel = JobApplyModel();

  @override
  Widget build(BuildContext context) {
    double progress = currentPage / totalPages;

    return BlocProvider(
      create: (context) => JobApplyCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar1(
          onBackPressed: () => Navigator.pop(context),
        ),
        body: Column(
          children: [
            // Expanded ensures the scrollable content takes available space
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ProgressBar(
                            progress: progress,
                            currentPage: currentPage,
                            totalPages: totalPages),
                        if (currentPage == 1) ...[
                          ApplyPageOne(
                            jobApplyModel: jobApplyModel,
                          ),
                        ] else if (currentPage == 2) ...[
                          ApplyPageTwo(
                            jobApplyModel: jobApplyModel,
                          ),
                        ] else if (currentPage == 3 && !isQuestionsEmpty) ...[
                          ApplyPageThree(
                            jobPostModel: widget.jobPostModel,
                            jobApplyModel: jobApplyModel,
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Bottom bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues( alpha: 0.05),
                    spreadRadius: 10,
                    blurRadius: 50,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentPage != 1
                      //back button appear if current page is not 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (currentPage > 1) {
                                  currentPage--;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: darkPrimary, width: 2)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                      color: darkPrimary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      //back button disappear if current page is 1
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                  const Spacer(),
                  //Next button & submit button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          //On submit button
                          if (currentPage == totalPages) {
                            log(jobApplyModel.toMap().toString());

                            // ignore: unnecessary_null_comparison
                            if (jobApplyModel != null) {
                              await JobService().applyToJob(
                                firstName: jobApplyModel.firstName ?? '',
                                lastName: jobApplyModel.lastName ?? '',
                                phone: jobApplyModel.phone ?? '',
                                country: jobApplyModel.country ?? '',
                                city: jobApplyModel.city ?? '',
                                emailAddress: jobApplyModel.emailAddress ?? '',
                                resume: jobApplyModel.resume!,
                                questionsAnswers:
                                    jobApplyModel.questionsAnswers ?? [],
                                jobId: widget.jobPostModel.jobpost.jobId,
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          } else {
                            //On next button
                            setState(() {
                              if (currentPage < totalPages) {
                                currentPage++;
                                log(jobApplyModel.toMap().toString());
                              }
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: darkPrimary,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: Text(
                              currentPage == totalPages ? "Submit" : "Next",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
