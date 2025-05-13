import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/Applications/view_application_page.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_state.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ViewApplicationsPage extends StatefulWidget {
  final int jobId;

  const ViewApplicationsPage({super.key, required this.jobId});

  @override
  State<ViewApplicationsPage> createState() => _ViewApplicationsPageState();
}

class _ViewApplicationsPageState extends State<ViewApplicationsPage> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    await context
        .read<CompanyApplicationCubit>()
        .fetchApplications(jobId: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyApplicationCubit, ApplicationState>(
      builder: (context, state) {
        if (state is ApplicationLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is ApplicationError) {
          return Center(child: Text(state.message));
        } else if (state is ApplicationEmpty) {
          return Scaffold(
            appBar: CustomAppBar(
              onBackPressed: Navigator.of(context).pop,
            ),
            body: const Center(
                child: SubHeadingText(title: "There is no applications yet")),
          );
        } else if (state is ApplicationLoaded) {
          final applications = state.jobApplication.applications;
          final jobTitle = state.jobApplication.jobTitle;
          return Scaffold(
            appBar: CustomAppBar(
              onBackPressed: Navigator.of(context).pop,
              title: jobTitle,
              txtSize: 22,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: applications.length,
                      itemBuilder: (context, index) {
                        final app = applications[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: app.seeker.profileImg != ""
                                      ? Image.network(
                                          app.seeker.profileImg,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : SvgPicture.asset(
                                          "assets/Images/Profile-default-image.svg",
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        HeadingText(
                                          title:
                                              "${app.seeker.firstName} ${app.seeker.lastName}",
                                          titleColor: darkerPrimary,
                                          fontSize: 20,
                                        ),
                                        const Spacer(),
                                        Text(
                                          app.timeAgo,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const SubHeadingText(
                                          title: 'Status : ',
                                          titleColor: darkerPrimary,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: app.status == 'Accepted'
                                                ? lightGreenColor
                                                : app.status == 'Rejected'
                                                    ? lightRedColor
                                                    : lightOrangeColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            app.status,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: app.status == 'Accepted'
                                                  ? greenColor
                                                  : app.status == 'Rejected'
                                                      ? redColor
                                                      : orangeColor,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: darkerPrimary,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              slideTo(
                                                  context,
                                                  ViewApplicationPage(
                                                    applicationId:
                                                        app.applicationId,
                                                  ));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
// Row(
                //   children: [
                //     Column(
                //       children: [
                //         IconButton(
                //           icon: const Icon(
                //             Icons.arrow_back_ios_new,
                //             size: 30,
                //             color: Colors.black,
                //           ),
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //         ),
                //       ],
                //     ),
                //     const Column(
                //       children: [
                //         Text(
                //           'Applications Received',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20.29,
                //           ),
                //         ),
                //         SizedBox(height: 4),
                //         Text(
                //           'Flutter Mobile App Developer',
                //           style: TextStyle(
                //             fontSize: 16.29,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ],
                //     )
                //   ],
                // ),