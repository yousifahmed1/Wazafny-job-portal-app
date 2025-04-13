import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wazafny/models/job_apply_model.dart';
import 'job_apply_state.dart';
import 'dart:io';

class JobApplyCubit extends Cubit<JobApplyState> {
  final Dio _dio = Dio();

  JobApplyCubit() : super(const JobApplyState(applyFormData: {}));

  // Update form data for a specific field
  void updateApplyFormData(
    String key,
    dynamic value,
  ) {
    final updatedApplyFormData = Map<String, dynamic>.from(state.applyFormData);

    updatedApplyFormData[key] = value;

    emit(state.copyWith(applyFormData: updatedApplyFormData));
  }

  // Get all form data to send to API
  Map<String, dynamic> getApplyFormData() {
    return state.applyFormData;
  }

  // Convert form data to JobApplyModel
  JobApplyModel _toJobApplyModel(
      Map<String, dynamic> formData, int jobId, int seekerId) {
    // Extract questions and answers from formData
    final questionsAnswers = <Map<String, dynamic>>[];
    // Filter keys that are question IDs (they should be numeric strings since questionID is an int)
    final questionKeys =
        formData.keys.where((key) => int.tryParse(key) != null).toList();

    for (var questionIdStr in questionKeys) {
      final questionId =
          int.parse(questionIdStr); // Convert back to int for JobApplyModel
      questionsAnswers.add({
        'questionId': questionId, // Use int for questionId
        'answer': formData[questionIdStr] ?? '',
      });
    }

    return JobApplyModel(
      firstName: formData['firstName'] ?? '',
      lastName: formData['lastName'] ?? '',
      phone: formData['phoneNumber'] ?? '',
      country: formData['country'] ?? '',
      city: formData['city'] ?? '',
      emailAddress: formData['email'] ?? '',
      seekerId: seekerId,
      jobId: jobId,
      resume: File(formData['resumePath'] ?? ''),
      questionsAnswers: questionsAnswers,
    );
  }

  // Method to send data to API
  Future<void> submitFormData(
      {required int jobId, required int seekerId}) async {
    try {
      final formData = getApplyFormData();
      final jobApplyModel = _toJobApplyModel(formData, jobId, seekerId);

      // Prepare multipart form data for API submission
      final formDataToSend = FormData.fromMap({
        'firstName': jobApplyModel.firstName,
        'lastName': jobApplyModel.lastName,
        'phone': jobApplyModel.phone,
        'country': jobApplyModel.country,
        'city': jobApplyModel.city,
        'emailAddress': jobApplyModel.emailAddress,
        'seekerId': jobApplyModel.seekerId,
        'jobId': jobApplyModel.jobId,
        'resume': await MultipartFile.fromFile(jobApplyModel.resume.path,
            filename: jobApplyModel.resume.path.split('/').last),
        'questionsAnswers': jobApplyModel
            .questionsAnswers, // List of maps with questionId as int
      });

      final response = await _dio.post(
        'https://wazafny.online/api/apply',
        data: formDataToSend,
      );

      if (response.statusCode == 200) {
        print("Form submitted successfully!");
      } else {
        throw Exception("Failed to submit form: ${response.statusCode}");
      }
    } catch (e) {
      print("Error submitting form: $e");
      throw Exception('Failed to submit form: $e');
    }
  }
}
