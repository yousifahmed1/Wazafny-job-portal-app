class AppliedJobApplicationModel {
  final String companyImage;
  final String companyName;
  final String jobTitle;
  final String jobStatus;
  final String jobLocation;
  final String jobType;
  final String timeAgo;
  final String? response;

  AppliedJobApplicationModel({
    required this.companyImage,
    required this.companyName,
    required this.jobTitle,
    required this.jobStatus,
    required this.jobLocation,
    required this.jobType,
    required this.timeAgo,
    this.response,
  });
}
