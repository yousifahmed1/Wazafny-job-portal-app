import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class MainInformaition extends StatelessWidget {
  const MainInformaition({
    super.key,
    required this.company,
  });
  final CompanyModel company;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              image: company.coverImg != null && company.coverImg != ""
                  ? DecorationImage(
                      image: NetworkImage(company.coverImg!),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage(
                          "assets/Images/profile-banner-default.png"),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                buttonColor: Colors.white,
                onBackPressed: () => Navigator.pop(context),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture

                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child:
                          company.profileImg != null && company.profileImg != ""
                              ? Image.network(
                                  company.profileImg!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  "assets/Images/Profile-default-image.svg",
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      children: [
                        HeadingText(title: company.companyName),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/Icons/edit_icon.svg",
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SubHeadingText(
                          title: "${company.followersCount} Followers",
                          titleColor: darkerPrimary,
                        ),
                        const SizedBox(width: 20),
                        SubHeadingText(
                          title: "${company.jobsCount} Jobs",
                          titleColor: darkerPrimary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    company.headline != null
                        ? SubHeadingText1(
                            title: company.headline ?? "",
                            titleColor: darkerPrimary,
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
