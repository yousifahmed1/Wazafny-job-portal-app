class JobPostModel {
  final String? image;
  final String? companyName;
  final String? country;
  final String? city;
  final String? jobType;
  final String? date;
  final String? employmentType;
  final String? jobTitle;
  final List<String>? skills;
  final int? jobID;
  final Map<String, String>? sections;

  JobPostModel({
    this.image,
    this.companyName,
    this.country,
    this.city,
    this.jobType,
    this.date,
    this.employmentType,
    this.jobTitle,
    this.skills,
    this.jobID,
    this.sections,
  });

  // Factory method to create a JobPostModel from JSON
  factory JobPostModel.fromJson(Map<String, dynamic> json) {
    var jobPost = json['jobpost'];
    var company = json['company'];
    var skillsList = json['skills'] as List? ?? [];
    var sectionsList = json['sections'] as List? ?? [];

    List<String> skills = skillsList.map((skill) => skill['skill'] as String).toList();

    Map<String, String> sections = {
      for (var section in sectionsList)
        section['section_name'] as String: section['section_description'] as String
    };

    return JobPostModel(
      image: json['profile_img'] as String?,
      companyName: company['company_name'] as String?,
      country: jobPost['job_country'] as String?,
      city: jobPost['job_city'] as String?,
      jobType: jobPost['job_type'] as String?,
      date: jobPost['created_at'] as String?,
      employmentType: jobPost['job_time'] as String?,
      jobTitle: jobPost['job_title'] as String?,
      skills: skills.isNotEmpty ? skills : null,
      jobID: jobPost['job_id'] as int?,
      sections: sections.isNotEmpty ? sections : null,
    );
  }
}
