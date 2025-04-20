import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/profile_repo.dart';
import '../model/profile_model.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getProfileData();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String headline,
    required String country,
    required String city,
    String? resume,
    List<LinkModel>? links,
  }) async {
    emit(ProfileLoading());
    try {
      final message = await repository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        headline: headline,
        country: country,
        city: city,
        links: links,
      );

      // Refetch the updated profile after success
      final updatedProfile = await repository.getProfileData();
      emit(ProfileLoaded(updatedProfile));

      return message; // return the success message from API
    } catch (e) {
      emit(ProfileError('Failed to update profile: $e'));
      rethrow;
    }
  }

  Future<String> updateAbout({
    required String about,
ume,
    List<LinkModel>? links,
  }) async {
    emit(ProfileLoading());
    try {
      final message = await repository.updateAbout(
        about: about,

      );

      // Refetch the updated profile after success
      final updatedProfile = await repository.getProfileData();
      emit(ProfileLoaded(updatedProfile));

      return message; // return the success message from API
    } catch (e) {
      emit(ProfileError('Failed to update profile: $e'));
      rethrow;
    }
  }


  Future<String> deleteLink({required int linkId}) async {
    emit(ProfileLoading());
    try {
      final message = await repository.deleteLink(linkId: linkId);

      // Optionally refetch the profile after deletion
      final updatedProfile = await repository.getProfileData();
      emit(ProfileLoaded(updatedProfile));

      return message; // return the success message
    } catch (e) {
      emit(ProfileError('Failed to delete link: $e'));
      rethrow;
    }
  }
}
