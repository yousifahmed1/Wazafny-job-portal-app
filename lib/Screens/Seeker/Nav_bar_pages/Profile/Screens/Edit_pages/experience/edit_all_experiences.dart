import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/experience/add_edit_experience.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/delete_experience_dialog.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/custom_line.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import '../../../../../../../widgets/custom_app_bar.dart';
import '../../../cubit/profile_cubit.dart';
import '../../../cubit/profile_states.dart';

class EditAllExperiences extends StatefulWidget {
  const EditAllExperiences({super.key});

  @override
  State<EditAllExperiences> createState() => _EditAllExperiencesState();
}

class _EditAllExperiencesState extends State<EditAllExperiences> {
  var experienceList = [];

  void handleDeleteExperience(BuildContext context, int experienceId) {
    context
        .read<SeekerProfileCubit>()
        .deleteExperience(experienceId: experienceId);
    context.read<SeekerProfileCubit>().fetchProfile();
    Navigator.of(context).pop(); // close the dialog
    ///
  }

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    try {
      Future.delayed(const Duration(milliseconds: 00), () {
        // ignore: use_build_context_synchronously
        Navigator.pop(context); // Go back from edit page
      });
    } catch (e) {
      Navigator.pop(context); // Close loading dialog in case of error
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeekerProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          // Initialize controllers with the profile data
          experienceList = state.profile.experience;
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: CustomAppBar1(
            title: "Personal Information",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 100),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: experienceList.length + 1,
                        itemBuilder: (context, index) {
                          if (index < experienceList.length) {
                            final experience = experienceList[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/Icons/Experience_icon.svg",
                                  height: 55,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          HeadingText(
                                            title: experience.jobTitle ?? '',
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () => slideTo(
                                              context,
                                              AddExperience(
                                                experience: experience,
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/Icons/edit_icon.svg",
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          SubHeadingText2(
                                            title:
                                                experience.employmentType ?? '',
                                            titleColor: darkerPrimary,
                                          ),
                                          SubHeadingText2(
                                            title: " - ${experience.company}",
                                            titleColor: darkerPrimary,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          SubHeadingText2(
                                            title:
                                                "${experience.startDate} - ${experience.endDate}",
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              if (experience.experienceID !=
                                                  null) {
                                                setState(() {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) {
                                                      return DeleteExperienceDialog(
                                                        onConfirm: () =>
                                                            handleDeleteExperience(
                                                                context,
                                                                experience
                                                                    .experienceID!),
                                                      );
                                                    },
                                                  );
                                                });
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              "assets/Icons/delete_icon.svg",
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Add New Experience button
                            return InkWell(
                              onTap: () {
                                slideTo(context, const AddExperience());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Icons/Add_icon.svg",
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.cover,
                                    // ignore: deprecated_member_use
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  const HeadingText(
                                    title: "Add New Experience",
                                    titleColor: primaryColor,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CustomLine(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SaveButton(onTap: () => _handleSave(context, state)),
              ),
            ],
          ),
        );
      },
    );
  }
}
