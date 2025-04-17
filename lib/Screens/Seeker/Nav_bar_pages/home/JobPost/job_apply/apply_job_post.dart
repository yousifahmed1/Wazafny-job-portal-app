import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/nav_bar.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/cubits/job_apply_cubit/job_apply_cubit.dart';
import 'package:wazafny/models/questions_model.dart';
import 'package:wazafny/services/get_questions_service.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/JobPost/job_apply/apply_job_page_one.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/JobPost/job_apply/apply_job_page_two.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/JobPost/job_apply/apply_job_page_three.dart';
import 'package:wazafny/widgets/progress_bar.dart';

class ApplyJobPost extends StatefulWidget {
  final int? jobID;
  final int? seekerId;

  const ApplyJobPost({super.key, this.jobID, this.seekerId});

  @override
  State<ApplyJobPost> createState() => _ApplyJobPostState();
}

class _ApplyJobPostState extends State<ApplyJobPost> {
  int currentPage = 1;
  int totalPages = 3;
  bool isQuestionsEmpty = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<QuestionsModel>> _questionsFuture;

  @override
  void initState() {
    super.initState();
    // Initialize questions fetch
    _questionsFuture = GetQuestions().getQuestions(jobID: widget.jobID ?? 2);
    // Update isQuestionsEmpty and totalPages when future completes
    _questionsFuture.then((questions) {
      setState(() {
        isQuestionsEmpty = questions.isEmpty;
        totalPages = isQuestionsEmpty
            ? 2
            : 3; // Set totalPages based on isQuestionsEmpty
      });
    }).catchError((error) {
      setState(() {
        isQuestionsEmpty = true;
        totalPages = 2; // Fallback to 2 pages on error
      });
    });
  }

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
                          const ApplyPageOne(),
                        ] else if (currentPage == 2) ...[
                          const ApplyPageTwo(),
                        ] else if (currentPage == 3 && !isQuestionsEmpty) ...[
                          FutureBuilder<List<QuestionsModel>>(
                            future: _questionsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              }
                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No questions available'));
                              }
                              return ApplyPageThree(
                                jobID: widget.jobID ?? 0,
                                questions: snapshot.data!,
                              );
                            },
                          ),
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
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          //On submit button
                          if (currentPage == totalPages) {
                            // context.read<JobApplyCubit>().submitFormData(
                            //       jobId: widget.jobID ?? 0,
                            //       seekerId: widget.seekerId ?? 0,
                            //     );
                            slideTo(context, NavBar());
                          } else {
                            //On next button
                            setState(() {
                              if (currentPage < totalPages) {
                                currentPage++;
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