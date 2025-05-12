class JobApplicationViewModel {
  final int seekerId;
  final int applicationId;
  final String status;
  final String profileImg;
  final String jobTitle;
  final String firstName;
  final String lastName;
  final String country;
  final String city;
  final String email;
  final String phone;
  final String resume;
  final List<ApplicationQuestion> questions;

  JobApplicationViewModel({
    required this.seekerId,
    required this.applicationId,
    required this.status,
    required this.profileImg,
    required this.jobTitle,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.city,
    required this.email,
    required this.phone,
    required this.resume,
    required this.questions,
  });

  factory JobApplicationViewModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationViewModel(
      seekerId: json['seeker_id'],
      applicationId: json['application_id'],
      status: json['status'],
      profileImg: json['profile_img'],
      jobTitle: json['job_title'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      country: json['country'],
      city: json['city'],
      email: json['email'],
      phone: json['phone'],
      resume: json['resume'],
      questions: (json['questions'] as List)
          .map((q) => ApplicationQuestion.fromJson(q))
          .toList(),
    );
  }
}

class ApplicationQuestion {
  final int questionId;
  final String questionText;
  final String? answer;

  ApplicationQuestion({
    required this.questionId,
    required this.questionText,
    this.answer,
  });

  factory ApplicationQuestion.fromJson(Map<String, dynamic> json) {
    return ApplicationQuestion(
      questionId: json['question_id'],
      questionText: json['question_text'],
      answer: json['answer'],
    );
  }
}
