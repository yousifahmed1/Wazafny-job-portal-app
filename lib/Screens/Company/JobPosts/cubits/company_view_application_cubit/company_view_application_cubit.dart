import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_state.dart';
import 'package:wazafny/Screens/Company/JobPosts/services/application_service.dart';

class CompanyApplicationCubit extends Cubit<ApplicationState> {
  CompanyApplicationCubit() : super(ApplicationInitial());
    final ApplicationService applicationService = ApplicationService();

  Future<void> fetchApplications({required int jobId}) async {

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

  Future<void> sendResponse({required int applicationId, String? responseMessage, required String status, required int jobId}) async {
    emit(ApplicationLoading());
    try {
      await applicationService.sendResponse(applicationId: applicationId, responseMessage: responseMessage, status: status);
      final result = await applicationService.getJobApplication(jobId: jobId);
      emit(ApplicationLoaded(result));
    } catch (e) {
      emit(ApplicationError(e.toString()));
    }
  }

  void reset() {
    emit(ApplicationInitial());
  }
}
