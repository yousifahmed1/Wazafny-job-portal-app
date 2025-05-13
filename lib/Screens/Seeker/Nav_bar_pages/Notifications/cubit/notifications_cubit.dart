import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/cubit/notifications_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Notifications/services/notifications_services.dart';

class SeekerNotificationsCubit extends Cubit<NotificationsState> {
  SeekerNotificationsCubit() : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());

    try {
      final notifications = await NotificationsServices().fetchNotofications();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  void reset() {
    emit(NotificationsInitial());
  }
}
