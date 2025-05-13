import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wazafny/Screens/Company/Profile/cubits/company_profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EditCompanyCoverImg extends StatefulWidget {
  const EditCompanyCoverImg({super.key});

  @override
  State<EditCompanyCoverImg> createState() => _EditCompanyCoverImgState();
}

class _EditCompanyCoverImgState extends State<EditCompanyCoverImg> {
  File? _selectedImage;
  String? imagePath;
  bool _initialized = false;

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSizeInBytes = await file.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB <= 2) {
        setState(() {
          _selectedImage = file;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image must be less than 2MB')),
        );
      }
    }
  }

  Future<void> _handleSave(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
      if (_selectedImage != null || imagePath != null) {
        final message =
            await context.read<CompanyProfileCubit>().uploadCoverImage(
                  image: _selectedImage!,
                );
        log(message);
      }
      Navigator.pop(context); // Close loading dialog

      Future.delayed(const Duration(milliseconds: 50), () {
        Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update cover image')),
      );
    }
  }

  Future<void> _deleteImage() async {
    if (imagePath != null) {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );

        final message =
            await context.read<CompanyProfileCubit>().deleteCoverImage();
        log(message);

        Navigator.pop(context); // Close loading dialog

        setState(() {
          _selectedImage = null;
          imagePath = null;
        });
      } catch (e) {
        Navigator.pop(context); // Close loading dialog
        log(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete cover image')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
      builder: (context, state) {
        if (!_initialized &&
            state is CompanyProfileLoaded &&
            _selectedImage == null &&
            state.company.coverImg != "") {
          imagePath = state.company.coverImg;
          _initialized = true;
        }
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: CustomAppBar1(
            title: "Company Cover Image",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 90),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : imagePath != null
                                ? Image.network(
                                    imagePath!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/Images/profile-banner-default.png",
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SubHeadingText2(
                      fontSize: 18,
                      title:
                          "A professional cover image helps showcase your company's brand.",
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: _pickImageFromGallery,
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 150,
                        ),
                        decoration: BoxDecoration(
                          color: darkerPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: SubHeadingText(
                            title: "Select Photo",
                            fontSize: 20,
                            titleColor: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (imagePath != null || _selectedImage != null)
                      InkWell(
                        onTap: _deleteImage,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 150,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: redColor, width: 2),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: SubHeadingText(
                              title: "Remove Photo",
                              fontSize: 20,
                              titleColor: redColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SaveButton(
                  color: darkerPrimary,
                  onTap: () => _handleSave(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
