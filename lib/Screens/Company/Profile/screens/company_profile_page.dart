import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Company/Profile/widgets/extra_informations_section.dart';
import 'package:wazafny/Screens/Company/Profile/widgets/main_infrormations_section.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/model/company_model.dart';


class CompanyProfile extends StatefulWidget {
  const CompanyProfile({
    super.key,
  });
  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  late bool isFollwed;
  @override
  void initState() {
    super.initState();
    // future = _loadComapnyProfileData();
  }

  final company = CompanyModel(
    companyId: 1,
    companyName: "Tech Innovators Ltd",
    companyEmail: "info@techinnovators.com",
    companyWebsiteLink: "https://www.techinnovators.com",
    companyIndustry: "Information Technology",
    companySize: "200-500 employees",
    companyHeads: "John Doe, Jane Smith",
    companyCountry: "USA",
    companyCity: "San Francisco",
    companyFounded: "2010",
    about: "We innovate the future of technology.",
    headline: "Leading the way in tech innovation.",
    profileImg: "",
    coverImg: "",
    jobsCount: 5,
    followersCount: 1200,
    followStatus: true,
    jobPosts: [
      JobPost(
        jobId: 101,
        jobTitle: "Flutter Mobile Developer",
        jobStatus: "Open",
        jobType: "Full-time",
        jobCountry: "USA",
        jobCity: "San Francisco",
        timeAgo: "2 days ago",
      ),
      JobPost(
        jobId: 102,
        jobTitle: "Backend Engineer (Laravel)",
        jobStatus: "Open",
        jobType: "Full-time",
        jobCountry: "USA",
        jobCity: "San Francisco",
        timeAgo: "1 week ago",
      ),
    ],
  );

  var future;
  // Future<CompanyModel> _loadComapnyProfileData() async {
  //   final data =
  //       await CompanyServices().showComapnyProfile(companyId: widget.companyID);
  //   isFollwed = data.followStatus ?? false;
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainInformaition(company: company),
            ExrtraInformation(company: company)
          ],
        ),
      ),
    );
  }
}
