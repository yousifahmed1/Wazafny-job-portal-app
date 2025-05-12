import 'package:equatable/equatable.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/job_application_view_model.dart';

abstract class JobApplicationState extends Equatable {
  const JobApplicationState();

  @override
  List<Object?> get props => [];
}

class JobApplicationInitial extends JobApplicationState {}

class JobApplicationLoading extends JobApplicationState {}

class JobApplicationLoaded extends JobApplicationState {
  final JobApplicationViewModel application;

  const JobApplicationLoaded(this.application);

  @override
  List<Object?> get props => [application];
}

class JobApplicationError extends JobApplicationState {
  final String message;

  const JobApplicationError(this.message);

  @override
  List<Object?> get props => [message];
}
