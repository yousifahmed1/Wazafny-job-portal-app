import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';

abstract class CompanyState {}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyLoaded extends CompanyState {
  final List<CompanyModel> companies;

  CompanyLoaded(this.companies);
}

class CompanyError extends CompanyState {
  final String error;

  CompanyError(this.error);
}
