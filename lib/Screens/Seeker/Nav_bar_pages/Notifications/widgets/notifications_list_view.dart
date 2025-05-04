import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/model/notifications_model.dart';
import 'package:wazafny/core/constants/constants.dart';

class NotificationsListView extends StatelessWidget {
  const NotificationsListView({
    super.key,
    required this.notifications,
  });

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 105), //navbar height
      separatorBuilder: (context, index) => const SizedBox(height: 15),
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
                  child: notification.profileImg.isNotEmpty &&
                          notification.profileImg != ""
                      ? Image.network(
                          notification.profileImg,
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        )
                      : SvgPicture.asset(
                          "assets/Images/Profile-default-image.svg",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
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
                          text: notification.companyName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(text: " Posted new job for "),
                        TextSpan(
                          text: notification.jobTitle,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  notification.timeAgo,
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
