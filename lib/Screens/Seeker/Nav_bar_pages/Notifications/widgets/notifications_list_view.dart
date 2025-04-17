import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';

class NotificationsListView extends StatelessWidget {
  const NotificationsListView({
    super.key,
    required this.notifications,
  });

  final List<Map<String, dynamic>> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
  }
}
