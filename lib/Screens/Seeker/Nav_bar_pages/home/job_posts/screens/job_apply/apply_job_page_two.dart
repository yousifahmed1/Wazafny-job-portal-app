import 'dart:developer';
import 'dart:io'; // Add this for File
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class ApplyPageTwo extends StatefulWidget {
  const ApplyPageTwo({
    super.key,
    required this.jobApplyModel,
    this.isEditMode = false,
  });
  final JobApplyModel jobApplyModel;
  final bool isEditMode;

  @override
  State<ApplyPageTwo> createState() => _ApplyPageTwoState();
}

class _ApplyPageTwoState extends State<ApplyPageTwo> {
  File? _selectedFile; // Store the file object instead of path
  String? resumePath;
  bool _isLoaded = false;

  //pick file function
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
        // Update cubit with the File object
        widget.jobApplyModel.resume = _selectedFile;
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

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    if (_isLoaded == false &&
        _selectedFile == null &&
        widget.jobApplyModel.resume != "" &&
        widget.jobApplyModel.resume != null) {
      resumePath = widget.jobApplyModel.resume;
      _isLoaded = true;
      log(resumePath.toString());
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const HeadingText1(title: "Resume"),
          const SizedBox(height: 10),
          const Paragraph(paragraph: "Be sure to upload updated resume"),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickFile,
            child: DottedBorder(
              color: darkPrimary, // Border color
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
                      ] else if (resumePath != null) ...[
                        HeadingText(
                          textAlignment: TextAlign.center,
                          title:
                              "${widget.jobApplyModel.firstName}_Resume.${resumePath!.split('.').last.toLowerCase()}  ",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedFile = null;
                              resumePath = null;
                              widget.jobApplyModel.resume = null;
                            });
                          },
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 150, // Set your minimum width here
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: redColor, width: 2),
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
                          paragraph: "Accepted file types are PDF, DOC, DOCX",
                        ),
                      ],
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
