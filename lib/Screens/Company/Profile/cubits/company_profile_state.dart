part of 'company_profile_cubit.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState();

  @override
  List<Object> get props => [];
}

class CompanyProfileInitial extends CompanyProfileState {}

class CompanyProfileLoading extends CompanyProfileState {}

class CompanyProfileLoaded extends CompanyProfileState {
  final CompanyModel company;

  const CompanyProfileLoaded(this.company);

  @override
  List<Object> get props => [company];
}

class CompanyProfileError extends CompanyProfileState {
  final String message;

  const CompanyProfileError(this.message);

  @override
  List<Object> get props => [message];
}
