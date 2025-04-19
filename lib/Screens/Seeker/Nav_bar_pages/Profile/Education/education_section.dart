import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/models/profile_model.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({
    super.key,
    required this.seekerProfile,
  });
  final SeekerProfileModel seekerProfile;

  @override
  Widget build(BuildContext context) {
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
                seekerProfile.education != null
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
            const SizedBox(
              height: 30,
            ),
            seekerProfile.education != null
                ? Row(
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
                              "${seekerProfile.education!["university"]}",
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: darkPrimary,
                              ),
                            ),
                            SubHeadingText2(
                              title: "${seekerProfile.education!["major"]}",
                              titleColor: darkPrimary,
                            ),
                            SubHeadingText2(
                              title: "${seekerProfile.education!["duration"]}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: SubHeadingText2(
                      title:
                          "Add your degree, field of study, and university name here.",
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
