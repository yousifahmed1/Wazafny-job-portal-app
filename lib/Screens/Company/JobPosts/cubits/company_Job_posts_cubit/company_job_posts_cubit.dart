import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/company_job_posts_model.dart';
import 'package:wazafny/Screens/Company/JobPosts/services/company_job_post_services.dart';
part 'company_job_posts_state.dart';

class CompanyJobPostsCubit extends Cubit<CompanyJobPostsState> {
  final CompanyJobPostServices _services = CompanyJobPostServices();

  CompanyJobPostsCubit() : super(CompanyJobPostsInitial());

  Future<void> fetchCompanyJobPosts() async {
    emit(CompanyJobPostsLoading());
    try {
      final posts = await _services.getCompanyJobPosts();
      emit(CompanyJobPostsLoaded(posts));
    } catch (e) {
      emit(CompanyJobPostsError(e.toString()));
    }
  }
}
