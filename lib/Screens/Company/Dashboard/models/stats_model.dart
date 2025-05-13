import 'dart:convert';

StatsModel statsModelFromJson(String str) => StatsModel.fromJson(json.decode(str));

String statsModelToJson(StatsModel data) => json.encode(data.toJson());

class StatsModel {
    final int jobsCount;
    final int activeJobsCount;
    final int followersCount;
    final int applicationsCount;

    StatsModel({
        required this.jobsCount,
        required this.activeJobsCount,
        required this.followersCount,
        required this.applicationsCount,
    });

    StatsModel copyWith({
        int? jobsCount,
        int? activeJobsCount,
        int? followersCount,
        int? applicationsCount,
    }) => 
        StatsModel(
            jobsCount: jobsCount ?? this.jobsCount,
            activeJobsCount: activeJobsCount ?? this.activeJobsCount,
            followersCount: followersCount ?? this.followersCount,
            applicationsCount: applicationsCount ?? this.applicationsCount,
        );

    factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
        jobsCount: json["jobs_count"],
        activeJobsCount: json["active_jobs_count"],
        followersCount: json["followers_count"],
        applicationsCount: json["applications_count"],
    );

    Map<String, dynamic> toJson() => {
        "jobs_count": jobsCount,
        "active_jobs_count": activeJobsCount,
        "followers_count": followersCount,
        "applications_count": applicationsCount,
    };
}
