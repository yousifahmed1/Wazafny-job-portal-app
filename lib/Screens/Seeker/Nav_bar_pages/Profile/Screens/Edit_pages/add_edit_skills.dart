import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/services/get_skill_search.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/selectable_text_field_with_submit.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EditAddSkills extends StatefulWidget {
  const EditAddSkills({super.key});

  @override
  State<EditAddSkills> createState() => _EditAddSkillsState();
}

class _EditAddSkillsState extends State<EditAddSkills> {
  final TextEditingController _skillsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _initialized = false;
  List<String> _selectedSkills = [];

  // ignore: prefer_typing_uninitialized_variables
  var future;

  @override
  void initState() {
    super.initState();
    future = GetSearchSkills().getSkills();
  }

  @override
  void dispose() {
    _skillsController.dispose();
    super.dispose();
  }

  void _handleSkillSubmit(String value) {
    if (value.isNotEmpty && !_selectedSkills.contains(value)) {
      setState(() {
        _selectedSkills.add(value);
        _skillsController.clear();
      });
    }
  }

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    if (_formKey.currentState!.validate()) {
      try {
        final cubit = context.read<SeekerProfileCubit>();

        await cubit.updateSkills(skills: _selectedSkills);

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
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<SeekerProfileCubit, ProfileState>(
      builder: (context, state) {
        if (!_initialized && state is ProfileLoaded) {
          _selectedSkills = List<String>.from(
              state.profile.skills.map((skill) => skill.skill));
          _initialized = true;
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: whiteColor,
          appBar: CustomAppBar1(
            title: "Skills",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: FutureBuilder<List<String>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No skills available.'));
              }

              List<String> skills = snapshot.data!;

              return Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children: [
                          const SizedBox(height: 30),
                          const SubHeadingText1(
                              title:
                                  "List your key skills and expertise here."),
                          const SizedBox(height: 20),
                          SearchableTextField(
                            hintText: "Enter your skills",
                            controller: _skillsController,
                            labelText: "Skills",
                            optionsToSelect: skills,
                            onSkillSelected: (skill) {
                              _handleSkillSubmit(skill);
                            },
                          ),
                          const SizedBox(height: 50),
                          Container(
                            width: double.infinity,
                            height: SizeConfig.screenHeight * (1 / 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: bordersColor, width: 2),
                            ),
                            child: _selectedSkills.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Wrap(
                                      spacing: 8,
                                      children: _selectedSkills
                                          .map(
                                            (skill) => Chip(
                                              label: Text(skill),
                                              deleteIcon: const Icon(
                                                Icons.clear,
                                                color: whiteColor,
                                              ),
                                              backgroundColor: Colors.black,
                                              labelStyle: const TextStyle(
                                                  color: whiteColor),
                                              onDeleted: () {
                                                setState(() {
                                                  _selectedSkills.remove(skill);
                                                });
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                : const Center(
                                    child: Text('No skills added yet.'),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SaveButton(onTap: () => _handleSave(context, state)),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
