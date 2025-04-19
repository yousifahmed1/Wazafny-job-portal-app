import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/profile_states.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool isExpanded = false;
  bool showSeeMore = false;

  @override
  Widget build(BuildContext context) {
    final seekerProfile = context.watch<ProfileCubit>().state;

    if (seekerProfile is ProfileLoaded) {
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
                    seekerProfile.profile.about != null
                        ? "assets/Icons/edit_icon.svg"
                        : "assets/Icons/Add_icon.svg",
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              seekerProfile.profile.about != null
                  ? LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate if text exceeds 3 lines
                  showSeeMore = _isTextExceedingThreeLines(
                    seekerProfile.profile.about!,
                    constraints.maxWidth,
                    Theme.of(context).textTheme.bodyMedium!,
                  );

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Paragraph(
                              cutLine: showSeeMore && !isExpanded,
                              paragraph: seekerProfile.profile.about!,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      if (showSeeMore)
                        InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: SubHeadingText(
                            title: isExpanded ? "Show less" : "Show more",
                            titleColor: darkPrimary,
                          ),
                        ),
                    ],
                  );
                },
              )
                  : const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: SubHeadingText2(
                  title:
                  "Mention your years of experience, industry, key skills, achievements, and past work experiences.",
                ),
              ),
            ],
          ),
        ),
      );
    } else if (seekerProfile is ProfileLoading) {
      return const CircularProgressIndicator();
    } else if (seekerProfile is ProfileError) {
      return const Text('Failed to load profile');
    }
    return Container();
  }

  bool _isTextExceedingThreeLines(
      String text, double maxWidth, TextStyle textStyle) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }
}