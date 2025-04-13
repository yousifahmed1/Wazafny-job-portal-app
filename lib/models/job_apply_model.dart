import 'dart:io';
import 'package:equatable/equatable.dart';

class JobApplyModel extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String country;
  final String city;
  final String emailAddress;
  final int seekerId;
  final int jobId;
  final File resume;
  final List<Map<String, dynamic>> questionsAnswers; // Refactored to List<Map<String, dynamic>>

  const JobApplyModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.country,
    required this.city,
    required this.emailAddress,
    required this.seekerId,
    required this.jobId,
    required this.resume,
    required this.questionsAnswers,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'country': country,
      'city': city,
      'emailAddress': emailAddress,
      'seekerId': seekerId,
      'jobId': jobId,
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
      'seekerId': seekerId,
      'jobId': jobId,
      'resume': resume,
      'questionsAnswers': questionsAnswers, // Now a list of maps
    };
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phone,
        country,
        city,
        emailAddress,
        seekerId,
        jobId,
        resume,
        questionsAnswers,
      ];
}