import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/widgets/search_bar_profile_circle.dart';
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
      'companyName': 'Google',
      'jobTitle': 'UI/UX Designer',
      'time': '1h',
      'image':
          "https://pbs.twimg.com/profile_images/916226140385300480/Is3xaqFY_400x400.jpg",
    },
    {
      'companyName': 'Microsoft',
      'jobTitle': 'Software Engineer',
      'time': '3h',
      'image':
          "https://pbs.twimg.com/profile_images/916226140385300480/Is3xaqFY_400x400.jpg",
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
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    notification['image'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: darkPrimary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: notification['companyName'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const TextSpan(
                                            text: " Posted new job for "),
                                        TextSpan(
                                          text: notification['jobTitle'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  notification['time'],
                                  style: const TextStyle(
                                    color: darkPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
