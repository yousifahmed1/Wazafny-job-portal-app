import 'dart:developer';
import 'dart:io'; // Add this for File
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EditResume extends StatefulWidget {
  const EditResume({super.key});

  @override
  State<EditResume> createState() => _EditResumeState();
}

class _EditResumeState extends State<EditResume> {
  File? _selectedFile; // Store the file object instead of path
  String? resumePath;
  bool _initialized = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final fileExtension = filePath.split('.').last.toLowerCase();

      if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
        setState(() {
          _selectedFile = File(filePath);
        });
      } else {
        // Show error: unsupported file type
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Unsupported file type. Please select PDF, DOC, or DOCX."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteResume() async {
    if (resumePath != null) {
      context.read<SeekerProfileCubit>().deleteResume();
    }

    // Remove controllers
    setState(() {
      _selectedFile = null;
      resumePath = null;
    });

    // Refresh profile
    context.read<SeekerProfileCubit>().fetchProfile();
  }

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      if (_selectedFile != null ||
          resumePath != null &&
              _selectedFile is! String &&
              resumePath is! String) {
        final message = await context.read<SeekerProfileCubit>().uploadResume(
              resume: _selectedFile!,
            );
        log(message);
      }
      Navigator.pop(context); // Close loading dialog

      Future.delayed(const Duration(milliseconds: 50), () {
        Navigator.pop(context);
      });
    } catch (e) {
      // Error handling
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<SeekerProfileCubit, ProfileState>(
        builder: (context, state) {
      if (!_initialized &&
          state is ProfileLoaded &&
          _selectedFile == null &&
          state.profile.resume != "") {
        resumePath = state.profile.resume;
        _initialized = true;

        log(resumePath.toString());
      }
      return Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar1(
          title: "Resume",
          onBackPressed: () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  GestureDetector(
                    onTap: _pickFile,
                    child: DottedBorder(
                      color: darkerPrimary, // Border color
                      strokeWidth: 2, // Thickness
                      dashPattern: const [6, 3], // Dots and space
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      child: SizedBox(
                        width: double.infinity,
                        height: SizeConfig.screenWidth,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/Icons/Resume.svg",
                              ),
                              const SizedBox(height: 20),
                              if (_selectedFile != null) ...[
                                const SizedBox(height: 20),
                                HeadingText(
                                  textAlignment: TextAlign.center,
                                  title:
                                      "Selected: ${_selectedFile!.path.split('/').last}",
                                ),
                              ] else if (resumePath != null &&
                                  state is ProfileLoaded) ...[
                                HeadingText(
                                  textAlignment: TextAlign.center,
                                  title:
                                      "${state.profile.firstName}_Resume.${resumePath!.split('.').last.toLowerCase()}  ",
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: _deleteResume,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minWidth:
                                          150, // Set your minimum width here
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: redColor, width: 2),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: SubHeadingText(
                                        textAlignment: TextAlign.center,
                                        title: "Delete",
                                        fontSize: 20,
                                        titleColor: redColor,
                                      ),
                                    ),
                                  ),
                                )
                              ] else ...[
                                const HeadingText(title: "Upload Resume"),
                                const SizedBox(height: 5),
                                const Paragraph(
                                  paragraph:
                                      "Accepted file types are PDF, DOC, DOCX",
                                ),
                              ],
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                      child: SubHeadingText(
                          title: "Be sure to upload updated resume")),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SaveButton(
                onTap: () => _handleSave(context, state),
              ),
            ),
          ],
        ),
      );
    });
  }
}
