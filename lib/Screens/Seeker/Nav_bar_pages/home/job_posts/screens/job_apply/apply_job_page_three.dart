import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_post_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/widgets/answer_text_field.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ApplyPageThree extends StatefulWidget {
  final JobPostModel? jobPostModel;
  final JobApplyModel jobApplyModel;
  final bool isEditMode;

  const ApplyPageThree({
    super.key,
    this.jobPostModel,
    required this.jobApplyModel,
    this.isEditMode = false,
  });

  @override
  State<ApplyPageThree> createState() => _ApplyPageThreeState();
}

class _ApplyPageThreeState extends State<ApplyPageThree> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers based on questions
    final questions = _getQuestions();
    for (var questionModel in questions) {
      final questionID = questionModel.questionId;
      if (!_controllers.containsKey(questionID)) {
        // Pre-fill with existing answer if in edit mode
        final existingAnswer = widget.jobApplyModel.questionsAnswers
            ?.firstWhere(
              (answer) => answer.questionId == questionID,
              orElse: () => QuestionsAnswerModel(),
            )
            .answer;
        _controllers[questionID] = TextEditingController(text: existingAnswer);
      }
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  String? _requiredFieldValidator(String? value, String question) {
    if (value == null || value.trim().isEmpty) {
      return 'Please answer: $question';
    }
    return null;
  }

  List<dynamic> _getQuestions() {
    if (widget.isEditMode && widget.jobApplyModel.questionsAnswers != null) {
      // Return QuestionsAnswerModel objects instead of just question strings
      return widget.jobApplyModel.questionsAnswers!;
    } else if (widget.jobPostModel != null) {
      return widget.jobPostModel!.questions;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final questions = _getQuestions();

    return Column(
      children: [
        const SizedBox(height: 15),
        const Center(child: HeadingText(title: "Additional Questions")),
        const SizedBox(height: 15),
        if (questions.isEmpty)
          const Center(child: HeadingText(title: "No Questions Available"))
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
                  validator: (value) => _requiredFieldValidator(value, question),
                  onChanged: (value) {
                    widget.jobApplyModel.questionsAnswers ??= [];
                    final existingIndex = widget.jobApplyModel.questionsAnswers!
                        .indexWhere((element) => element.questionId == questionID);

                    if (existingIndex != -1) {
                      widget.jobApplyModel.questionsAnswers![existingIndex]
                          .answer = value;
                    } else {
                      widget.jobApplyModel.questionsAnswers!.add(
                        QuestionsAnswerModel(
                          questionId: questionID,
                          answer: value,
                          question: question,
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