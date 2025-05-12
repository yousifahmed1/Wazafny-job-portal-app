class CompanyJobPostsModel {
  final int jobId;
  final String jobTitle;
  final String jobStatus;
  final String createdAt;

  CompanyJobPostsModel({
    required this.jobId,
    required this.jobTitle,
    required this.jobStatus,
    required this.createdAt,
  });

  // From JSON
  factory CompanyJobPostsModel.fromJson(Map<String, dynamic> json) {
    return CompanyJobPostsModel(
      jobId: json['job_id'],
      jobTitle: json['job_title'],
      jobStatus: json['job_status'],
      createdAt: json['created_at'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'job_title': jobTitle,
      'job_status': jobStatus,
      'created_at': createdAt,
    };
  }
}
