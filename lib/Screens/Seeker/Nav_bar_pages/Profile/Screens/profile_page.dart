import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/Sections/about_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/Sections/education_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/Sections/experience_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/Sections/personal_informations_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/Sections/resume_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/Sections/skills_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<SeekerProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            // Show loading indicator while profile is loading
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            // Display profile data when loaded
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SeekerProfileCubit>().fetchProfile();
              },
              child: ListView(
                padding: const EdgeInsets.only(bottom: 95), //navbar height

                children: [
                  const PersonalInformations(), // Sections don't need data passed now
                  const SizedBox(height: 10),
                  const AboutSection(),
                  const SizedBox(height: 10),
                  const ResumeSection(),
                  const SizedBox(height: 10),
                  const ExperienceSection(),
                  const SizedBox(height: 10),
                  const EducationSection(),
                  const SizedBox(height: 10),
                  const SkillsSection(),
                  //navbar fix border radius effect pink background
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            // Show error message if something went wrong
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox(); // Empty fallback
        },
      ),
    );
  }
}
