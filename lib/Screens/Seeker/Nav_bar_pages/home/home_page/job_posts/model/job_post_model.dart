// lib/models/job_model.dart

class JobModel {
  final int jobId;
  final String title;
  final String jobAbout;
  final String jobType;
  final String jobCountry;
  final String jobCity;
  final String timeAgo;
  final double score;
  final Company company;
  final List<String> skills;

  JobModel({
    required this.jobId,
    required this.title,
    required this.jobAbout,
    required this.jobType,
    required this.jobCountry,
    required this.jobCity,
    required this.timeAgo,
    required this.score,
    required this.company,
    required this.skills,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      jobId: json['job_id'] ?? 0,
      title: json['title'] ?? '',
      jobAbout: json['job_about'] ?? '',
      jobType: json['job_type'] ?? '',
      jobCountry: json['job_country'] ?? '',
      jobCity: json['job_city'] ?? '',
      timeAgo: json['time_ago'] ?? '',
      score: (json['score'] ?? 0.0).toDouble(),
      company: Company.fromJson(json['company'] ?? {}),
      skills: json['skills'] != null
          ? List<String>.from(json['skills'])
          : [],
    );
  }
}

class Company {
  final int companyId;
  final String companyName;
  final String profileImg;

  Company({
    required this.companyId,
    required this.companyName,
    required this.profileImg,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['company_id'] ?? 0,
      companyName: json['company_name'] ?? '',
      profileImg: json['profile_img'] ?? '',
    );
  }
}

class JobResponse {
  final List<JobModel> jobs;

  JobResponse({required this.jobs});

  factory JobResponse.fromJson(Map<String, dynamic> json) {
    return JobResponse(
      jobs: json['jobs'] != null
          ? List<JobModel>.from(json['jobs'].map((x) => JobModel.fromJson(x)))
          : [],
    );
  }
}