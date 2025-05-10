import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/Applications/send_response_page.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ViewApplicationPage extends StatelessWidget {
  final Map<String, String> personalInfo = {
    "image": "",
    'First Name': 'Yousif',
    'Last Name': 'Elfahham',
    'Phone Number': '+20 010 991 907 60',
    'Email': 'Yousifelfahham@gmail.com',
    'Address': 'Cairo , Egypt',
    'Resume':
        'https://drive.google.com/file/d/1kXJF8t6kZ3G0yjIyOZg8s1Z3G0yjIyOZg8s/view?usp=share_link'
  };

  ViewApplicationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        onBackPressed: Navigator.of(context).pop,
        title: 'Flutter Mobile App Developer',
        txtSize: 22,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 125), //navbar height

                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 16, bottom: 8),
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.arrow_back_ios, size: 18),
                  //       SizedBox(width: 6),
                  //       Expanded(
                  //         child: Text(
                  //           'Flutter Mobile App Developer',
                  //           style: TextStyle(
                  //               fontSize: 16, fontWeight: FontWeight.w600),
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  // Profile Icon (left-aligned)
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                        child: ClipOval(
                          child: personalInfo["image"] != ""
                              ? Image.network(
                                  personalInfo["image"]!,
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
                  // Section Title
                  const HeadingText(
                    title: "Personal Information",
                  ),
                  const SizedBox(height: 24),

                  const Column(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubHeadingText(title: "First Name"),
                      SubHeadingText(
                        title: "Menna",
                        titleColor: darkerPrimary,
                      ),
                      SubHeadingText(title: "Last Name"),
                      SubHeadingText(
                        title: "Eldeib",
                        titleColor: darkerPrimary,
                      ),
                      SubHeadingText(title: "Phone Number"),
                      SubHeadingText(
                        title: "+20 100 374 8267",
                        titleColor: darkerPrimary,
                      ),
                      SubHeadingText(title: "Email"),
                      SubHeadingText(
                        title: "MennaMedhat@gmail.com",
                        titleColor: darkerPrimary,
                      ),
                      SubHeadingText(title: "Address"),
                      SubHeadingText(
                        title: "UAE , Dubai",
                        titleColor: darkerPrimary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // // All info lines one under another - aligned
                  // ...personalInfo.entries.map((entry) => Padding(
                  //       padding: const EdgeInsets.only(bottom: 16),
                  //       child: InfoText(label: entry.key, value: entry.value),
                  //     )),
                  const CustomLine(),
                  // Divider(height: 40, thickness: 1),
                  const SizedBox(height: 16),

                  // Resume Title
                  const HeadingText(
                    title: "Resume",
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                            FileDownloader.downloadFile(
                                url: personalInfo["resume"]!,
                                onDownloadCompleted: (String path) {
                                  log('FILE DOWNLOADED TO PATH: $path');
                                  OpenFile.open(path);
                                },
                                onDownloadError: (String error) {
                                  log('DOWNLOAD ERROR: $error');
                                });
                          },
                          child: const Row(
                            children: [
                              SubHeadingText(
                                //underline: true,
                                title: "View Resume",
                                titleColor: darkerPrimary,
                                fontSize: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // SvgPicture.asset(
                              //   "assets/Icons/Link.svg",
                              //   height: 20,
                              //   // ignore: deprecated_member_use
                              //   color: darkerPrimary,
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // child: Row(
                    //   children: [
                    //     Icon(Icons.description, color: Colors.grey[700]),
                    //     SizedBox(width: 10),
                    //     Expanded(
                    //       child: Text("Resume.pdf"),
                    //     ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(height: 20),

                  const CustomLine(),

                  const SizedBox(height: 20),
                  const HeadingText(
                    title: "Questions",
                  ),
                  const SizedBox(height: 16),
                  const Column(
                    spacing: 25,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingText(
                            title: "How many years of experience",
                            titleColor: darkerPrimary,
                          ),
                          Row(
                            children: [
                              SubHeadingText1(
                                title: "Answer : ",
                                titleColor: darkerPrimary,
                              ),
                              SubHeadingText(
                                title: "Ans25",
                                titleColor: darkerPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingText(
                            title: "How many years of experience",
                            titleColor: darkerPrimary,
                          ),
                          Row(
                            children: [
                              SubHeadingText1(
                                title: "Answer : ",
                                titleColor: darkerPrimary,
                              ),
                              SubHeadingText(
                                title: "Ans25",
                                titleColor: darkerPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingText(
                            title: "How many years of experience",
                            titleColor: darkerPrimary,
                          ),
                          Row(
                            children: [
                              SubHeadingText1(
                                title: "Answer : ",
                                titleColor: darkerPrimary,
                              ),
                              SubHeadingText(
                                title: "Ans25",
                                titleColor: darkerPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Buttons
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              // child: SaveButton(
              //   onTap: () {},
              // )

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set your container color
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05), // Shadow color
                      spreadRadius: 10, // Spread of the shadow
                      blurRadius: 50, // Blur effect
                      offset:
                          const Offset(0, 0), // Position of the shadow (x, y)
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightRedColor,
                              // foregroundColor: redColor,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              overlayColor: offwhiteColor,
                            ),
                            child: const HeadingText(
                              title: "Reject",
                              titleColor: redColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            slideTo(context, SendResponsePage());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightGreenColor,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            overlayColor: offwhiteColor,
                          ),
                          child: const HeadingText(
                            title: "Accept",
                            titleColor: greenColor,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String label;
  final String value;

  const InfoText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey[600])),
        SizedBox(height: 2),
        Text(value,
            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
