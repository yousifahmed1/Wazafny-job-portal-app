import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/model/notifications_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;

  NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationsState {
  final String error;

  NotificationsError(this.error);
}
