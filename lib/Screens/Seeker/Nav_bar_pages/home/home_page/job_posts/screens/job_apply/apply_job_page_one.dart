import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/cubits/job_apply_cubit/job_apply_cubit.dart';
//import 'package:wazafny/services/textfields_validators.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

class ApplyPageOne extends StatefulWidget {
  const ApplyPageOne({super.key});

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
    SizeConfig.init(context);
    return Column(
      children: [
        const Center(child: HeadingText(title: "Add your contact information")),
        RoundedTextField(
          controller: _firstNameController,
          keyboardType: TextInputType.name,
          labelText: "First Name*",
          //validator: Validators().requiredFieldValidator,
          onChanged: (value) {
            context
                .read<JobApplyCubit>()
                .updateApplyFormData("firstName", value);
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _lastNameController,
          keyboardType: TextInputType.name,
          labelText: "Last Name*",
          //validator: Validators().requiredFieldValidator,
          onChanged: (value) {
            context
                .read<JobApplyCubit>()
                .updateApplyFormData("lastName", value);
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          labelText: "Phone Number*",
          //validator: Validators().phoneValidator,
          onChanged: (value) {
            context
                .read<JobApplyCubit>()
                .updateApplyFormData("phoneNumber", value);
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: "Email address*",
          //validator: Validators().emailValidator,
          onChanged: (value) {
            context.read<JobApplyCubit>().updateApplyFormData("email", value);
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _countryController,
          keyboardType: TextInputType.text,
          labelText: "Country*",
          //validator: Validators().requiredFieldValidator,
          onChanged: (value) {
            context.read<JobApplyCubit>().updateApplyFormData("country", value);
          },
        ),
        const SizedBox(height: 15),
        RoundedTextField(
          controller: _cityController,
          keyboardType: TextInputType.text,
          //validator: Validators().requiredFieldValidator,
          labelText: "City, State*",
          onChanged: (value) {
            context.read<JobApplyCubit>().updateApplyFormData("city", value);
          },
        ),
      ],
    );
  }
}
