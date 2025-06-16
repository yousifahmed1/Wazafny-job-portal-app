import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/text_fields/Country_picker_text_field.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/widgets/text_fields/long_text_filed.dart';
import 'package:wazafny/widgets/text_fields/selectable_text_field.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/create_job_post_model.dart';

class BasicInfoPage extends StatefulWidget {
  final CreateJobPostModel jobPostData;
  final Function(Map<String, String>) onDataChanged;
  final GlobalKey<FormState> formKey;

  const BasicInfoPage({
    super.key,
    required this.jobPostData,
    required this.onDataChanged,
    required this.formKey,
  });

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  late final TextEditingController _jobTitleController;
  late final TextEditingController _countryController;
  late final TextEditingController _aboutController;
  late final TextEditingController _jobTypeController;
  late final TextEditingController _employmentTypeController;
  late final TextEditingController _cityController;

  final List<String> _jobTypes = ['Remote', 'Hybrid', 'On-site'];
  final List<String> _employmentTypes = ['Full-time', 'Part-time'];

  @override
  void initState() {
    super.initState();
    _jobTitleController =
        TextEditingController(text: widget.jobPostData.jobTitle);
    _countryController =
        TextEditingController(text: widget.jobPostData.country);
    _aboutController = TextEditingController(text: widget.jobPostData.about);
    _jobTypeController =
        TextEditingController(text: widget.jobPostData.jobType);
    _employmentTypeController =
        TextEditingController(text: widget.jobPostData.employmentType);
    _cityController = TextEditingController(text: widget.jobPostData.city);
  }

  void _updateParentData() {
    widget.onDataChanged({
      'jobTitle': _jobTitleController.text,
      'about': _aboutController.text,
      'country': _countryController.text,
      'city': _cityController.text,
      'jobType': _jobTypeController.text,
      'employmentType': _employmentTypeController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextField(
              controller: _jobTitleController,
              keyboardType: TextInputType.text,
              labelText: "Job Title*",
              validator: Validators().requiredFieldValidator,
              onChanged: (_) => _updateParentData(),
            ),
            const SizedBox(height: 16),
            LongTextField(
              controller: _aboutController,
              keyboardType: TextInputType.multiline,
              labelText: "About*",
              maxLines: 5,
              validator: Validators().requiredFieldValidator,
              onChanged: (_) => _updateParentData(),
            ),
            const SizedBox(height: 16),
            CountryPickerTextField(
              controller: _countryController,
              labelText: "Country*",
              validator: Validators().requiredFieldValidator,
              onChanged: (_) => _updateParentData(),
            ),
            const SizedBox(height: 16),
            RoundedTextField(
              controller: _cityController,
              keyboardType: TextInputType.text,
              labelText: "City*",
              validator: Validators().requiredFieldValidator,
              onChanged: (_) => _updateParentData(),
            ),
            const SizedBox(height: 16),
            SelectableTextField(
              controller: _jobTypeController,
              labelText: "Job Type*",
              optionsToSelect: _jobTypes,
              validator: Validators().requiredFieldValidator,
              onChanged: (_) => _updateParentData(),
            ),
            const SizedBox(height: 16),
            SelectableTextField(
              controller: _employmentTypeController,
              labelText: "Employment Type*",
              optionsToSelect: _employmentTypes,
              validator: Validators().requiredFieldValidator,
              onChanged: (_) => _updateParentData(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _aboutController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _jobTypeController.dispose();
    _employmentTypeController.dispose();
    super.dispose();
  }
}
