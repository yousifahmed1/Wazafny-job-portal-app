

import 'dart:convert';

List<LatestJobsModel> latestJobsModelFromJson(String str) => List<LatestJobsModel>.from(json.decode(str).map((x) => LatestJobsModel.fromJson(x)));

String latestJobsModelToJson(List<LatestJobsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestJobsModel {
    final int jobId;
    final String jobTitle;
    final String jobType;
    final String jobCountry;
    final String jobCity;
    final String timeAgo;

    LatestJobsModel({
        required this.jobId,
        required this.jobTitle,
        required this.jobType,
        required this.jobCountry,
        required this.jobCity,
        required this.timeAgo,
    });

    LatestJobsModel copyWith({
        int? jobId,
        String? jobTitle,
        String? jobType,
        String? jobCountry,
        String? jobCity,
        String? timeAgo,
    }) => 
        LatestJobsModel(
            jobId: jobId ?? this.jobId,
            jobTitle: jobTitle ?? this.jobTitle,
            jobType: jobType ?? this.jobType,
            jobCountry: jobCountry ?? this.jobCountry,
            jobCity: jobCity ?? this.jobCity,
            timeAgo: timeAgo ?? this.timeAgo,
        );

    factory LatestJobsModel.fromJson(Map<String, dynamic> json) => LatestJobsModel(
        jobId: json["job_id"],
        jobTitle: json["job_title"],
        jobType: json["job_type"],
        jobCountry: json["job_country"],
        jobCity: json["job_city"],
        timeAgo: json["time_ago"],
    );

    Map<String, dynamic> toJson() => {
        "job_id": jobId,
        "job_title": jobTitle,
        "job_type": jobType,
        "job_country": jobCountry,
        "job_city": jobCity,
        "time_ago": timeAgo,
    };
}
