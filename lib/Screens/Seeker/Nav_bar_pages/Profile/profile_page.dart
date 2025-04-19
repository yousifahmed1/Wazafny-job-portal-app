import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/About/about_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Education/education_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Experience/experience_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Personal_information/personal_informations_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Resume/resume_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Skills/skills_section.dart';
import 'package:wazafny/models/profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SeekerProfileModel seekerProfileModel = SeekerProfileModel(
    image:
        "https://assets.goal.com/images/v3/bltd58c4d60ecd9275e/GOAL_-_Blank_WEB_-_Facebook_-_2023-06-13T135350.847.png?auto=webp&format=pjpg&width=3840&quality=60",
    cover: null,
    firstName: "Yousif",
    lastName: "Ahmed",
    following: 2,
    headline: "Intern Flutter Developer @GCPi",
    country: "Egypt",
    city: "Banha",
    about: null,
    resume: "Yousif-flutter-Developer-cv.pdf",
    experience: [
      {
        "role": "Flutter Developer",
        "company": "GCPi",
        "type": "Intern - Part-time",
        "duration": "2023 - Present",
      }
    ],
    education: {
      "university": "Modern University for Technology & Information - MTI",
      "duration": "2021 - Present",
      "major": "Computer Science"
    },
    skills: ["Dart", "Flutter", "UI/UX", "Figma"],
    links: [
      {"name": "GitHub", "link": "https://github.com/yousifelfaham"}
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 95), //navbar height

        child: Column(
          children: [
            PersonalInformations(seekerProfile: seekerProfileModel),
            const SizedBox(
              height: 10,
            ),
            AboutSection(
              about: seekerProfileModel.about,
            ),
            const SizedBox(
              height: 10,
            ),
            ResumeSection(seekerProfile: seekerProfileModel),
            const SizedBox(
              height: 10,
            ),
            ExperienceSection(seekerProfile: seekerProfileModel),
            const SizedBox(
              height: 10,
            ),
            EducationSection(seekerProfile: seekerProfileModel),
            const SizedBox(
              height: 10,
            ),
            SkillsSection(seekerProfile: seekerProfileModel),

            //navbar fix border radius effect pink background
            Container(
              width: double.infinity,
              height: 10,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
