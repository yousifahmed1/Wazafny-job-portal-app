import 'package:wazafny/Screens/Company/home/models/latests_jobs.dart';
import 'package:wazafny/Screens/Company/home/models/stats_model.dart';

class DashboardModel {
  final String companyName;
  final StatsModel stats;
  final List<LatestJobsModel> latestJobs;

  DashboardModel({
    required this.stats,
    required this.latestJobs,
    required this.companyName,
  });

  DashboardModel copyWith({
    final String? companyName,
    StatsModel? stats,
    List<LatestJobsModel>? latestJobs,
  }) =>
      DashboardModel(
        stats: stats ?? this.stats,
        latestJobs: latestJobs ?? this.latestJobs,
        companyName: companyName ?? this.companyName,
      );
}
