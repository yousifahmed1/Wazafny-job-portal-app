import 'dart:developer';
import 'dart:io'; // Add this for File
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EditProfileImg extends StatefulWidget {
  const EditProfileImg({super.key});

  @override
  State<EditProfileImg> createState() => _EditProfileImgState();
}

class _EditProfileImgState extends State<EditProfileImg> {
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
      if (_selectedImage != null || imagePath != null) {
        final message =
            await context.read<SeekerProfileCubit>().uploadProfileImage(
                  image: _selectedImage!,
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

  Future<void> _deleteImage() async {
    if (imagePath != null) {
      context.read<SeekerProfileCubit>().deleteProfileImage();
    }

    // Remove controllers
    // setState(() {
    //   _selectedImage = null;
    //   imagePath = null;
    // });

    // Refresh profile
    context.read<SeekerProfileCubit>().fetchProfile();
    setState(() {
      _selectedImage = null;
      imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocBuilder<SeekerProfileCubit, ProfileState>(
        builder: (context, state) {
      if (!_initialized &&
          state is ProfileLoaded &&
          _selectedImage == null &&
          state.profile.image != "") {
        imagePath = state.profile.image;
        _initialized = true;
      }
      return Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar1(
          title: "Profile Image",
          onBackPressed: () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : imagePath != null
                              ? Image.network(
                                  imagePath!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  "assets/Images/Profile-default-image.svg",
                                  width: 200,
                                  height: 200,
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
                        color: darkerPrimary,
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
