import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_state.dart';
import 'package:wazafny/Screens/Company/JobPosts/services/application_service.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationInitial());

  Future<void> fetchApplications({required int jobId}) async {
    final ApplicationService applicationService = ApplicationService();

    emit(ApplicationLoading());
    try {
      final result = await applicationService.getJobApplication(jobId: jobId);
      if (result.applications.isEmpty) {
        emit(ApplicationEmpty());
        log("Is empty");
      } else {
        emit(ApplicationLoaded(result));
      }
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }
}
