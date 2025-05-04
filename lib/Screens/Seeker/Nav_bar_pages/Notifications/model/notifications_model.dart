class NotificationModel {
  final int notificationId;
  final int jobId;
  final String companyName;
  final String message;
  final String jobTitle;
  final String profileImg;
  final String timeAgo;

  NotificationModel({
    required this.notificationId,
    required this.jobId,
    required this.companyName,
    required this.message,
    required this.jobTitle,
    required this.profileImg,
    required this.timeAgo,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    
    return NotificationModel(
      notificationId: json['notification_id'],
      jobId: json['job_id'],
      companyName: json['company_name'],
      message: json['message'],
      jobTitle: json['job_title'],
      profileImg: json['profile_img'],
      timeAgo: json['time_ago'],
    );
  }
}
