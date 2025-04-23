import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/model/profile_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import '../../../../../../services/textfields_validators.dart';
import '../../../../../../widgets/custom_app_bar.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

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

  bool _initialized = false;



  // Controllers for links
  final Map<int, TextEditingController> _linkNameControllers = {};
  final Map<int, TextEditingController> _linkUrlControllers = {};
  final List<Map<String, TextEditingController>> _newLinks = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _headlineController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _aboutController.dispose();
    _resumeController.dispose();

    // Dispose of link controllers
    _linkNameControllers.forEach((key, controller) => controller.dispose());
    _linkUrlControllers.forEach((key, controller) => controller.dispose());

    // Dispose of new link controllers
    for (var link in _newLinks) {
      link['name']?.dispose();
      link['url']?.dispose();
    }

    super.dispose();
  }

  Future<void> _handleSave(BuildContext context, ProfileState state) async {
    if (_formKey.currentState!.validate()) {
      try {
        List<LinkModel> updatedLinks = [];

        // Add existing links with their IDs
        if (state is ProfileLoaded) {
          _linkNameControllers.keys.forEach((linkID) {
            if (_linkUrlControllers.containsKey(linkID)) {
              String name = _linkNameControllers[linkID]!.text;
              String url = _linkUrlControllers[linkID]!.text;
              if (name.isNotEmpty && url.isNotEmpty) {
                updatedLinks.add(LinkModel(
                  linkID: linkID,
                  name: name,
                  link: url,
                ));
              }
            }
          });
        }

        // Add new links
        for (var link in _newLinks) {
          String name = link['name']?.text ?? '';
          String url = link['url']?.text ?? '';
          if (name.isNotEmpty && url.isNotEmpty) {
            updatedLinks.add(LinkModel(name: name, link: url));
          }
        }

        // Log the updated links
        log("Updated Links: ${updatedLinks.length}");
        for (var link in updatedLinks) {
          log("Link Name: ${link.name}, Link URL: ${link.link}");
        }

        // Call the cubit to update the profile
        final message = await context.read<ProfileCubit>().updateProfile(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              headline: _headlineController.text,
              country: _countryController.text,
              city: _cityController.text,
              links: updatedLinks,
            );

        print(message); // Show success message in console

        // Close the screen after a short delay
        Future.delayed(const Duration(milliseconds: 50), () {
          Navigator.pop(context);
        });
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (!_initialized && state is ProfileLoaded && _firstNameController.text.isEmpty) {
          // Initialize controllers with the profile data
          _firstNameController.text = state.profile.firstName;
          _lastNameController.text = state.profile.lastName;
          _headlineController.text = state.profile.headline;
          _countryController.text = state.profile.country;
          _cityController.text = state.profile.city;
           

          // Initialize controllers for each link
          // Initialize controllers for each link using linkID as the key
          state.profile.links.forEach((link) {
            if (link.linkID != null) {
              _linkNameControllers[link.linkID!] =
                  TextEditingController(text: link.name ?? '');
              _linkUrlControllers[link.linkID!] =
                  TextEditingController(text: link.link ?? '');
            }
          });
        
          _initialized = true;
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: CustomAppBar1(
            title: "Personal Information",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 95), //navbar height

                    children: [
                      // Personal Informations

                      //first name textfield
                      RoundedTextField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        labelText: "First Name*",
                      ),

                      const SizedBox(height: 15),

                      //last name textfield
                      RoundedTextField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        labelText: "Last Name*",
                      ),

                      const SizedBox(height: 15),

                      //headline textfield
                      RoundedTextField(
                        controller: _headlineController,
                        keyboardType: TextInputType.name,
                        labelText: "Headline*",
                      ),

                      const SizedBox(height: 15),

                      //country textfield
                      RoundedTextField(
                        controller: _countryController,
                        keyboardType: TextInputType.name,
                        labelText: "Country*",
                      ),

                      const SizedBox(height: 15),

                      //city textfield
                      RoundedTextField(
                        controller: _cityController,
                        keyboardType: TextInputType.name,
                        labelText: "City*",
                      ),

                      const SizedBox(height: 15),


                      //loaded links
                      if (state is ProfileLoaded &&
                          state.profile.links.isNotEmpty)
                        ...state.profile.links.asMap().entries.map((entry) {
                          final index = entry.key; // This is the index
                          final link = entry.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SubHeadingText(title: "Link ${index + 1}"),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (link.linkID != null) {
                                        // Delete from cubit
                                        context
                                            .read<ProfileCubit>()
                                            .deleteLink(linkId: link.linkID!);

                                        // Remove controllers
                                        setState(() {
                                          _linkNameControllers
                                              .remove(link.linkID);
                                          _linkUrlControllers
                                              .remove(link.linkID);
                                        });

                                        // Refresh profile
                                        context
                                            .read<ProfileCubit>()
                                            .fetchProfile();
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/Icons/delete_icon.svg",
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              RoundedTextField(
                                controller: link.linkID != null
                                    ? _linkNameControllers[link.linkID!]
                                    : TextEditingController(),
                                keyboardType: TextInputType.text,
                                labelText: "Link Name*",
                                validator: Validators().requiredFieldValidator,
                              ),
                              const SizedBox(height: 15),
                              RoundedTextField(
                                controller: link.linkID != null
                                    ? _linkUrlControllers[link.linkID!]
                                    : TextEditingController(),
                                keyboardType: TextInputType.url,
                                labelText: "Link URL*",
                                validator: Validators().validateUrl,
                              ),
                              const SizedBox(height: 15),
                            ],
                          );
                        }).toList(),
                      const SizedBox(height: 20),

                      // New Link Section

                      ..._newLinks.asMap().entries.map((entry) {
                        final index = entry.key;
                        final controllers = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SubHeadingText(title: "New Link ${index + 1}"),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _newLinks.removeAt(index);
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "assets/Icons/delete_icon.svg",
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Link Name text field
                            RoundedTextField(
                              validator: Validators().requiredFieldValidator,
                              controller: controllers['name'],
                              keyboardType: TextInputType.text,
                              labelText: "Link Name*",
                            ),
                            const SizedBox(height: 15),

                            // Link URL text field
                            RoundedTextField(
                              controller: controllers['url'],
                              validator: Validators().validateUrl,
                              keyboardType: TextInputType.url,
                              labelText: "Link URL*",
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      }).toList(),

                      // Add New Link
                      InkWell(
                        onTap: () {
                          setState(() {
                            _newLinks.add({
                              'name': TextEditingController(),
                              'url': TextEditingController(),
                            });
                          });
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/Icons/Add_icon.svg",
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            const HeadingText(title: "Add New Link"),
                          ],
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ),

              // Save Button
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SaveButton(onTap: () => _handleSave(context, state)),
              ),
            ],
          ),
        );
      },
    );
  }

}
