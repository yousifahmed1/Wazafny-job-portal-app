import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/Services/job_applications_services.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/cubit/job_applications_state.dart';

class JobApplicationsCubit extends Cubit<JobApplicationsState> {
  JobApplicationsCubit() : super(JobApplicationsInitial());

  Future<void> fetchJobApplications() async {
    emit(JobApplicationsLoading());
    try {
      final applications =
          await JobApplicationServices().fetchSeekerJobApplications();
      emit(JobApplicationsLoaded(applications));
    } catch (e) {
      emit(JobApplicationsError(e.toString()));
    }
  }
}
