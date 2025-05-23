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
  final dynamic resume;
  final List<Experience> experience;
  final Education? education;
  final List<SkillsModel> skills;
  final List<LinkModel> links;
  final List<FollowingsModel>? followings;

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
    this.followings,
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
      experience: (json['experiences'] as List? ?? [])
          .map((e) => Experience.fromJson(e))
          .toList(),
      education: json['education'] != null
          ? Education.fromJson(json['education'])
          : null,
      skills: (json['skills'] as List? ?? [])
          .map((e) => SkillsModel.fromJson(e))
          .toList(),
      links: (json["personal_info"]['links'] as List? ?? [])
          .map((e) => LinkModel.fromJson(e))
          .toList(),
      followings: (json['followings'] as List? ?? [])
          .map((e) => FollowingsModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'headline': headline,
        'country': country,
        'city': city,
        'about': about,
        'links': links
            .map((e) =>
                {'link_name': e.name, 'link': e.link, 'link_id': e.linkID})
            .toList(),
      };
}

class Experience {
  final String? jobTitle;
  final String? company;
  final String? employmentType;
  final String? startDate;
  final String? endDate;
  final int? experienceID;

  Experience({
    this.experienceID,
    this.jobTitle,
    this.company,
    this.employmentType,
    this.startDate,
    this.endDate,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      experienceID: json['experience_id'],
      jobTitle: json['job_title'],
      company: json['company'],
      employmentType: json['job_time'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

class Education {
  final String? university;
  final String? college;
  final String? startDate;
  final String? endDate;

  Education({this.college, this.startDate, this.endDate, this.university});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      university: json['university'],
      college: json['college'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

class LinkModel {
  final String? name;
  final int? linkID;
  final String? link;

  LinkModel({
    this.name,
    this.link,
    this.linkID,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      linkID: json['link_id'],
      name: json['link_name'],
      link: json['link'],
    );
  }
}

class SkillsModel {
  final String? skill;
  final int? skillID;

  SkillsModel({
    this.skill,
    this.skillID,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      skillID: json['skill_id'],
      skill: json['skill'],
    );
  }
}

class FollowingsModel {
  final String? companName;
  final String? profileImg;
  final int? companyId;

  FollowingsModel({
    this.companName,
    this.profileImg,
    this.companyId,
  });

  factory FollowingsModel.fromJson(Map<String, dynamic> json) {
    return FollowingsModel(
      companyId: json['company_id'],
      companName: json['company_name'],
      profileImg: json['profile_img'],
    );
  }
}
