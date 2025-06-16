import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/cubits/company_view_application_cubit/company_view_application_cubit.dart';
import 'package:wazafny/Screens/Company/JobPosts/widgets/accept_confirm_dialog.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/long_text_filed.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class SendResponsePage extends StatefulWidget {
  SendResponsePage(
      {super.key, required this.applicationId, required this.jobId});
  final int applicationId;
  final int jobId;

  @override
  State<SendResponsePage> createState() => _SendResponsePageState();
}

class _SendResponsePageState extends State<SendResponsePage> {
  final TextEditingController commentController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        onBackPressed: Navigator.of(context).pop,
        title: "Send Response",
        // isTitleNotCentered: true,
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 105), //navbar height
                children: [
                  const SubHeadingText(
                      title:
                          "Please leave your response or feedback regarding this job application."),
                  LongTextField(
                    controller: commentController,
                    keyboardType: TextInputType.multiline,
                    validator: Validators().requiredFieldValidator,
                    maxLength: 500,
                    maxLines: 6,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SaveButton(
                color: darkerPrimary,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AcceptConfirmDialog(
                        onConfirm: () => _onAccept(context),
                        title: "Accept Application",
                        description:
                            "Are you sure you want to accept this application?",
                      ),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }

  void _onAccept(BuildContext context) {
    Navigator.pop(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    context.read<CompanyApplicationCubit>().sendResponse(
        applicationId: widget.applicationId,
        status: "Accepted",
        jobId: widget.jobId,
        responseMessage: commentController.text);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
