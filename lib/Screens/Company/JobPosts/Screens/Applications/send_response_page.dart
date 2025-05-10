import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/long_text_filed.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class SendResponsePage extends StatelessWidget {
  SendResponsePage({super.key});
  final TextEditingController commentController = TextEditingController();

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
          Padding(
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
                  maxLength: 500,
                  maxLines: 6,
                )
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SaveButton(
                color: darkerPrimary,
                onTap: () {},
              ))
        ],
      ),
    );
  }
}
