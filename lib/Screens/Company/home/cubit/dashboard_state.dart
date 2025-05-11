import 'package:equatable/equatable.dart';
import 'package:wazafny/Screens/Company/home/models/dashboard_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardModel dashboardData;

  const DashboardLoaded(this.dashboardData);

  @override
  List<Object?> get props => [dashboardData];
}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError(this.error);

  @override
  List<Object?> get props => [error];
}
