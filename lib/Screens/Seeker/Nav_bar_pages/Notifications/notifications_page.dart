import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/model/notifications_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/services/notifications_services.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/widgets/notifications_list_view.dart';
import 'package:wazafny/widgets/search_bar_profile_circle.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final TextEditingController _searchController = TextEditingController();

  List<NotificationModel> allNotifications = []; // Original fetched list
  List<NotificationModel> filteredNotifications = []; // Shown list

  @override
  void initState() {
    super.initState();
    // Listen to search text changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredNotifications = allNotifications.where((notification) {
        return notification.jobTitle.toLowerCase().contains(query) ||
            notification.companyName.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Clear all notifications
  Future<void> clearAllNotifications() async {
    await NotificationsServices().deleteAllNotifications();

    setState(() {
      allNotifications.clear();
      filteredNotifications.clear();
    });

    //context.read<NotificationsCubit>().fetchNotifications();
  }

  // Handle single notification deletion
  void handleNotificationDeleted(int notificationId) {
    setState(() {
      // Remove from both lists
      allNotifications.removeWhere(
          (notification) => notification.notificationId == notificationId);
      filteredNotifications.removeWhere(
          (notification) => notification.notificationId == notificationId);
    });
  }

  // Refresh notifications from server
  Future<void> _refreshNotifications() async {
    await context.read<SeekerNotificationsCubit>().fetchNotifications();
    // Note: We don't update state here as BlocBuilder will handle that
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Column(
          children: [
            // Search bar with listener
            SearchBarProfileCircle(searchController: _searchController),
            const SizedBox(height: 15),

            // Header & Clear button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeadingText(title: "Notifications center"),
                      const Spacer(),
                      if (filteredNotifications.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: lightPrimary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: InkWell(
                              onTap: clearAllNotifications,
                              child: const Text(
                                "Clear",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
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

            // Notifications List
            Expanded(
              child: BlocBuilder<SeekerNotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsInitial) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<SeekerNotificationsCubit>()
                          .fetchNotifications();
                    });
                    return const Center(
                        child: Text('Loading notifications...'));
                  }
                  if (state is NotificationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NotificationsError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  if (state is NotificationsLoaded) {
                    // Only load notifications if list is empty (avoid override when searching)
                    if (allNotifications.isEmpty) {
                      allNotifications = state.notifications;
                      filteredNotifications = allNotifications;
                    }

                    return filteredNotifications.isEmpty
                        ? RefreshIndicator(
                            onRefresh: _refreshNotifications,
                            child: ListView(
                              children: const [
                                SizedBox(height: 40),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 100),
                                    child: Text(
                                      "No notifications yet",
                                      style: TextStyle(
                                        color: bordersColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _refreshNotifications,
                            child: NotificationsListView(
                              notifications: filteredNotifications,
                              onNotificationDeleted: handleNotificationDeleted,
                            ),
                          );
                  } else {
                    return const SizedBox(); // fallback
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
