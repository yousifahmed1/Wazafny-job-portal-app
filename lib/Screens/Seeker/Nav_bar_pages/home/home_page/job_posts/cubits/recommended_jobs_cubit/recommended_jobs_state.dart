import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/job_posts/model/job_post_model.dart';

abstract class JobState {}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<JobModel> jobs;

  JobLoaded(this.jobs);
}

class JobError extends JobState {
  final String message;

  JobError(this.message);
}
