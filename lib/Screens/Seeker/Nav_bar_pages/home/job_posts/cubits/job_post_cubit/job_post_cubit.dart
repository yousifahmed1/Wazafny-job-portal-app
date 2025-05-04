import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_post_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/services/Job_services.dart';
part 'job_post_state.dart';

class JobPostCubit extends Cubit<JobPostState> {
  JobPostCubit() : super(JobPostInitial());
  Future<void> fetchJobPostDetails({required int jobId}) async {
    emit(JobPostLoading());
    try {
      log('JobCubit: Fetching jobs');
      emit(JobPostLoading());
      final jobs = await JobService().getJobPostDetails(jobId: jobId);
      log('JobCubit: Jobs fetched successfully');
      emit(JobPostLoaded(jobPostModel: jobs));
    } catch (e) {
      log('JobCubit error: $e');
      emit(JobPostError(e.toString()));
    }
  }
}


