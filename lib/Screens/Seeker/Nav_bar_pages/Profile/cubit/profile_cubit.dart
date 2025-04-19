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
    String? about,
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
}
