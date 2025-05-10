import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/Applications/view_application_page.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class Application {
  final String name;
  final String status;
  final String time;

  Application({required this.name, required this.status, required this.time});
}

class ViewApplicationsPage extends StatelessWidget {
  final List<Application> applications = [
    Application(name: 'Yousif Ahmed', status: 'Accepted', time: '2m'),
    Application(name: 'yossef Badawy', status: 'Rejected', time: '2m'),
    Application(name: 'Elham Mohsen', status: 'Pending', time: '2m'),
    Application(name: 'Menna Aldeib', status: 'Accepted', time: '2m'),
    Application(name: 'Amira Gadallah', status: 'Accepted', time: '2m'),
    Application(name: 'AbdelAziza Amira', status: 'Accepted', time: '2m'),
    Application(name: 'ghonemy', status: 'Accepted', time: '2m'),
  ];

  ViewApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: Navigator.of(context).pop,
        title: 'Applications Received\nFlutter Mobile App Developer',
        txtSize: 22,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            child:
                                // personalInfo["image"] != ""
                                //     ? Image.network(
                                //         personalInfo["image"]!,
                                //         width: 80,
                                //         height: 80,
                                //         fit: BoxFit.cover,
                                //       )
                                //     :
                                SvgPicture.asset(
                              "assets/Images/Profile-default-image.svg",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // const CircleAvatar(
                        //   radius: 24,
                        //   backgroundColor: Colors.black12,
                        //   child:
                        //       Icon(Icons.person, size: 43, color: Colors.black),
                        // ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HeadingText(
                                    title: app.name,
                                    titleColor: darkerPrimary,
                                    fontSize: 20,
                                  ),
                                  const Spacer(),
                                  Text(
                                    app.time,
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
                                      borderRadius: BorderRadius.circular(4),
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
                                        slideTo(context, ViewApplicationPage());
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
  }
}
