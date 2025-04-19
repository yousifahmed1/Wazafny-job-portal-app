import 'package:flutter/foundation.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/model/profile_model.dart';

class SeekerProfileProvider with ChangeNotifier {
  SeekerProfileModel? _profile;

  SeekerProfileModel? get profile => _profile;

  void setProfile(SeekerProfileModel profile) {
    _profile = profile;
    notifyListeners();
  }

  void updateAbout(String newAbout) {
    if (_profile != null) {
      _profile = SeekerProfileModel(
        firstName: _profile!.firstName,
        lastName: _profile!.lastName,
        image: _profile!.image,
        cover: _profile!.cover,
        following: _profile!.following,
        headline: _profile!.headline,
        country: _profile!.country,
        city: _profile!.city,
        links: _profile!.links,
        about: newAbout,
        resume: _profile!.resume,
        experience: _profile!.experience,
        education: _profile!.education,
        skills: _profile!.skills,
      );
      notifyListeners();
    }
  }
}