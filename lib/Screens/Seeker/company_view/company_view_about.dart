import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class CompanyViewAbout extends StatefulWidget {
  const CompanyViewAbout({
    super.key,
  });

  @override
  State<CompanyViewAbout> createState() => _CompanyViewAboutState();
}

class _CompanyViewAboutState extends State<CompanyViewAbout> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingText1(title: "About"),
              Column(
                children: [
                  Paragraph(
                    cutLine: isExpanded,
                    paragraph:
                        "At Vodafone, we believe that connectivity is a force for good. If we use it for the things that really matter, it can improve people's lives and the world around us.\nThrough our technology we empower people, connecting everyone regardless of who they are or where they live, we protect the planet and help our customers do the same.\n\nBut we’re not just shaping the future of technology for our customers – we’re shaping the future for everyone who joins our team too. When you work with us, you’re part of a global mission to connect people, solve complex challenges, and create a sustainable, more inclusive world.If you want to grow your career whilst finding the perfect balance between work and life, Vodafone offers the opportunities and support to help you belong and make a real impact.",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: SubHeadingText(
                        title: isExpanded ? "Show less" : "Show more",
                        titleColor: darkPrimary,
                      ))
                ],
              ),
              ListView.builder(
                shrinkWrap: true, // Constrain height to content
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingText(title: "Industry"),
                      SizedBox(
                        height: 10,
                      ),
                      SubHeadingText(
                        title: "Telecommunications",
                        titleColor: darkPrimary,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
