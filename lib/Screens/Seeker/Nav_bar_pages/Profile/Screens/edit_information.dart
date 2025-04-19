import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import '../../../../../constants.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_states.dart';


class EditInformation extends StatefulWidget {
  const EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _headlineController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _aboutController = TextEditingController();
  final _resumeController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _headlineController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _aboutController.dispose();
    _resumeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded && _firstNameController.text.isEmpty) {
          _firstNameController.text = state.profile.firstName;
          _lastNameController.text = state.profile.lastName;
          _headlineController.text = state.profile.headline;
          _countryController.text = state.profile.country;
          _cityController.text = state.profile.city;
          _aboutController.text = state.profile.about ?? '';
          _resumeController.text = state.profile.resume;
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,

          backgroundColor: Colors.white,
          appBar: CustomAppBar1(
            title: "Personal Information",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    RoundedTextField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      labelText: "First Name*",
                      //validator: Validators().requiredFieldValidator,

                    ),
                    const SizedBox(height: 15,),
                    RoundedTextField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.name,
                      labelText: "Last Name*",
                      //validator: Validators().requiredFieldValidator,

                    ),
                    const SizedBox(height: 15,),

                    RoundedTextField(
                      controller: _headlineController,
                      keyboardType: TextInputType.name,
                      labelText: "Headline*",
                      //validator: Validators().requiredFieldValidator,

                    ),
                    const SizedBox(height: 15,),

                    RoundedTextField(
                      controller: _countryController,
                      keyboardType: TextInputType.name,
                      labelText: "Country*",
                      //validator: Validators().requiredFieldValidator,

                    ),
                    const SizedBox(height: 15,),

                    RoundedTextField(
                      controller: _cityController,
                      keyboardType: TextInputType.name,
                      labelText: "City*",
                      //validator: Validators().requiredFieldValidator,

                    ),
                    const SizedBox(height: 15,),



                    // Note: Links, experience, education, skills can be added as separate forms or sections
                    // Example for links: Use a ListView.builder with TextFields for name and link
                    const SizedBox(height: 20),

                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set your container color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05), // Shadow color
                        spreadRadius: 10, // Spread of the shadow
                        blurRadius: 50, // Blur effect
                        offset: const Offset(0, 0), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: GestureDetector(
                      onTap:() async {
                        try {
                          final message = await context.read<ProfileCubit>().updateProfile(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            headline: _headlineController.text,
                            country: _countryController.text,
                            city: _cityController.text,
                            about: _aboutController.text,
                            links: [], // Add link logic if needed
                          );

                          // Show success message
                          print(message);


                          // Manually trigger a UI refresh or reload the profile
                          context.read<ProfileCubit>().fetchProfile();

                          // Pop the screen after a short delay so the user sees the success message
                          Future.delayed(const Duration(milliseconds: 50), () {
                            Navigator.pop(context);
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Failed to update profile')),
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
      },
    );
  }
}