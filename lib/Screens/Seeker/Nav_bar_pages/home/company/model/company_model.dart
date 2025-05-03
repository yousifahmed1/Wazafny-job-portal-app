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
  final bool? followStatus;
  final List<JobPost>? jobPosts;

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
      jobPosts: json['jobposts'] != null
          ? List<JobPost>.from(
              json['jobposts'].map((post) => JobPost.fromJson(post)))
          : null,
    );
  }
}

class JobPost {
  final int jobId;
  final String jobTitle;
  final String jobStatus;
  final String jobType;
  final String jobCountry;
  final String jobCity;
  final String timeAgo;

  JobPost({
    required this.jobId,
    required this.jobTitle,
    required this.jobStatus,
    required this.jobType,
    required this.jobCountry,
    required this.jobCity,
    required this.timeAgo,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      jobId: json['job_id'],
      jobTitle: json['job_title'],
      jobStatus: json['job_status'],
      jobType: json['job_type'],
      jobCountry: json['job_country'],
      jobCity: json['job_city'],
      timeAgo: json['time_ago'],
    );
  }
}
