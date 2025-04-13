import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/cubits/job_apply_cubit/job_apply_cubit.dart';
import 'package:wazafny/models/questions_model.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

class ApplyPageThree extends StatefulWidget {
  final int jobID;
  final List<QuestionsModel> questions; // Accept questions as parameter

  const ApplyPageThree(
      {super.key, required this.jobID, required this.questions});

  @override
  State<ApplyPageThree> createState() => _ApplyPageThreeState();
}

class _ApplyPageThreeState extends State<ApplyPageThree> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each question
    for (var questionModel in widget.questions) {
      final questionID = questionModel.questionID;
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

    return Column(
      children: [
        const SizedBox(height: 15),
        const Center(child: HeadingText(title: "Additional Questions")),
        const SizedBox(height: 15),
        if (widget.questions.isEmpty)
          const Center(child: HeadingText(title: "No Questions Avilable"))
        else
          ...List.generate(widget.questions.length, (index) {
            final questionModel = widget.questions[index];
            final question = questionModel.questions;
            final questionID = questionModel.questionID;
            return Column(
              children: [
                RoundedTextField(
                  controller: _controllers[questionID],
                  keyboardType: TextInputType.text,
                  labelText: "$question*",
                  validator: _requiredFieldValidator,
                  onChanged: (value) {
                    context
                        .read<JobApplyCubit>()
                        .updateApplyFormData(questionID.toString(), value);
                  },
                ),
                const SizedBox(height: 15),
              ],
            );
          }),
      ],
    );
  }
}
