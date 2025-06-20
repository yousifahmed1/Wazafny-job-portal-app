import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';

class JobQuestion {
  int? questionId;
  String question;

  JobQuestion({this.questionId, required this.question});

  factory JobQuestion.fromJson(Map<String, dynamic> json) {
    return JobQuestion(
      questionId: json['question_id'],
      question: json['question'],
    );
  }

  Map<String, dynamic> toJson() {
    if (questionId != null) {
      return {
        'question_id': questionId,
        'question': question,
      };
    } else {
      return {
        'question': question,
      };
    }
  }
}

class CreateJobPostModel {
  // Basic Info
  String? jobTitle;
  String? about;
  String? country;
  String? city;
  String? jobType;
  String? employmentType;
  int? companyID;

  // Skills
  List<String> skills = [];

  // Extra Sections
  List<Map<String, String>> extraSections = [];

  // Questions (now as List<Map<String, dynamic>>)
  List<JobQuestion> questions = [];

  CreateJobPostModel() {
    _initializeCompanyID();
  }

  Future<void> _initializeCompanyID() async {
    companyID = await AuthRepository().getRoleId() ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'job_title': jobTitle,
      'job_about': about,
      'job_time': employmentType,
      'job_type': jobType,
      'job_country': country,
      'job_city': city,
      'company_id': companyID,
      'skills': skills,
      'questions': questions.map((q) => q.toJson()).toList(),
      'sections': extraSections,
    };
  }
}
