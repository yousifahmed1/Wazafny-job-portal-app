import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/services/notifications_services.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());

    try {
      final notifications = await NotificationsServices().fetchNotofications();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }
}
