import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/model/job_applications_model.dart';

abstract class JobApplicationsState {}

class JobApplicationsInitial extends JobApplicationsState {}

class JobApplicationsLoading extends JobApplicationsState {}

class JobApplicationsLoaded extends JobApplicationsState {
  final List<JobApplicationModel> applications;

  JobApplicationsLoaded(this.applications);
}

class JobApplicationsError extends JobApplicationsState {
  final String error;

  JobApplicationsError(this.error);
}
