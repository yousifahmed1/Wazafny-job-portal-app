class JobApplicationModel {
  final int applicationId;
  final String companyImage;
  final String companyName;
  final String jobTitle;
  final String jobStatus;
  final String jobLocation; // Will combine job_country and job_city
  final String jobType; // job_type (Remote, On-site) + job_time (Full-time, Part-time)
  final String timeAgo;
  final String? response;

  JobApplicationModel({
    required this.applicationId,
    required this.companyImage,
    required this.companyName,
    required this.jobTitle,
    required this.jobStatus,
    required this.jobLocation,
    required this.jobType,
    required this.timeAgo,
    this.response,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    final job = json['job'];
    final company = job['company'];

    return JobApplicationModel(
      applicationId: json['application_id'],
      companyImage: company['profile_img'],
      companyName: company['company_name'],
      jobTitle: job['job_title'],
      jobStatus: json['status'],
      jobLocation: '${job['job_city']}, ${job['job_country']}',
      jobType: '${job['job_type']} • ${job['job_time']}', // Remote • Full-time
      timeAgo: json['time_ago'],
      response: json['response'],
    );
  }
}
