
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';

import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/edit_resume_page.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final seekerProfile = context.watch<ProfileCubit>().state;

    if (seekerProfile is ProfileLoaded) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            children: [
              Row(
                children: [
                  const HeadingText(title: "Resume"),
                  const Spacer(),
                  InkWell(
                    onTap: () => slideUp(context, const EditResume()),
                    child: Container(
                      child: seekerProfile.profile.resume.isNotEmpty
                          ? SvgPicture.asset(
                              "assets/Icons/edit_icon.svg",
                              width: 20,
                              height: 20,
                            )
                          : SvgPicture.asset(
                              "assets/Icons/Add_icon.svg",
                              width: 25,
                              height: 25,
                            ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              seekerProfile.profile.resume.isNotEmpty
                  ? Row(
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
                                url: seekerProfile.profile.resume,


                                onDownloadCompleted: (String path) {
                                  print('FILE DOWNLOADED TO PATH: $path');
                                      OpenFile.open(path);


                                },
                                onDownloadError: (String error) {
                                  print('DOWNLOAD ERROR: $error');
                                });
                          },
                         
                          child: Row(
                            children: [
                              const SubHeadingText(
                                underline: true,
                                title: "Resume",
                                titleColor: darkPrimary,
                                fontSize: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                "assets/Icons/Link.svg",
                                height: 25,
                                color: darkPrimary,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: SubHeadingText2(
                        title:
                            "Upload your resume here to showcase your skills and experience.",
                      ),
                    )
            ],
          ),
        ),
      );
    } else if (seekerProfile is ProfileLoading) {
      return const CircularProgressIndicator(); // Show loading
    } else if (seekerProfile is ProfileError) {
      return const Text('Failed to load profile');
    }
    return Container();
  }
}
