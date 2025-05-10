import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ExrtraInformation extends StatefulWidget {
  const ExrtraInformation({
    super.key,
    required this.company,
  });

  final CompanyModel company;

  @override
  State<ExrtraInformation> createState() => _ExrtraInformationState();
}

class _ExrtraInformationState extends State<ExrtraInformation> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15, bottom: 105),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingText1(title: "About"),
              widget.company.about == null
                  ? const SizedBox()
                  : Column(
                      children: [
                        Paragraph(
                          cutLine: isExpanded,
                          paragraph: widget.company.about!,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: SubHeadingText(
                                  title: isExpanded ? "Show more" : "Show less",
                                  titleColor: darkerPrimary,
                                )),
                          ],
                        )
                      ],
                    ),
              widget.company.companyEmail == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const HeadingText(title: "Email"),
                          const SizedBox(
                            height: 10,
                          ),
                          SubHeadingText(
                            title: widget.company.companyEmail!,
                            titleColor: darkerPrimary,
                          ),
                        ]),
              const SizedBox(
                height: 30,
              ),
              widget.company.companyIndustry == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const HeadingText(title: "Industry"),
                          const SizedBox(
                            height: 10,
                          ),
                          SubHeadingText(
                            title: widget.company.companyIndustry!,
                            titleColor: darkerPrimary,
                          ),
                        ]),
              const SizedBox(
                height: 30,
              ),
              widget.company.companySize == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const HeadingText(title: "Company size"),
                          const SizedBox(
                            height: 10,
                          ),
                          SubHeadingText(
                            title: widget.company.companySize!,
                            titleColor: darkerPrimary,
                          ),
                        ]),
              const SizedBox(
                height: 30,
              ),
              widget.company.companyHeads == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const HeadingText(title: "Headquarters"),
                          const SizedBox(
                            height: 10,
                          ),
                          SubHeadingText(
                            title: widget.company.companyHeads!,
                            titleColor: darkerPrimary,
                          ),
                        ]),
              const SizedBox(
                height: 30,
              ),
              widget.company.companyFounded == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const HeadingText(title: "Founded"),
                          const SizedBox(
                            height: 10,
                          ),
                          SubHeadingText(
                            title: widget.company.companyFounded!,
                            titleColor: darkerPrimary,
                          ),
                        ]),
              const SizedBox(
                height: 30,
              ),
              widget.company.companyCountry == null ||
                      widget.company.companyCity == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const HeadingText(title: "Location"),
                          const SizedBox(
                            height: 10,
                          ),
                          SubHeadingText(
                            title:
                                "${widget.company.companyCountry}, ${widget.company.companyCity}",
                            titleColor: darkerPrimary,
                          ),
                        ]),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
