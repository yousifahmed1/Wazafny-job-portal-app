import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/services/get_skill_search.dart';
import 'package:wazafny/widgets/text_fields/selectable_text_field_with_submit.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/create_job_post_model.dart';

class SkillsPage extends StatefulWidget {
  final CreateJobPostModel jobPostData;
  final Function(List<String>) onSkillsChanged;
  final GlobalKey<FormState> formKey;

  const SkillsPage({
    super.key,
    required this.jobPostData,
    required this.onSkillsChanged,
    required this.formKey,
  });

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final List<String> _selectedSkills = [];
  final TextEditingController _skillController = TextEditingController();
  static Future<List<String>>? _cachedSkillsFuture;

  @override
  void initState() {
    super.initState();
    _cachedSkillsFuture ??= GetSearchSkills().getSkills();
    _selectedSkills.addAll(widget.jobPostData.skills);
  }

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _handleSkillSubmit(String value) {
    if (value.isNotEmpty && !_selectedSkills.contains(value)) {
      setState(() {
        _selectedSkills.add(value);
        _skillController.clear();
        widget.onSkillsChanged(_selectedSkills);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _cachedSkillsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }

        if (snapshot.hasError) {
          return Center(
            child: SubHeadingText1(
              title: 'Error: ${snapshot.error}',
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: SubHeadingText1(
              title: 'No skills available.',
            ),
          );
        }

        List<String> skills = snapshot.data!;

        return SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SubHeadingText1(
                    title: "List the key skills required for this position.",
                  ),
                  const SizedBox(height: 20),
                  SearchableTextField(
                    hintText: "Enter required skills",
                    controller: _skillController,
                    labelText: "Skills",
                    optionsToSelect: skills,
                    onSkillSelected: (skill) {
                      _handleSkillSubmit(skill);
                    },
                    validator: (value) {
                      if (_selectedSkills.isEmpty) {
                        return 'Please add at least one skill';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    height: 200,
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
                                      labelStyle:
                                          const TextStyle(color: whiteColor),
                                      onDeleted: () {
                                        setState(() {
                                          _selectedSkills.remove(skill);
                                          widget
                                              .onSkillsChanged(_selectedSkills);
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : const Center(
                            child: SubHeadingText1(
                              title: 'No skills added yet.',
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
