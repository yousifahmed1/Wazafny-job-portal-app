import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';
import 'package:wazafny/Screens/Company/JobPosts/Screens/Jobposts/company_job_posts.dart';
import 'package:wazafny/Screens/Company/Profile/screens/company_profile_page.dart';
import 'package:wazafny/Screens/Company/Dashboard/Screens/company_home.dart';

import 'package:wazafny/core/constants/constants.dart';

class NavBarCompany extends StatefulWidget {
  const NavBarCompany({super.key, this.index = 0});
  final int index;

  @override
  State<NavBarCompany> createState() => _NavBarCompanyState();
}

class _NavBarCompanyState extends State<NavBarCompany> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  final List<Widget> _screens = [
    const CompanyDashboardPage(),
    const CompanyJobPostPage(),
    const CompanyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 105,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(23), // Set your container color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // Shadow color
                    spreadRadius: 10, // Spread of the shadow
                    blurRadius: 50, // Blur effect
                    offset: const Offset(0, 0), // Position of the shadow (x, y)
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: NavigationView(
                  onChangePage: (c) {
                    setState(() {
                      _selectedIndex = c;
                    });
                  },
                  durationAnimation: const Duration(milliseconds: 300),
                  color: Colors.transparent,
                  borderTopColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  gradient: LinearGradient(
                      colors: [
                        Colors.white.withAlpha(0),
                        Colors.white.withAlpha(0),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 0.0),
                      stops: const [0.0, 0.0],
                      tileMode: TileMode.mirror),
                  items: [
                    ItemNavigationView(
                      childAfter: IconNav(
                          isSelected: _selectedIndex == 0,
                          title: "Dashboard",
                          iconPath: "HomeFill.svg"),
                      childBefore: IconNav(
                          isSelected: _selectedIndex == 0,
                          title: "Dashboard",
                          iconPath: "HomeStroke.svg"),
                    ),
                    ItemNavigationView(
                      childAfter: IconNav(
                          isSelected: _selectedIndex == 1,
                          title: "Job Posts",
                          iconPath: "applicationStroke.svg"),
                      childBefore: IconNav(
                          isSelected: _selectedIndex == 1,
                          title: "Job Posts",
                          iconPath: "applicationFill.svg"),
                    ),
                    ItemNavigationView(
                      childAfter: IconNav(
                          isSelected: _selectedIndex == 2,
                          title: "Profile",
                          iconPath: "ProfileFill.svg"),
                      childBefore: IconNav(
                          isSelected: _selectedIndex == 2,
                          title: "Profile",
                          iconPath: "ProfileStroke.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconNav extends StatelessWidget {
  const IconNav({
    super.key,
    required this.title,
    required this.iconPath,
    this.isSelected = false,
  });

  final String title;
  final String iconPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 3,
        ),
        SvgPicture.asset(
          "assets/Icons/$iconPath",
          width: 30,
          height: 30,
          color: isSelected ? darkerPrimary : Colors.grey,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(
              color: isSelected ? darkerPrimary : Colors.grey,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
