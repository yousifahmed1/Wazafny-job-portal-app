import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_post_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/widgets/answer_text_field.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ApplyPageThree extends StatefulWidget {
  final JobPostModel jobPostModel; // Accept questions as parameter

  const ApplyPageThree({
    super.key,
    required this.jobPostModel,
    required this.jobApplyModel,
  });
  final JobApplyModel jobApplyModel;

  @override
  State<ApplyPageThree> createState() => _ApplyPageThreeState();
}

class _ApplyPageThreeState extends State<ApplyPageThree> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each question
    for (var questionModel in widget.jobPostModel.questions) {
      final questionID = questionModel.questionId;
      if (!_controllers.containsKey(questionID)) {
        _controllers[questionID] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    // Dispose of all controllers
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  String? _requiredFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final questions = widget.jobPostModel.questions;
    log(questions.toList().toString());

    return Column(
      children: [
        const SizedBox(height: 15),
        const Center(child: HeadingText(title: "Additional Questions")),
        const SizedBox(height: 15),
        if (questions.isEmpty)
          const Center(child: HeadingText(title: "No Questions Avilable"))
        else
          ...List.generate(questions.length, (index) {
            final questionModel = questions[index];
            final question = questionModel.question;
            final questionID = questionModel.questionId;
            return Column(
              children: [
                SubHeadingText(
                  title: "$question*",
                  titleColor: darkPrimary,
                ),
                const SizedBox(height: 5),
                AnswerTextField(
                  controller: _controllers[questionID],
                  keyboardType: TextInputType.text,
                  // labelText: "$question*",
                  validator: _requiredFieldValidator,
                  onChanged: (value) {
                    // Initialize list if null
                    widget.jobApplyModel.questionsAnswers ??= [];

                    // Check if question already answered
                    final existingIndex = widget.jobApplyModel.questionsAnswers!
                        .indexWhere(
                            (element) => element.questionId == questionID);

                    if (existingIndex != -1) {
                      // Update existing answer
                      widget.jobApplyModel.questionsAnswers![existingIndex]
                          .answer = value ;
                    } else {
                      // Add new answer
                      widget.jobApplyModel.questionsAnswers!.add(
                        QuestionsAnswerModel(
                          questionId: questionID,
                          answer: value ,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 25),
              ],
            );
          }),
      ],
    );
  }
}
