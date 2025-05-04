import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/Services/job_applications_services.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/cubit/job_applications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_post_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/services/Job_services.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_apply/apply_job_page_one.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_apply/apply_job_page_two.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/screens/job_apply/apply_job_page_three.dart';
import 'package:wazafny/widgets/progress_bar.dart';

class ApplyJobPost extends StatefulWidget {
  const ApplyJobPost({
    super.key,
    this.jobPostModel,
    this.editMode = false,
    this.applicationID,
  });
  final JobPostModel? jobPostModel; // Accept questions as parameter
  final bool editMode;
  final int? applicationID;

  @override
  State<ApplyJobPost> createState() => _ApplyJobPostState();
}

class _ApplyJobPostState extends State<ApplyJobPost> {
  int currentPage = 1;
  int totalPages = 3;
  bool isQuestionsEmpty = false;
  bool isLoading = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late JobApplyModel jobApplyModel;
  late var cuurent_file;

  @override
  void initState() {
    super.initState();
    jobApplyModel = JobApplyModel(); // Initialize first
    _initialize();
  }

  Future<void> _initialize() async {
    if (!widget.editMode && widget.jobPostModel!.questions.isEmpty) {
      isQuestionsEmpty = true;
      totalPages = 2;
    }

    if (widget.editMode) {
      jobApplyModel = await JobApplicationServices().showJobApplication(
        applicationId: widget.applicationID!,
      );
      if (jobApplyModel.questionsAnswers!.isEmpty) {
        isQuestionsEmpty = true;
        totalPages = 2;
      }
    }

    setState(() {
      isLoading = false; // Now UI can build
    });

    log(totalPages.toString());
    log(isQuestionsEmpty.toString());
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentPage / totalPages;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar1(
        onBackPressed: () => Navigator.pop(context),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
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
                                isEditMode: widget.editMode,
                              ),
                            ] else if (currentPage == 2) ...[
                              ApplyPageTwo(
                                jobApplyModel: jobApplyModel,
                              ),
                            ] else if (currentPage == 3 && !isQuestionsEmpty)
                              ApplyPageThree(
                                jobPostModel: widget.jobPostModel,
                                jobApplyModel: jobApplyModel,
                                isEditMode: widget.editMode,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                buildBottomButtons(),
              ],
            ),
    );
  }

  Widget buildBottomButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 10,
            blurRadius: 50,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentPage != 1 ? buildBackButton() : buildDisabledBackButton(),
          const Spacer(),
          buildNextOrSubmitButton(),
        ],
      ),
    );
  }

  Widget buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            border: Border.all(color: darkPrimary, width: 2),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
    );
  }

  Widget buildDisabledBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
    );
  }

  Widget buildNextOrSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            if (currentPage == 2 && jobApplyModel.resume == null ||
                (jobApplyModel.resume is String &&
                    jobApplyModel.resume == "") ||
                (jobApplyModel.resume is File &&
                    !(jobApplyModel.resume as File).existsSync())) {
              // Show error to user
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Please upload your resume before submitting.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: redColor,
                ),
              );
              return; // Stop submission
            }
            if (currentPage == totalPages) {
              log(jobApplyModel.toMap().toString());
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
              if (widget.editMode) {
                await JobApplicationServices().updateApplication(
                  applicationId: widget.applicationID!,
                  firstName: jobApplyModel.firstName ?? '',
                  lastName: jobApplyModel.lastName ?? '',
                  phone: jobApplyModel.phone ?? '',
                  country: jobApplyModel.country ?? '',
                  city: jobApplyModel.city ?? '',
                  emailAddress: jobApplyModel.emailAddress ?? '',
                  resume: jobApplyModel.resume is File
                      ? jobApplyModel.resume as File
                      : null,
                  questionsAnswers: jobApplyModel.questionsAnswers ?? [],
                );
              }
              if (widget.editMode == false) {
                await JobService().applyToJob(
                  firstName: jobApplyModel.firstName ?? '',
                  lastName: jobApplyModel.lastName ?? '',
                  phone: jobApplyModel.phone ?? '',
                  country: jobApplyModel.country ?? '',
                  city: jobApplyModel.city ?? '',
                  emailAddress: jobApplyModel.emailAddress ?? '',
                  resume: jobApplyModel.resume!,
                  questionsAnswers: jobApplyModel.questionsAnswers ?? [],
                  jobId: widget.jobPostModel!.jobpost.jobId,
                );
              }

              // ignore: use_build_context_synchronously
              Navigator.pop(context);

              // ignore: use_build_context_synchronously
              Navigator.pop(context, true);
              context.read<JobApplicationsCubit>().fetchJobApplications();
            } else {
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
    );
  }
}
