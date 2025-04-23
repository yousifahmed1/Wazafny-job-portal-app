import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/add_experience.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/edit_all_experiences.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final seekerProfile = context.watch<ProfileCubit>().state;

    if (seekerProfile is ProfileLoaded) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const HeadingText(title: "Experience"),
                  const Spacer(),
                  InkWell(
                    onTap: () => slideUp(context, const AddExperience()),
                    child: SvgPicture.asset(
                      "assets/Icons/Add_icon.svg",
                      width: 25,
                      height: 25,
                    ),
                  ),
                  seekerProfile.profile.experience.isNotEmpty
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () =>
                                  slideUp(context, const EditAllExperiences()),
                              child: SvgPicture.asset(
                                "assets/Icons/edit_icon.svg",
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                ],
              ),
              seekerProfile.profile.experience.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.only(top: 30),
                      shrinkWrap:
                          true, // Ensures ListView takes only needed space
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 30,
                      ),
                      itemCount: seekerProfile.profile.experience.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SvgPicture.asset(
                              "assets/Icons/Experience_icon.svg",
                              height: 55,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingText(
                                  title:
                                      "${seekerProfile.profile.experience[index].jobTitle}",
                                ),
                                Row(
                                  children: [
                                    SubHeadingText2(
                                      title:
                                          "${seekerProfile.profile.experience[index].employmentType}",
                                      titleColor: darkPrimary,
                                    ),
                                    SubHeadingText2(
                                      title:
                                          " - ${seekerProfile.profile.experience[index].company}",
                                      titleColor: darkPrimary,
                                    ),
                                  ],
                                ),
                                SubHeadingText2(
                                    title:
                                        "${seekerProfile.profile.experience[index].startDate} - ${seekerProfile.profile.experience[index].endDate}"),
                              ],
                            )
                          ],
                        );
                      
                      },
                    )
                  : const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: SubHeadingText2(
                        title:
                            "Add your work experience, including job roles and responsibilities, here.",
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
