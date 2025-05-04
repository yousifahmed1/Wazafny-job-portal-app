import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/add_edit_education.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({
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
                  const HeadingText(title: "Education"),
                  const Spacer(),
                  seekerProfile.profile.education != null
                      ? InkWell(
                        onTap: () =>
                              slideUp(context,  AddEditEducation()),
                        child: SvgPicture.asset(
                            "assets/Icons/edit_icon.svg",
                            width: 20,
                            height: 20,
                          ),
                      )
                      : InkWell(
                          onTap: () =>
                              slideUp(context, const AddEditEducation()),
                          child: SvgPicture.asset(
                            "assets/Icons/Add_icon.svg",
                            width: 25,
                            height: 25,
                          ),
                        ),
                ],
              ),
              seekerProfile.profile.education != null
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/Icons/Education_icon.svg",
                              height: 55,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${seekerProfile.profile.education?.university}",
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: darkPrimary,
                                    ),
                                  ),
                                  SubHeadingText2(
                                    title:
                                        "${seekerProfile.profile.education?.college}",
                                    titleColor: darkPrimary,
                                  ),
                                  SubHeadingText2(
                                      title:
                                          "${seekerProfile.profile.education?.startDate} - ${seekerProfile.profile.education?.endDate}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: SubHeadingText2(
                        title:
                            "Add your degree, field of study, and university name here.",
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
