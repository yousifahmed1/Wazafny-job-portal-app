import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/Dashboard/models/dashboard_model.dart';
import 'package:wazafny/Screens/Company/Dashboard/services/dashboard_services.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'dashboard_state.dart';

class CompanyDashboardCubit extends Cubit<DashboardState> {
  CompanyDashboardCubit() : super(DashboardInitial());

  Future<void> fetchStats() async {
    final DashboardServices dashboardServices = DashboardServices();

    emit(DashboardLoading());

    try {
      final statsResponse =
          await dashboardServices.getStats(); // returns StatsModel

      final jobsResponse = await dashboardServices
          .getLatestJobs(); // returns List<LatestJobsModel>

      final companyName = await AuthRepository().getCompanyName();

      final dashboardData = DashboardModel(
        companyName: companyName ?? "",
        stats: statsResponse,
        latestJobs: jobsResponse,
      );

      emit(DashboardLoaded(dashboardData));
    } catch (e) {
      emit(DashboardError('Failed to load stats: $e'));
    }
  }

  void reset() {
    emit(DashboardInitial());
  }
}
