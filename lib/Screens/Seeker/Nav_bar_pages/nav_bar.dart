import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/applications_page.dart';
import 'package:wazafny/constants.dart';
import 'home/home_page/home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(), // This will contain the TabBar for Jobs and Company
    ApplicationPage(), // For "My Applications"
    Scaffold(), // For "Notifications"
    const Placeholder(), // For "Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _screens[_selectedIndex]),
          Container(
            height: 105,
            decoration: BoxDecoration(
              color: Colors.white, // Set your container color
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
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
                    childAfter:
                        const IconNav(title: "Home", iconPath: "HomeFill.svg"),
                    childBefore: const IconNav(
                        title: "Home", iconPath: "HomeStroke.svg"),
                  ),
                  ItemNavigationView(
                    childAfter: const IconNav(
                        title: "Applications",
                        iconPath: "applicationStroke.svg"),
                    childBefore: const IconNav(
                        title: "Applications", iconPath: "applicationFill.svg"),
                  ),
                  ItemNavigationView(
                    childAfter: const IconNav(
                        title: "Notifications",
                        iconPath: "NotificationsFill.svg"),
                    childBefore: const IconNav(
                        title: "Notifications",
                        iconPath: "NotificationsStroke.svg"),
                  ),
                  ItemNavigationView(
                    childAfter: const IconNav(
                        title: "Profile", iconPath: "ProfileFill.svg"),
                    childBefore: const IconNav(
                        title: "Profile", iconPath: "ProfileStroke.svg"),
                  ),
                ],
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
  });

  final String title;
  final String iconPath;

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
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style:
              const TextStyle(color: darkPrimary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
