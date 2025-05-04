import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

class ApplyPageOne extends StatefulWidget {
  const ApplyPageOne({
    super.key,
    required this.jobApplyModel,
    this.isEditMode = false,
  });
  final JobApplyModel jobApplyModel;
  final bool isEditMode;

  @override
  State<ApplyPageOne> createState() => _ApplyPageOneState();
}

class _ApplyPageOneState extends State<ApplyPageOne> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditMode) {
      _firstNameController.text = widget.jobApplyModel.firstName!;
      _lastNameController.text = widget.jobApplyModel.lastName!;
      _phoneNumberController.text = widget.jobApplyModel.phone!;
      _emailController.text = widget.jobApplyModel.emailAddress!;
      _countryController.text = widget.jobApplyModel.country!;
      _cityController.text = widget.jobApplyModel.city!;
    }
    SizeConfig.init(context);
    return Column(
      children: [
        const Center(child: HeadingText(title: "Add your contact information")),
        RoundedTextField(
          controller: _firstNameController,
          keyboardType: TextInputType.name,
          labelText: "First Name*",
          validator: Validators().requiredFieldValidator,
          onChanged: (value) {
            widget.jobApplyModel.firstName = value;
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _lastNameController,
          keyboardType: TextInputType.name,
          labelText: "Last Name*",
          validator: Validators().requiredFieldValidator,
          onChanged: (value) {
            widget.jobApplyModel.lastName = value;
            ;
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          labelText: "Phone Number*",
          validator: Validators().phoneValidator,
          onChanged: (value) {
            widget.jobApplyModel.phone = value;
            log("phone : ${widget.jobApplyModel.phone}");
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: "Email address*",
          validator: Validators().emailValidator,
          onChanged: (value) {
            widget.jobApplyModel.emailAddress = value;
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _countryController,
          keyboardType: TextInputType.text,
          labelText: "Country*",
          validator: Validators().requiredFieldValidator,
          onChanged: (value) {
            widget.jobApplyModel.country = value;
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _cityController,
          keyboardType: TextInputType.text,
          validator: Validators().requiredFieldValidator,
          labelText: "City, State*",
          onChanged: (value) {
            widget.jobApplyModel.city = value;
          },
        ),
      ],
    );
  }
}
