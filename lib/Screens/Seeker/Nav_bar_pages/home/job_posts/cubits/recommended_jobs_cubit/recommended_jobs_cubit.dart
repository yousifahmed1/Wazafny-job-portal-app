import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/cubits/recommended_jobs_cubit/recommended_jobs_state.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/services/Job_services.dart';

class SeekerJobCubit extends Cubit<JobState> {
  SeekerJobCubit() : super(JobInitial());

  Future<void> fetchJobs() async {
    try {
      log('JobCubit: Fetching jobs');
      emit(JobLoading());
      final jobs = await JobService().getJobs();
      log('JobCubit: Jobs fetched successfully');
      emit(JobLoaded(jobs));
    } catch (e) {
      log('JobCubit error: $e');
      emit(JobError(e.toString()));
    }
  }

  void reset() {
    emit(JobInitial());
  }
}
