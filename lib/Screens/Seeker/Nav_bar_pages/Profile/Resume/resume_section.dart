import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/models/profile_model.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({
    super.key,
    required this.seekerProfile,
  });
  final SeekerProfileModel seekerProfile;

  @override
  Widget build(BuildContext context) {
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
                seekerProfile.resume != null
                    ? SvgPicture.asset(
                        "assets/Icons/edit_icon.svg",
                        width: 20,
                        height: 20,
                      )
                    : SvgPicture.asset(
                        "assets/Icons/Add_icon.svg",
                        width: 20,
                        height: 20,
                      ),
              ],
            ),
            const SizedBox(height: 20),
            seekerProfile.resume != null
                ? Row(
                    children: [
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        "assets/Icons/cv_icon.svg",
                        height: 55,
                      ),
                      const SizedBox(width: 20),
                      SubHeadingText(
                        title: "${seekerProfile.firstName}-cv",
                        titleColor: darkPrimary,
                        fontSize: 20,
                      ),
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: SubHeadingText2(
                      title:
                          "Upload your resume here to showcase your skills and experience.",
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
