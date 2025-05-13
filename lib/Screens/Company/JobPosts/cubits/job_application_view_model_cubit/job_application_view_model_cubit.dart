import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/job_application_view_model_cubit/job_application_view_model_state.dart';
import 'package:wazafny/Screens/Company/JobPosts/services/application_service.dart';

class CompanyJobApplicationCubit extends Cubit<JobApplicationState> {
  CompanyJobApplicationCubit() : super(JobApplicationInitial());

  Future<void> fetchJobApplication(int applicationId) async {
    final ApplicationService applicationService = ApplicationService();

    emit(JobApplicationLoading());
    try {
      final application = await applicationService.showJobApplication(
          applicationId: applicationId);
      emit(JobApplicationLoaded(application));
    } catch (e) {
      emit(JobApplicationError(e.toString()));
    }
  }

  void reset() {
    emit(JobApplicationInitial());
  }
}
