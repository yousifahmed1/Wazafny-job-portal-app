class SeekerProfileModel {
  final String firstName;
  final String lastName;
  final String? image;
  final String? cover;
  final int following;
  final String headline;
  final String country;
  final String city;
  final List<Map<String, dynamic>>? links;
  final String? about;
  final String? resume;
  final List<Map<String, dynamic>>? experience;
  final Map<String, dynamic>? education;
  final List<String>? skills;

  SeekerProfileModel({
    required this.firstName,
    required this.lastName,
    this.image, // Non-required
    this.cover, // Non-required
    required this.following,
    required this.headline,
    required this.country,
    required this.city,
    required this.links, // Non-required
    required this.about, // Non-required
    required this.resume, // Non-required
    required this.experience, // Non-required
    required this.education, // Non-required
    required this.skills, // Non-required
  });

  factory SeekerProfileModel.fromJson(json) {
    return SeekerProfileModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      cover: json['cover'], // Can be null
      following: json['following'],
      headline: json['title'],
      country: json['country'],
      city: json['city'],
      links: json['links']?.cast<Map<String, dynamic>>(),
      about: json['about'],
      resume: json['resume'],
      experience: json['experience']?.cast<Map<String, dynamic>>(),
      education: json['education'],
      skills: json['skills']?.cast<String>(),
    );
  }
}
