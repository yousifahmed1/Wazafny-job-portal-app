import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';

class ViewApplicationResponse extends StatelessWidget {
  const ViewApplicationResponse({super.key});

  final String response = '''
Thank you for applying for the [Job Title] position at [Company Name]. 
We have reviewed your application and are impressed with your background and experience.

We would like to invite you to the next stage of the recruitment process. 
Please let us know your availability for a short interview in the coming days.

We appreciate your interest in joining our team and look forward to speaking with you soon.
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
        padding: const EdgeInsets.all(30),
        child: ListView(
          padding: const EdgeInsets.only(bottom: 105), //navbar height
          children: [
            const Text(
              "Dear Slave",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: darkPrimary,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              response,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: darkPrimary),
            ),
            const Text(
              "Best regards,\n[Company Name]",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: darkPrimary,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
