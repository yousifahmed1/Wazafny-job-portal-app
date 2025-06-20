import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/create_job_post_model.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';

class QuestionsPage extends StatefulWidget {
  final CreateJobPostModel jobPostData;
  final Function(List<JobQuestion>) onQuestionsChanged;

  const QuestionsPage({
    super.key,
    required this.jobPostData,
    required this.onQuestionsChanged,
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final List<TextEditingController> _questionControllers = [];
  final List<int?> _questionIds = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers and ids from existing data
    for (var question in widget.jobPostData.questions) {
      _questionControllers.add(TextEditingController(text: question.question));
      _questionIds.add(question.questionId);
    }
  }

  @override
  void dispose() {
    for (var controller in _questionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateParentData() {
    final questions = List.generate(
        _questionControllers.length,
        (i) => JobQuestion(
            questionId: _questionIds[i],
            question: _questionControllers[i].text));
    widget.onQuestionsChanged(questions);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._questionControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return Column(
                children: [
                  RoundedTextField(
                    controller: controller,
                    labelText: 'Question',
                    keyboardType: TextInputType.text,
                    onChanged: (_) => _updateParentData(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SubHeadingText1(
                        title: "Question ${index + 1}",
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _questionControllers.removeAt(index);
                            _questionIds.removeAt(index);
                            _updateParentData();
                          });
                        },
                        child: SvgPicture.asset(
                          "assets/Icons/delete_icon.svg",
                          width: 20,
                          height: 20,
                          // ignore: deprecated_member_use
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _questionControllers.add(TextEditingController());
                  _questionIds.add(null);
                  _updateParentData();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/Icons/Add_icon.svg",
                    width: 20,
                    height: 20,
                    // ignore: deprecated_member_use
                    color: primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const HeadingText(
                    titleColor: primaryColor,
                    title: "Add new Question",
                    fontSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
