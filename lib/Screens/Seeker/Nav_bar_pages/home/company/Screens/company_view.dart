import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/Screens/company_view_about.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/Screens/company_view_posts.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/services/company_services.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key, required this.companyID});

  final int companyID;

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  late bool isFollwed;
  @override
  void initState() {
    super.initState();
    future = _loadComapnyProfileData();
  }

  Future<void> _followCompany() async {
    await CompanyServices().followCompany(companyId: widget.companyID);
    setState(() {
      isFollwed = true;
    });
    context.read<ProfileCubit>().fetchProfile();
  }

  Future<void> _unfollowCompany() async {
    await CompanyServices().unfollowCompany(companyId: widget.companyID);
    setState(() {
      isFollwed = false;
    });
    context.read<ProfileCubit>().fetchProfile();
  }

  var future;
  Future<CompanyModel> _loadComapnyProfileData() async {
    final data =
        await CompanyServices().showComapnyProfile(companyId: widget.companyID);
    isFollwed = data.followStatus ?? false;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompanyModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator())); // Loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error
        } else if (snapshot.hasData) {
          final company = snapshot.data!;

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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: company.coverImg != null &&
                                    company.coverImg != ""
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
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Profile Picture

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: company.profileImg != null &&
                                            company.profileImg != ""
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
                                      isFollwed == false
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  //isFollwed = true;

                                                  _followCompany();
                                                });
                                              },
                                              child: const Button1(
                                                text: "Follow",
                                                size: 18,
                                                btnColor: primaryColor,
                                                width: 110,
                                                height: 50,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  //isFollwed = false;

                                                  _unfollowCompany();
                                                });
                                              },
                                              child: const RoundedButton(
                                                text: "Following",
                                                size: 16,
                                                borderColor: darkerPrimary,
                                                width: 110,
                                                height: 50,
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SubHeadingText(
                                        title:
                                            "${company.followersCount} Followers",
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
                                  // company.companyEmail != null
                                  //     ? Row(
                                  //         children: [
                                  //           SubHeadingText(
                                  //             title: company.companyEmail!,
                                  //             titleColor: primaryColor,
                                  //           ),
                                  //           const SizedBox(width: 10),
                                  //           SvgPicture.asset(
                                  //             "assets/Icons/Link.svg",
                                  //             width: 25,
                                  //             height: 25,
                                  //           ),
                                  //         ],
                                  //       )
                                  //     : const SizedBox(),
                                  Center(
                                    child: Container(
                                      height: 60,
                                      width: 270,
                                      color: Colors.white,
                                      child: TabBar(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        dividerColor: Colors.transparent,
                                        labelColor: darkerPrimary,
                                        unselectedLabelColor: darkerPrimary,
                                        indicator: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: primaryColor,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                        tabs: const [
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
                  Expanded(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        CompanyViewAbout(
                          company: company,
                        ),
                        company.jobPosts!.isEmpty
                            ? const Center(child: Text('No posts found.'))
                            : CompanyViewPosts(
                                company: company,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No companies found.'));
        }
      },
    );
  }
}
