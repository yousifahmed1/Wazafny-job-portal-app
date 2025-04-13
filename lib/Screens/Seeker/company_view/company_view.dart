import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/company_view/company_view_about.dart';
import 'package:wazafny/Screens/Seeker/company_view/company_view_posts.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  bool isFollwed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Container(
                    height: 230,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
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
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Picture

                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                "https://pbs.twimg.com/profile_images/916226140385300480/Is3xaqFY_400x400.jpg",
                                width: 120,
                                height: 120,
                              ),
                            ),

                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const HeadingText(title: "Company Name"),
                                const Spacer(),
                                isFollwed
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            isFollwed = !isFollwed;
                                          });
                                        },
                                        child: const Button1(
                                          text: "Follow",
                                          size: 18,
                                          btnColor: darkPrimary,
                                          width: 110,
                                          height: 50,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            isFollwed = !isFollwed;
                                          });
                                        },
                                        child: const RoundedButton(
                                          text: "Following",
                                          size: 18,
                                          borderColor: darkPrimary,
                                          width: 110,
                                          height: 50,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                SubHeadingText(
                                  title: "120 Followers",
                                  titleColor: darkPrimary,
                                ),
                                SizedBox(width: 20),
                                SubHeadingText(
                                  title: "46 Jobs",
                                  titleColor: darkPrimary,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const SubHeadingText1(
                              title: "Together We Can",
                              titleColor: darkPrimary,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const SubHeadingText(
                                  title: "http://www.vodafone.com/",
                                  titleColor: primaryColor,
                                ),
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  "assets/Icons/Link.svg",
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const SubHeadingText(
                                  title: "Email",
                                  titleColor: primaryColor,
                                ),
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  "assets/Icons/Link.svg",
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                height: 60,
                                width: 270,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                child: const TabBar(
                                  labelColor: darkPrimary,
                                  unselectedLabelColor: darkPrimary,
                                  indicator: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: primaryColor,
                                        width: 4,
                                      ),
                                    ),
                                  ),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'Overview',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Posts',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  CompanyViewAbout(),
                  CompanyViewPosts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
