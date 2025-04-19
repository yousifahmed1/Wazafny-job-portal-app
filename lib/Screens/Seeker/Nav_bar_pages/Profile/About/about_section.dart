import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key, required this.about});

  final String? about;

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          children: [
            Row(
              children: [
                const HeadingText(title: "About"),
                const Spacer(),
                SvgPicture.asset(
                  widget.about != null
                      ? "assets/Icons/edit_icon.svg"
                      : "assets/Icons/Add_icon.svg",
                  width: 20,
                  height: 20,
                ),
              ],
            ),
            const SizedBox(height: 5),
            widget.about != null
                ? Column(
                    children: [
                      Paragraph(
                        cutLine: isExpanded,
                        paragraph: widget.about!,
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: SubHeadingText(
                          title: isExpanded ? "Show more" : "Show less",
                          titleColor: darkPrimary,
                        ),
                      )
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: SubHeadingText2(
                      title:
                          "Mention your years of experience, industry, key skills, achievements, and past work experiences.",
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
