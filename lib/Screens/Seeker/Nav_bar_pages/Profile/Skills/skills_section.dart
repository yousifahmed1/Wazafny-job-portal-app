import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/models/profile_model.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({
    super.key, required this.seekerProfile,
  });

final SeekerProfileModel seekerProfile ;

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
                const HeadingText(title: "Skills"),
                const Spacer(),
                SvgPicture.asset(
                  "assets/Icons/Add_icon.svg",
                  width: 25,
                  height: 25,
                ),
                seekerProfile.skills != null
                    ? Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          SvgPicture.asset(
                            "assets/Icons/edit_icon.svg",
                            width: 25,
                            height: 25,
                          ),
                        ],
                      )
                    : const SizedBox(
                        width: 0,
                      ),
              ],
            ),
            seekerProfile.skills != null
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
                    itemCount: seekerProfile.skills!.length,
                    itemBuilder: (context, index) {
                      return SubHeadingText(
                        title: seekerProfile.skills![index],
                        titleColor: darkPrimary,
                        fontSize: 20,
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: SubHeadingText2(
                      title: "List your key skills and expertise here.",
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
