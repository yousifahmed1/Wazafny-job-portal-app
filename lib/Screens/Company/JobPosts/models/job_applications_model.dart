class CompanyJobApplicationModel {
  final String jobTitle;
  final List<Application> applications;

  CompanyJobApplicationModel({
    required this.jobTitle,
    required this.applications,
  });

  factory CompanyJobApplicationModel.fromJson(Map<String, dynamic> json) {
    return CompanyJobApplicationModel(
      jobTitle: json['job_title'],
      applications: List<Application>.from(
        json['applications'].map((x) => Application.fromJson(x)),
      ),
    );
  }
}

class Application {
  final int applicationId;
  final String status;
  final String timeAgo;
  final Seeker seeker;

  Application({
    required this.applicationId,
    required this.status,
    required this.timeAgo,
    required this.seeker,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      applicationId: json['application_id'],
      status: json['status'],
      timeAgo: json['time_ago'],
      seeker: Seeker.fromJson(json['seeker']),
    );
  }
}

class Seeker {
  final int seekerId;
  final String firstName;
  final String lastName;
  final String profileImg;

  Seeker({
    required this.seekerId,
    required this.firstName,
    required this.lastName,
    required this.profileImg,
  });

  factory Seeker.fromJson(Map<String, dynamic> json) {
    return Seeker(
      seekerId: json['seeker_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImg: json['profile_img'],
    );
  }
}




