import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/custom_checkbox.dart';
import 'package:wazafny/widgets/text_fields/date_picker_text_field.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/widgets/text_fields/selectable_text_field.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import '../../../../../../../widgets/custom_app_bar.dart';
import '../../../cubit/profile_cubit.dart';
import '../../../cubit/profile_states.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({super.key, this.experience});
  final dynamic experience;

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  final _tittleController = TextEditingController();
  final _employmentTypeController = TextEditingController();
  final _companyController = TextEditingController();
  final _startDatController = TextEditingController();
  final _endDateController = TextEditingController();

  bool _currentlyEmployed = false;

  // Controllers for links

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _tittleController.dispose();
    _employmentTypeController.dispose();
    _companyController.dispose();
    _startDatController.dispose();
    _endDateController.dispose();

    super.dispose();
  }

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    if (_formKey.currentState!.validate()) {
      try {
        final cubit = context.read<SeekerProfileCubit>();
        final endDate =
            !_currentlyEmployed ? _endDateController.text : 'Present';

        if (widget.experience != null) {
          // Edit
          await cubit.updateExperience(
            experienceId: widget.experience?.experienceID ?? 0,
            company: _companyController.text,
            jobTitle: _tittleController.text,
            jobTime: _employmentTypeController.text,
            startDate: _startDatController.text,
            endDate: endDate,
          );
        } else {
          // Add
          await cubit.addExperience(
            company: _companyController.text,
            jobTitle: _tittleController.text,
            jobTime: _employmentTypeController.text,
            startDate: _startDatController.text,
            endDate: endDate,
          );
        }

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

  @override
  void initState() {
    super.initState();
    final exp = widget.experience;

    if (exp != null) {
      _tittleController.text = exp.jobTitle!;
      _employmentTypeController.text = exp.employmentType!;
      _companyController.text = exp.company!;
      _startDatController.text = exp.startDate!;
      _endDateController.text =
          exp.endDate != 'Present' ? (exp.endDate ?? '') : '';
      _currentlyEmployed = exp.endDate == 'Present';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeekerProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: CustomAppBar1(
            title: widget.experience != null
                ? "Edit Experience"
                : "Add New Experience",
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
                              "Add your work experience, including job roles and responsibilities, here."),

                      const SizedBox(
                        height: 10,
                      ),

                      //tittle textfield
                      RoundedTextField(
                        validator: Validators().requiredFieldValidator,
                        controller: _tittleController,
                        keyboardType: TextInputType.name,
                        labelText: "Job tittle*",
                      ),

                      const SizedBox(height: 15),

                      //employment type textfield

                      SelectableTextField(
                        controller: _employmentTypeController,
                        labelText: "Employment type*",
                        optionsToSelect: const ['Full-time', 'Part-time'],
                      ),

                      const SizedBox(height: 15),
                      RoundedTextField(
                        validator: Validators().requiredFieldValidator,
                        controller: _companyController,
                        keyboardType: TextInputType.name,
                        labelText: "Company*",
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
                        isEnabled: !_currentlyEmployed,
                        controller: _endDateController,
                        labelText: "End date*",
                      ),

                      //Year end date textfield

                      const SizedBox(height: 30),

                      Row(
                        children: [
                          AnimatedCustomCheckbox(
                            value: _currentlyEmployed,
                            onChanged: (value) {
                              setState(() {
                                _endDateController.text = "";
                                _currentlyEmployed = value!;
                              });
                            },
                            activeColor: darkerPrimary, // Custom active color
                            size: 30.0, // Custom checkbox size
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SubHeadingText(
                            title: "I am currently working in this role",
                            titleColor: darkerPrimary,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // Save Button
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SaveButton(onTap: () => _handleSave(context, state)),
              ),
            ],
          ),
        );
      },
    );
  }
}
