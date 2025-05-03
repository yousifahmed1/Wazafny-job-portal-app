import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/cubit/cubit/company_view_state.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/services/company_services.dart';


class CompanyViewCubit extends Cubit<CompanyState> {
  CompanyViewCubit() : super(CompanyInitial());

  Future<void> fetchCompany() async {
    emit(CompanyLoading());
    try {
      final company = await CompanyServices().fetchCompanies();
      emit(CompanyLoaded(company));
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }
}
