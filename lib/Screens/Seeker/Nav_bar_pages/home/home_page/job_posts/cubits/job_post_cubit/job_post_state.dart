part of 'job_post_cubit.dart';

abstract class JobPostState {}

final class JobPostInitial extends JobPostState {}

class JobPostLoading extends JobPostState {}

class JobPostLoaded extends JobPostState {
  final JobPostModel jobPostModel;
  JobPostLoaded({required this.jobPostModel});
}

class JobPostError extends JobPostState {
  final String error;
  JobPostError(this.error);
}
