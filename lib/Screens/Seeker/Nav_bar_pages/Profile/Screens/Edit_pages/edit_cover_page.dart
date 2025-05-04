import 'dart:developer';
import 'dart:io'; // Add this for File
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EditCover extends StatefulWidget {
  const EditCover({super.key});

  @override
  State<EditCover> createState() => _EditCoverState();
}

class _EditCoverState extends State<EditCover> {
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

      if (fileSizeInMB <= 1) {
        setState(() {
          _selectedImage = file;
        });
      } else {
        // You can show a message to the user here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image must be less than 1MB')),
        );
      }
    }
  }

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      if (_selectedImage != null || imagePath != null) {
        final message = await context.read<ProfileCubit>().uploadCoverImage(
              cover: _selectedImage!,
            );
        log(message);
      }

      Navigator.pop(context); // Close loading dialog
      Future.delayed(const Duration(milliseconds: 50), () {
        Navigator.pop(context); // Go back from edit page
      });
    } catch (e) {
      Navigator.pop(context); // Close loading dialog in case of error
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  Future<void> _deleteImage() async {
    if (imagePath != null) {
      context.read<ProfileCubit>().deleteCover();
    }

    // Remove controllers
    setState(() {
      _selectedImage = null;
      imagePath = null;
    });

    // Refresh profile
    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (!_initialized &&
          state is ProfileLoaded &&
          _selectedImage == null &&
          state.profile.cover != "") {
        imagePath = state.profile.cover;
        _initialized = true;
      }
      return Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar1(
          title: "Cover Photo",
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
                    height: SizeConfig.screenHeight * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkPrimary, width: 2),
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            )
                          : imagePath != null
                              ? DecorationImage(
                                  image: NetworkImage(imagePath!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: AssetImage(
                                      "assets/Images/profile-banner-default.png"),
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SubHeadingText2(
                    fontSize: 18,
                    title:
                        "A great background photo can make you more noticeable.",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: _pickImageFromGallery,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 150, // Set your minimum width here
                      ),
                      decoration: BoxDecoration(
                        color: darkPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: SubHeadingText(
                          title: "Select Photo",
                          fontSize: 20,
                          titleColor: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  imagePath != null || _selectedImage != null
                      ? InkWell(
                          onTap: _deleteImage,
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
                      : const SizedBox(),
                  const SizedBox(height: 20),
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
