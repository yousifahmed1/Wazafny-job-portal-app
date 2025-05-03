import 'dart:io'; // Add this for File
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/job_posts/model/job_apply_model.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wazafny/widgets/texts/paragraph.dart';

class ApplyPageTwo extends StatefulWidget {
  const ApplyPageTwo({super.key,required this.jobApplyModel});
    final JobApplyModel jobApplyModel;


  @override
  State<ApplyPageTwo> createState() => _ApplyPageTwoState();
}

class _ApplyPageTwoState extends State<ApplyPageTwo> {
  File? _selectedFile; // Store the file object instead of path

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!); // Create File object
      });
      // Update cubit with the File object
                  widget.jobApplyModel.resume = _selectedFile ;

    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

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
                          title:
                              "Selected: ${_selectedFile!.path.split('/').last}",
                        ),
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
