import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/create_job_post_model.dart';

class ExtraSectionsPage extends StatefulWidget {
  final CreateJobPostModel jobPostData;
  final Function(List<Map<String, String>>) onSectionsChanged;

  const ExtraSectionsPage({
    super.key,
    required this.jobPostData,
    required this.onSectionsChanged,
  });

  @override
  State<ExtraSectionsPage> createState() => _ExtraSectionsPageState();
}

class _ExtraSectionsPageState extends State<ExtraSectionsPage> {
  final List<Map<String, TextEditingController>> _newSections = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers from existing data
    for (var section in widget.jobPostData.extraSections) {
      _newSections.add({
        'name': TextEditingController(text: section['name']),
        'description': TextEditingController(text: section['description']),
      });
    }
  }

  @override
  void dispose() {
    for (var section in _newSections) {
      section['name']?.dispose();
      section['description']?.dispose();
    }
    super.dispose();
  }

  void _updateParentData() {
    final sections = _newSections.map((section) {
      return {
        'name': section['name']?.text ?? '',
        'description': section['description']?.text ?? '',
      };
    }).toList();
    widget.onSectionsChanged(sections);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._newSections.asMap().entries.map((entry) {
              final index = entry.key;
              final controllers = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SubHeadingText1(
                        title: "Section ${index + 1}",
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _newSections.removeAt(index);
                            _updateParentData();
                          });
                        },
                        child: SvgPicture.asset(
                          "assets/Icons/delete_icon.svg",
                          width: 20,
                          height: 20,
                          // ignore: deprecated_member_use
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RoundedTextField(
                    controller: controllers['name'],
                    keyboardType: TextInputType.text,
                    labelText: "Section Name*",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    onChanged: (_) => _updateParentData(),
                  ),
                  const SizedBox(height: 15),
                  RoundedTextField(
                    controller: controllers['description'],
                    keyboardType: TextInputType.multiline,
                    labelText: "Section Description*",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                    onChanged: (_) => _updateParentData(),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _newSections.add({
                    'name': TextEditingController(),
                    'description': TextEditingController(),
                  });
                  _updateParentData();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/Icons/Add_icon.svg",
                    width: 20,
                    height: 20,
                    // ignore: deprecated_member_use
                    color: primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const HeadingText(
                    titleColor: primaryColor,
                    title: "Add new Section",
                    fontSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
