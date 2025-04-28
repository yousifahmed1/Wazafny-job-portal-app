import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/widgets/notifications_list_view.dart';
import 'package:wazafny/widgets/search_bar_profile_circle.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final TextEditingController _searchController = TextEditingController();

  // Define notifications array
  List<Map<String, dynamic>> notifications = [
    {
      'companyName': 'Vodafone',
      'jobTitle': 'Flutter Developer',
      'time': '22m',
      'image':
          "https://pbs.twimg.com/profile_images/916226140385300480/Is3xaqFY_400x400.jpg",
    },
    {
      'companyName': 'Amazon',
      'jobTitle': 'UI/UX Designer',
      'time': '1h',
      'image':
          "https://i.pinimg.com/originals/01/ca/da/01cada77a0a7d326d85b7969fe26a728.jpg",
    },
    {
      'companyName': 'Microsoft',
      'jobTitle': 'Software Engineer',
      'time': '3h',
      'image':
          "https://brandlogos.net/wp-content/uploads/2020/03/Microsoft-logo-512x512.png",
    },
  ];

  // Function to clear all notifications
  void clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Column(
          children: [
            //search bar and profile circle
            SearchBarProfileCircle(searchController: _searchController),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeadingText(title: "Notifications center"),
                      const Spacer(),
                      !notifications.isNotEmpty
                          ? const SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: lightPrimary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: InkWell(
                                  onTap:
                                      clearAllNotifications, // Connect to clear function
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),

            notifications.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                        "No notifications yet",
                        style: TextStyle(
                          color: bordersColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: NotificationsListView(notifications: notifications),
                  ),
          ],
        ),
      ),
    );
  }
}
