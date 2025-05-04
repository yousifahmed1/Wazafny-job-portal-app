class JobApplyModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? country;
  String? city;
  String? emailAddress;
  dynamic resume;
  List<QuestionsAnswerModel>?
      questionsAnswers; // Refactored to List<Map<String, dynamic>>

  JobApplyModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.country,
    this.city,
    this.emailAddress,
    this.resume,
    this.questionsAnswers,
  });

  factory JobApplyModel.fromJson(Map<String, dynamic> json) {
    return JobApplyModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      emailAddress: json['email'],
      resume: json['resume'],
      questionsAnswers: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionsAnswerModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'country': country,
      'city': city,
      'emailAddress': emailAddress,
      'resume': resume,
      'questionsAnswers': questionsAnswers, // Now a list of maps
    };
  }

  // Convert to JSON for submission (optional)
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'country': country,
      'city': city,
      'emailAddress': emailAddress,
      'resume': resume,
      'questionsAnswers': questionsAnswers?.map((e) => e.toJson()).toList(),
    };
  }
}

class QuestionsAnswerModel {
  int? questionId;
  String? answer;
  String? question;

  QuestionsAnswerModel({
    this.questionId,
    this.answer,
    this.question,
  });
  factory QuestionsAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionsAnswerModel(
      questionId: json['question_id'],
      answer: json['answer'],
      question: json['question_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answer': answer,
      'question': question,
    };
  }
}
