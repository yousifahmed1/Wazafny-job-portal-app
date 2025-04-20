class SeekerProfileModel {
  final String image;
  final String cover;
  final String firstName;
  final String lastName;
  final int following;
  final String headline;
  final String country;
  final String city;
  final String? about;
  final String resume;
  final List<Experience> experience;
  final Education? education;
  final List<String> skills;
  final List<LinkModel> links;

  SeekerProfileModel({
    required this.image,
    required this.cover,
    required this.firstName,
    required this.lastName,
    required this.following,
    required this.headline,
    required this.country,
    required this.city,
    this.about,
    required this.resume,
    required this.experience,
    this.education,
    required this.skills,
    required this.links,
  });

  factory SeekerProfileModel.fromJson(Map<String, dynamic> json) {
    return SeekerProfileModel(
      image: json["personal_info"]['profile_img'] ?? "",
      cover: json["personal_info"]['cover_img'] ?? "",
      firstName: json["personal_info"]['first_name'] ?? "",
      lastName: json["personal_info"]['last_name'] ?? "",
      following: json["personal_info"]['followings'] ?? 0,
      headline: json["personal_info"]['headline'] ?? "",
      country: json["personal_info"]['country'] ?? "",
      city: json["personal_info"]['city'] ?? "",
      about: json["personal_info"]['about'],
      resume: json["personal_info"]['resume'] ?? "",
      experience: (json['experiences'] as List? ?? []).map((e) => Experience.fromJson(e)).toList(),
      education: json['education'] != null ? Education.fromJson(json['education']) : null,
      skills: (json['skills'] as List? ?? []).map((e) => e.toString()).toList(),
      links: (json["personal_info"]['links'] as List? ?? []).map((e) => LinkModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'headline': headline,
    'country': country,
    'city': city,
    'about': about,
    'links': links.map((e) => {'link_name': e.name, 'link': e.link , 'link_id': e.linkID}).toList(),
  };
}

class Experience {
  final String? role;
  final String? company;
  final String? type;
  final String? duration;

  Experience({this.role, this.company, this.type, this.duration});

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      role: json['role'],
      company: json['company'],
      type: json['type'],
      duration: json['duration'],
    );
  }
}

class Education {
  final String? university;
  final String? duration;
  final String? major;

  Education({this.university, this.duration, this.major});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      university: json['university'],
      duration: json['duration'],
      major: json['major'],
    );
  }
}

class LinkModel {
  final String? name;
  final int? linkID;
  final String? link;

  LinkModel( {this.name, this.link,this.linkID,});

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      linkID: json['link_id'],
      name: json['link_name'],
      link: json['link'],
    );
  }
}