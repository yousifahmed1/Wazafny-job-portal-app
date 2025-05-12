import 'package:equatable/equatable.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/Job_applications_model.dart';

abstract class ApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApplicationInitial extends ApplicationState {}

class ApplicationLoading extends ApplicationState {}

class ApplicationEmpty extends ApplicationState {}

class ApplicationLoaded extends ApplicationState {
  final CompanyJobApplicationModel jobApplication;

  ApplicationLoaded(this.jobApplication);

  @override
  List<Object?> get props => [jobApplication];
}

class ApplicationError extends ApplicationState {
  final String message;

  ApplicationError(this.message);

  @override
  List<Object?> get props => [message];
}
