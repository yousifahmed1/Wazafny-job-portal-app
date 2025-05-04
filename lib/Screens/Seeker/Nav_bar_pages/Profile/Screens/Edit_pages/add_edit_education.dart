import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/custom_checkbox.dart';
import 'package:wazafny/widgets/text_fields/date_picker_text_field.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import '../../../../../../widgets/custom_app_bar.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

class AddEditEducation extends StatefulWidget {
  const AddEditEducation({super.key, this.education});
  final dynamic education;

  @override
  State<AddEditEducation> createState() => _AddEditEducationState();
}

class _AddEditEducationState extends State<AddEditEducation> {
  final _universityController = TextEditingController();
  final _collegeTypeController = TextEditingController();
  final _startDatController = TextEditingController();
  final _endDateController = TextEditingController();

  bool _currentlyStudent = false;
  bool _initialized = false;
  bool _editMode = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _universityController.dispose();
    _collegeTypeController.dispose();
    _startDatController.dispose();
    _endDateController.dispose();

    super.dispose();
  }

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    if (_formKey.currentState!.validate()) {
      try {
        final cubit = context.read<ProfileCubit>();
        final endDate =
            !_currentlyStudent ? _endDateController.text : 'Present';

        await cubit.addUpdateEducation(
          university: _universityController.text,
          college: _collegeTypeController.text,
          startDate: _startDatController.text,
          endDate: endDate,
        );

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (e) {
        log(e.toString());
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save experience')),
        );
      }
    }
  }

  Future<void> _deleteEdution() async {
    context.read<ProfileCubit>().deleteEducation();

    // Remove controllers

    Navigator.pop(context);

    // Refresh profile
    context.read<ProfileCubit>().fetchProfile();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final edu = widget.education;

  //   if (edu != null) {
  //     _universityController.text = edu.university!;
  //     _collegeTypeController.text = edu.college!;
  //     _startDatController.text = edu.startDate!;
  //     _endDateController.text =
  //         edu.endDate != 'Present' ? (edu.endDate ?? '') : '';
  //     _currentlyStudent = edu.endDate == 'Present';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (!_initialized &&
            state is ProfileLoaded &&
            _universityController.text.isEmpty &&
            state.profile.education != null) {
          // Initialize controllers with the profile data

          _universityController.text = state.profile.education!.university!;
          _collegeTypeController.text = state.profile.education!.college!;
          _startDatController.text = state.profile.education!.startDate!;
          _endDateController.text =
              state.profile.education!.endDate! != 'Present'
                  ? (state.profile.education!.endDate ?? '')
                  : '';
          _currentlyStudent = state.profile.education!.endDate! == 'Present';

          _initialized = true;
          _editMode = true;
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: CustomAppBar1(
            title:
                widget.education != null ? "Edit Education" : "Add Education",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 95), //navbar height

                    children: [
                      // Personal Informations

                      const SizedBox(
                        height: 10,
                      ),

                      const SubHeadingText(
                          title:
                              "Add your degree, field of study, and university name here."),

                      const SizedBox(
                        height: 10,
                      ),

                      //tittle textfield
                      RoundedTextField(
                        validator: Validators().requiredFieldValidator,
                        controller: _universityController,
                        keyboardType: TextInputType.name,
                        labelText: "University*",
                      ),

                      const SizedBox(height: 15),

                      const SizedBox(height: 15),
                      RoundedTextField(
                        validator: Validators().requiredFieldValidator,
                        controller: _collegeTypeController,
                        keyboardType: TextInputType.name,
                        labelText: "College*",
                      ),
                      //Year start date textfield

                      const SizedBox(height: 15),

                      //Month start date textfield
                      DatePickerField(
                        validator: Validators().requiredFieldValidator,
                        controller: _startDatController,
                        labelText: "Start date*",
                      ),

                      const SizedBox(height: 15),

                      DatePickerField(
                        validator: Validators().requiredFieldValidator,
                        isEnabled: !_currentlyStudent,
                        controller: _endDateController,
                        labelText: "End date*",
                      ),

                      //Year end date textfield

                      const SizedBox(height: 30),

                      Row(
                        children: [
                          AnimatedCustomCheckbox(
                            value: _currentlyStudent,
                            onChanged: (value) {
                              setState(() {
                                _endDateController.text = "";
                                _currentlyStudent = value!;
                              });
                            },
                            activeColor: darkPrimary, // Custom active color
                            size: 30.0, // Custom checkbox size
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SubHeadingText(
                            title: "I ‘m still a student in this University",
                            titleColor: darkPrimary,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      _editMode
                          ? Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: lightRedColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: InkWell(
                                    onTap: () => _deleteEdution(),
                                    child: const HeadingText(
                                      title: "Delete education",
                                      titleColor: redColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),

              // Save Button
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                // child: SaveButton(
                //   onTap: () {},
                // )

                child: SaveButton(onTap: () => _handleSave(context, state)),
              ),
            ],
          ),
        );
      },
    );
  }
}
