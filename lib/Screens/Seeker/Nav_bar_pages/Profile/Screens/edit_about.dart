import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class EditAbout extends StatefulWidget {
  const EditAbout({super.key});

  @override
  State<EditAbout> createState() => _EditAboutState();
}

class _EditAboutState extends State<EditAbout> {
  final _aboutController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded && _aboutController.text.isEmpty) {
        // Initialize controllers with the profile data
        _aboutController.text = state.profile.about ?? '';
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
                      Container(
                        width: double.infinity,
                        height: SizeConfig.screenHeight * (1 / 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: bordersColor, width: 2),
                        ),
                        child: TextFormField(
                          cursorColor: loginTextColor,
                          controller: _aboutController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12), // Adjust padding
                          ),
                          style: const TextStyle(
                            color: loginTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ), // Optional: Adjust text style
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 10,
                      blurRadius: 50,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        final message =
                            await context.read<ProfileCubit>().updateAbout(
                                  about: _aboutController.text,
                                );

                        print(message);

                        Future.delayed(const Duration(milliseconds: 50), () {
                          Navigator.pop(context);
                        });
                      } catch (e) {
                        // Error handling
                        print(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to update profile')),
                        );
                      }
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Apply Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
