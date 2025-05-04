import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/about_textfield.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EditAbout extends StatefulWidget {
  const EditAbout({super.key});

  @override
  State<EditAbout> createState() => _EditAboutState();
}

class _EditAboutState extends State<EditAbout> {
  final _aboutController = TextEditingController();
  bool _initialized = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    try {
      final message = await context.read<ProfileCubit>().updateAbout(
            about: _aboutController.text,
          );

      log(message);

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
  void dispose() {
    _aboutController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (!_initialized &&
          state is ProfileLoaded &&
          _aboutController.text.isEmpty) {
        // Initialize controllers with the profile data
        _aboutController.text = state.profile.about ?? '';
        _initialized = true;
      }
      return Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar1(
          title: "About",
          onBackPressed: () => Navigator.pop(context),
        ),
        body: Stack(
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
                              "Mention your years of experience, industry, key skills, achievements, and past work experiences."),
                      const SizedBox(height: 20),
                      AboutTextField(aboutController: _aboutController),
                    ],
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SaveButton(onTap: () => _handleSave(context, state)),
            ),
          ],
        ),
      );
    });
  }
}
