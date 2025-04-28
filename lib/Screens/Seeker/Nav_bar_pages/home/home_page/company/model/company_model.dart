class CompanyModel {
  final int companyId;
  final String companyName;
  final String? companyEmail;
  final String? companyWebsiteLink;
  final String? companyIndustry;
  final String? companySize;
  final String? companyHeads;
  final String? companyCountry;
  final String? companyCity;
  final String? companyFounded;
  final String? about;
  final String? headline;
  final String? profileImg;
  final String? coverImg;
  final int? jobsCount;
  final int? followersCount;
  final dynamic followStatus;
  final dynamic jobPosts;

  CompanyModel({
    required this.companyId,
    required this.companyName,
    this.companyEmail,
    this.companyWebsiteLink,
    this.companyIndustry,
    this.companySize,
    this.companyHeads,
    this.companyCountry,
    this.companyCity,
    this.companyFounded,
    this.about,
    this.headline,
    this.profileImg,
    this.coverImg,
    this.jobsCount,
    this.followersCount,
    this.followStatus,
    this.jobPosts,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyId: json['company_id'],
      companyName: json['company_name'],
      companyEmail: json['company_email'],
      companyWebsiteLink: json['company_website_link'],
      companyIndustry: json['company_industry'],
      companySize: json['company_size'],
      companyHeads: json['company_heads'],
      companyCountry: json['company_country'],
      companyCity: json['company_city'],
      companyFounded: json['company_founded'],
      about: json['about'],
      headline: json['headline'],
      profileImg: json['profile_img'],
      coverImg: json['cover_img'],
      jobsCount: json['jobs_count'],
      followersCount: json['followers_count'],
      followStatus: json['followstatus'],
      jobPosts: json['jobposts'],
    );
  }

  // Optional: toJson
  // Map<String, dynamic> toJson() {
  //   return {
  //     'company_id': companyId,
  //     'company_name': companyName,
  //     'company_email': companyEmail,
  //     'company_website_link': companyWebsiteLink,
  //     'company_industry': companyIndustry,
  //     'company_size': companySize,
  //     'company_heads': companyHeads,
  //     'company_country': companyCountry,
  //     'company_city': companyCity,
  //     'company_founded': companyFounded,
  //     'about': about,
  //     'headline': headline,
  //     'profile_img': profileImg,
  //     'cover_img': coverImg,
  //     'jobs_count': jobsCount,
  //     'followers_count': followersCount,
  //     'followstatus': followStatus,
  //     'jobposts': jobPosts,
  //   };
  // }
}
