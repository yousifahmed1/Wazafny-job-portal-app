part of 'company_view_job_post_cubit.dart';

abstract class CompanyViewJobPostState {}

class CompanyViewJobPostInitial extends CompanyViewJobPostState {}

class CompanyViewJobPostLoading extends CompanyViewJobPostState {}

class CompanyViewJobPostLoaded extends CompanyViewJobPostState {
  final CompanyJobPostModel jobPost;
  CompanyViewJobPostLoaded(this.jobPost);
}

class CompanyViewJobPostError extends CompanyViewJobPostState {
  final String message;
  CompanyViewJobPostError(this.message);
}

class CompanyViewJobPostDeleted extends CompanyViewJobPostState {}
