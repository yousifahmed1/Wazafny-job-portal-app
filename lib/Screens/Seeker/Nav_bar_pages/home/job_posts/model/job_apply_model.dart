import 'dart:io';

class JobApplyModel {
   String? firstName;
   String? lastName;
   String? phone;
   String? country;
   String? city;
   String? emailAddress;
   File? resume;
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
      'questionsAnswers': questionsAnswers, // Now a list of maps
    };
  }

}


class QuestionsAnswerModel {
   int? questionId;
   String? answer;
  QuestionsAnswerModel({
     this.questionId,
     this.answer,
  });
}
