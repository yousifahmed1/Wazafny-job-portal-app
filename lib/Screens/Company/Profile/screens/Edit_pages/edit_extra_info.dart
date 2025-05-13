import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/Profile/cubits/company_profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/widgets/save_button.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/Country_picker_text_field.dart';
import 'package:wazafny/widgets/text_fields/long_text_filed.dart';
import 'package:wazafny/widgets/text_fields/rounded_text_fields.dart';

class EditCompanyExtraInfo extends StatefulWidget {
  const EditCompanyExtraInfo({super.key});

  @override
  State<EditCompanyExtraInfo> createState() => _EditCompanyExtraInfoState();
}

class _EditCompanyExtraInfoState extends State<EditCompanyExtraInfo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _industryController;
  late TextEditingController _sizeController;
  late TextEditingController _headquartersController;
  late TextEditingController _foundedController;
  late TextEditingController _countryController;
  late TextEditingController _cityController;
  late TextEditingController _aboutController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _industryController = TextEditingController();
    _sizeController = TextEditingController();
    _headquartersController = TextEditingController();
    _foundedController = TextEditingController();
    _countryController = TextEditingController();
    _cityController = TextEditingController();
    _aboutController = TextEditingController();
  }

  @override
  void dispose() {
    _industryController.dispose();
    _sizeController.dispose();
    _headquartersController.dispose();
    _foundedController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _aboutController.dispose();
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

        await context.read<CompanyProfileCubit>().updateCompanyExtraInfo(
              industry: _industryController.text,
              size: _sizeController.text,
              headquarters: _headquartersController.text,
              founded: int.parse(_foundedController.text),
              country: _countryController.text,
              city: _cityController.text,
              about: _aboutController.text,
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
          _industryController.text = state.company.companyIndustry ?? "";
          _sizeController.text = state.company.companySize ?? "";
          _headquartersController.text = state.company.companyHeads ?? "";
          _foundedController.text = state.company.companyFounded ?? "";
          _countryController.text = state.company.companyCountry ?? "";
          _cityController.text = state.company.companyCity ?? "";
          _aboutController.text = state.company.about ?? "";
          _initialized = true;
        }

        return Scaffold(
          backgroundColor: whiteColor,
          appBar: CustomAppBar1(
            title: "Edit Company Details",
            onBackPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 95), //navbar height
                    children: [
                      const SizedBox(height: 15),
                      RoundedTextField(
                        controller: _industryController,
                        labelText: "Industry",
                        keyboardType: TextInputType.text,
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 15),
                      RoundedTextField(
                        controller: _sizeController,
                        labelText: "Company Size",
                        keyboardType: TextInputType.text,
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 15),
                      RoundedTextField(
                        controller: _headquartersController,
                        labelText: "Headquarters",
                        keyboardType: TextInputType.text,
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 15),
                      RoundedTextField(
                        controller: _foundedController,
                        labelText: "Founded Year",
                        keyboardType: TextInputType.number,
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 15),
                      CountryPickerTextField(
                        controller: _countryController,
                        labelText: "Country",
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 15),
                      RoundedTextField(
                        controller: _cityController,
                        labelText: "City",
                        keyboardType: TextInputType.text,
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 15),
                      LongTextField(
                        controller: _aboutController,
                        labelText: "About",
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        validator: Validators().requiredFieldValidator,
                      ),
                      const SizedBox(height: 30),
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
