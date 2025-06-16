import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/company_job_post_model.dart';
import 'package:wazafny/Screens/Company/JobPosts/services/company_job_post_services.dart';

part 'company_view_job_post_state.dart';

class CompanyViewJobPostCubit extends Cubit<CompanyViewJobPostState> {
  final CompanyJobPostServices _services = CompanyJobPostServices();

  CompanyViewJobPostCubit() : super(CompanyViewJobPostInitial());

  Future<void> fetchJobPostDetails({required int jobId}) async {
    emit(CompanyViewJobPostLoading());
    try {
      final jobPost = await _services.getJobPostDetails(jobId: jobId);
      emit(CompanyViewJobPostLoaded(jobPost));
    } catch (e) {
      emit(CompanyViewJobPostError(e.toString()));
    }
  }

  Future<void> deleteJobPost({required int jobId}) async {
    emit(CompanyViewJobPostLoading());
    try {
      await _services.deleteJobPost(jobId: jobId);
      emit(CompanyViewJobPostDeleted());
    } catch (e) {
      emit(CompanyViewJobPostError(e.toString()));
    }
  }

  void reset() {
    emit(CompanyViewJobPostInitial());
  }
}
