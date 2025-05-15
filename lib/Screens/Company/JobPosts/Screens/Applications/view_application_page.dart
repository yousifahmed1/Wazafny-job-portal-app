import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/Applications/send_response_page.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/job_application_view_model_cubit/job_application_view_model_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/job_application_view_model_cubit/job_application_view_model_state.dart';
import 'package:wazafny/Screens/Company/JobPosts/widgets/reject_confirm_dialog.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ViewApplicationPage extends StatefulWidget {
  final int applicationId;
  final int jobId;

  const ViewApplicationPage(
      {super.key, required this.applicationId, required this.jobId});

  @override
  State<ViewApplicationPage> createState() => _ViewApplicationPageState();
}

class _ViewApplicationPageState extends State<ViewApplicationPage> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    await context
        .read<CompanyJobApplicationCubit>()
        .fetchJobApplication(widget.applicationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        onBackPressed: Navigator.of(context).pop,
        title: 'Application Details',
        txtSize: 22,
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<CompanyJobApplicationCubit, JobApplicationState>(
          builder: (context, state) {
            if (state is JobApplicationLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is JobApplicationError) {
              return Center(child: Text(state.message));
            } else if (state is JobApplicationLoaded) {
              final app = state.application;

              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 125),
                      children: [
                        const SizedBox(height: 16),
                        // Profile Icon
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 3.0),
                              ),
                              child: ClipOval(
                                child: app.profileImg != ""
                                    ? Image.network(
                                        app.profileImg,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(
                                        "assets/Images/Profile-default-image.svg",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        const HeadingText(title: "Personal Information"),
                        const SizedBox(height: 24),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SubHeadingText(title: "First Name"),
                            const SizedBox(height: 5),
                            SubHeadingText(
                              title: app.firstName,
                              titleColor: darkerPrimary,
                            ),
                            const SizedBox(height: 5),
                            const SubHeadingText(title: "Last Name"),
                            const SizedBox(height: 5),
                            SubHeadingText(
                              title: app.lastName,
                              titleColor: darkerPrimary,
                            ),
                            const SizedBox(height: 5),
                            const SubHeadingText(title: "Phone Number"),
                            const SizedBox(height: 5),
                            SubHeadingText(
                              title: app.phone,
                              titleColor: darkerPrimary,
                            ),
                            const SizedBox(height: 5),
                            const SubHeadingText(title: "Email"),
                            const SizedBox(height: 5),
                            SubHeadingText(
                              title: app.email,
                              titleColor: darkerPrimary,
                            ),
                            const SizedBox(height: 5),
                            const SubHeadingText(title: "Address"),
                            const SizedBox(height: 5),
                            SubHeadingText(
                              title: "${app.country} - ${app.city}",
                              titleColor: darkerPrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const CustomLine(),
                        const SizedBox(height: 16),

                        const HeadingText(title: "Resume"),
                        const SizedBox(height: 16),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: offwhiteColor.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              SvgPicture.asset(
                                "assets/Icons/cv_icon.svg",
                                height: 55,
                              ),
                              const SizedBox(width: 20),
                              InkWell(
                                onTap: () {
                                  if (app.resume.isNotEmpty) {
                                    FileDownloader.downloadFile(
                                      url: app.resume,
                                      onDownloadCompleted: (String path) {
                                        log('FILE DOWNLOADED TO PATH: $path');
                                        OpenFile.open(path);
                                      },
                                      onDownloadError: (String error) {
                                        log('DOWNLOAD ERROR: $error');
                                      },
                                    );
                                  }
                                },
                                child: const Row(
                                  children: [
                                    SubHeadingText(
                                      title: "View Resume",
                                      titleColor: darkerPrimary,
                                      fontSize: 20,
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const CustomLine(),
                        const SizedBox(height: 20),

                        const HeadingText(title: "Questions"),
                        const SizedBox(height: 16),

                        Column(
                          spacing: 25,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: app.questions.map((question) {
                            return Column(
                              spacing: 5,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SubHeadingText(
                                  title: question.questionText,
                                  titleColor: darkerPrimary,
                                ),
                                const SubHeadingText(
                                  title: "Answer :  ",
                                ),
                                SubHeadingText(
                                  title: question.answer ?? "No Answer",
                                  titleColor: darkerPrimary,
                                ),
                                const SizedBox(height: 15),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Buttons
                  app.status == "Pending"
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => ConfirmDialog(
                                            onConfirm: _onReject,
                                            title: "Reject Application",
                                            description:
                                                "Are you sure you want to reject this application?",
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: lightRedColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: const Center(
                                          child: HeadingText(
                                            title: "Reject",
                                            titleColor: redColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        slideTo(
                                            context,
                                            SendResponsePage(
                                                applicationId:
                                                    widget.applicationId,
                                                jobId: widget.jobId));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: lightGreenColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: const Center(
                                          child: HeadingText(
                                            title: "Accept",
                                            titleColor: greenColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      : const SizedBox(),
                ],
              );
            } else {
              return const SizedBox(); // default blank
            }
          },
        ),
      ),
    );
  }

  void _onReject() {
    Navigator.pop(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    context.read<CompanyApplicationCubit>().sendResponse(
        applicationId: widget.applicationId,
        status: "Rejected",
        jobId: widget.jobId);

    Navigator.pop(context);
    Navigator.pop(context);
  }
}
