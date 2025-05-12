part of 'company_job_posts_cubit.dart';

abstract class CompanyJobPostsState extends Equatable {
  const CompanyJobPostsState();

  @override
  List<Object> get props => [];
}

class CompanyJobPostsInitial extends CompanyJobPostsState {}

class CompanyJobPostsLoading extends CompanyJobPostsState {}

class CompanyJobPostsLoaded extends CompanyJobPostsState {
  final List<CompanyJobPostsModel> posts;

  const CompanyJobPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class CompanyJobPostsError extends CompanyJobPostsState {
  final String message;

  const CompanyJobPostsError(this.message);

  @override
  List<Object> get props => [message];
}
