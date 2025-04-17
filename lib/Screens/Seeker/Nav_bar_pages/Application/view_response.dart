import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';

class ViewApplicationResponse extends StatelessWidget {
  const ViewApplicationResponse({super.key});

  final String response = '''

Dear Yousif,

Thank you for applying for the [Job Title] position at [Company Name]. 
We have reviewed your application and are impressed with your background and experience.

We would like to invite you to the next stage of the recruitment process. 
Please let us know your availability for a short interview in the coming days.

We appreciate your interest in joining our team and look forward to speaking with you soon.

Best regards,  
[Hiring Manager Name]  
[Company Name]  
[Contact Information]

''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar1(
        title: "Application Response",
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: bordersColor, width: 1),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  response,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
