import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wazafny/Screens/Company/Profile/services/company_profile_services.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';

part 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  final CompanyProfileServices _services = CompanyProfileServices();

  CompanyProfileCubit() : super(CompanyProfileInitial());

  Future<void> fetchCompanyProfile() async {
    emit(CompanyProfileLoading());
    try {
      final company = await _services.getCompanyProfile();
      emit(CompanyProfileLoaded(company));
    } catch (e) {
      emit(CompanyProfileError(e.toString()));
    }
  }

  void reset() {
    emit(CompanyProfileInitial());
  }

  Future<String> uploadProfileImage({required File image}) async {
    try {
      final message = await _services.uploadCompanyProfileImage(image);
      await fetchCompanyProfile();
      return message;
    } catch (e) {
      emit(CompanyProfileError(e.toString()));
      return e.toString();
    }
  }

  Future<String> uploadCoverImage({required File image}) async {
    try {
      final message = await _services.uploadCompanyCoverImage(image);
      await fetchCompanyProfile();
      return message;
    } catch (e) {
      emit(CompanyProfileError(e.toString()));
      return e.toString();
    }
  }

  Future<String> deleteProfileImage() async {
    try {
      final message = await _services.deleteCompanyProfileImage();
      await fetchCompanyProfile();
      return message;
    } catch (e) {
      emit(CompanyProfileError(e.toString()));
      return e.toString();
    }
  }

  Future<String> deleteCoverImage() async {
    try {
      final message = await _services.deleteCompanyCoverImage();
      await fetchCompanyProfile();
      return message;
    } catch (e) {
      emit(CompanyProfileError(e.toString()));
      return e.toString();
    }
  }

  Future<void> updateCompanyInfo({
    required String name,
    required String email,
    required String headline,
    String? website,
  }) async {
    try {
      emit(CompanyProfileLoading());
      await _services.updateCompanyInfo(
        name: name,
        email: email,
        headline: headline,
        website: website,
      );
      await fetchCompanyProfile();
    } catch (e) {
      emit(CompanyProfileError(e.toString()));
    }
  }

  Future<void> updateCompanyExtraInfo({
    String? industry,
    String? size,
    String? headquarters,
    int? founded,
    String? country,
    String? city,
    String? about,
  }) async {
    try {
      emit(CompanyProfileLoading());
      await _services.updateCompanyExtraInfo(
        industry: industry,
        size: size,
        headquarters: headquarters,
        founded: founded,
        country: country,
        city: city,
        about: about,
      );
      await fetchCompanyProfile();
    } catch (e) {
      emit(CompanyProfileError(e.toString()));
    }
  }
}
