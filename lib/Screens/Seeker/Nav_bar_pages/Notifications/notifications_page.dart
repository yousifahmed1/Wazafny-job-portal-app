import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/model/notifications_model.dart';
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

  // Function to clear all notifications
  void clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<NotificationsCubit>().fetchNotifications();
          });
          return const Center(child: Text('Loading notifications...'));
        }
        if (state is NotificationsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NotificationsError) {
          return Center(child: Text('Error: ${state.error}'));
        }
        if (state is NotificationsLoaded) {
          notifications = state.notifications;
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
                        child:
                            NotificationsListView(notifications: notifications),
                      ),
              ],
            ),
          ),
        );
      
      }else {
              return const SizedBox(); // fallback for initial state
            }
      },
    );
  }
}
