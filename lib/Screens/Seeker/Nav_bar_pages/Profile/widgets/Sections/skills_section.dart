import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/add_edit_skills.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final seekerProfile = context.watch<ProfileCubit>().state;

    if (seekerProfile is ProfileLoaded) {
      return Container(
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const HeadingText(title: "Skills"),
                  const Spacer(),
                  InkWell(
                    onTap: () => slideUp(context, const EditAddSkills()),
                    child: Container(
                      child: seekerProfile.profile.skills.isEmpty
                          ? SvgPicture.asset(
                              "assets/Icons/Add_icon.svg",
                              width: 25,
                              height: 25,
                            )
                          : SvgPicture.asset(
                              "assets/Icons/edit_icon.svg",
                              width: 20,
                              height: 20,
                            ),
                    ),
                  )
                ],
              ),
              seekerProfile.profile.skills.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.only(top: 30),
                      shrinkWrap:
                          true, // Ensures ListView takes only needed space
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 1,
                          color: linesColor.withValues(alpha: 0.4),
                        ),
                      ),
                      itemCount: seekerProfile.profile.skills.length,
                      itemBuilder: (context, index) {
                        return SubHeadingText(
                          title: seekerProfile.profile.skills[index].skill!,
                          titleColor: darkerPrimary,
                          fontSize: 20,
                        );
                      },
                    )
                  : const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: SubHeadingText2(
                        title: "List your key skills and expertise here.",
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
