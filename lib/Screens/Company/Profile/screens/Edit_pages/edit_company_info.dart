import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/Profile/cubits/company_profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/long_text_filed.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';

class EditCompanyInfo extends StatefulWidget {
  const EditCompanyInfo({super.key});

  @override
  State<EditCompanyInfo> createState() => _EditCompanyInfoState();
}

class _EditCompanyInfoState extends State<EditCompanyInfo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _headlineController;
  late TextEditingController _websiteController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _headlineController = TextEditingController();
    _websiteController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _headlineController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Future<void> _handleSave(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );

        await context.read<CompanyProfileCubit>().updateCompanyInfo(
              name: _nameController.text,
              email: _emailController.text,
              headline: _headlineController.text,
              website: _websiteController.text,
            );

        Navigator.pop(context); // Close loading dialog
        Navigator.pop(context); // Return to profile page
      } catch (e) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
      builder: (context, state) {
        if (!_initialized && state is CompanyProfileLoaded) {
          _nameController.text = state.company.companyName;
          _emailController.text = state.company.companyEmail ?? "";
          _headlineController.text = state.company.headline ?? "";
          _websiteController.text = state.company.companyWebsiteLink ?? "";
          _initialized = true;
        }

        return Scaffold(
          backgroundColor: whiteColor,
          appBar: CustomAppBar1(
            title: "Edit Company Info",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      RoundedTextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        labelText: "Company Name*",
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 20),
                      RoundedTextField(
                        controller: _websiteController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Website",
                      ),
                      const SizedBox(height: 20),
                      RoundedTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Email*",
                        validator: Validators().emailValidator,
                      ),
                      const SizedBox(height: 20),
                      LongTextField(
                        maxLines: 2,
                        controller: _headlineController,
                        keyboardType: TextInputType.multiline,
                        labelText: "Headline*",
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 20),

                      // Add padding at the bottom to ensure content isn't hidden behind the save button
                      const SizedBox(height: 100),
                    ],
                  ),
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
