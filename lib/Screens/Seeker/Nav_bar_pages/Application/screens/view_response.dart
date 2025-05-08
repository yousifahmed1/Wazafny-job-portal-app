import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Application/model/job_applications_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';

class ViewApplicationResponse extends StatefulWidget {
  const ViewApplicationResponse({super.key, required this.jobApplicationModel});
  final JobApplicationModel jobApplicationModel;

  @override
  State<ViewApplicationResponse> createState() =>
      _ViewApplicationResponseState();
}

class _ViewApplicationResponseState extends State<ViewApplicationResponse> {
  var firstName;
  var lastName;

  bool isInistialized = false;

  @override
  initState() {
    super.initState();
    _initialize();
  }
Future<void> _initialize() async {
  final fName = await AuthRepository().getFirstName() ?? "";
  final lName = await AuthRepository().getLastName() ?? "";
  setState(() {
    firstName = fName;
    lastName = lName;
    isInistialized = true;
  });
}


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
            Text(
              "Dear $firstName $lastName,",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: darkerPrimary,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              widget.jobApplicationModel.response ?? "No response yet",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: darkerPrimary),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Best regards,\n${widget.jobApplicationModel.companyName}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: darkerPrimary,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
