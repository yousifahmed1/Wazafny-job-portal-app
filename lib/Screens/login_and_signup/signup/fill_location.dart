import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/text_fields/Country_picker_text_field.dart';
import 'package:wazafny/widgets/text_fields/regular_text_field.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/texts/heading_text.dart';
import 'fill_headline.dart';

class FillLocation extends StatefulWidget {
  const FillLocation({super.key});

  @override
  State<FillLocation> createState() => _FillLocationState();
}

class _FillLocationState extends State<FillLocation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isButtonEnabled = false;

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryController.addListener(_validateForm);
    _cityController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled =
          _countryController.text.isNotEmpty && _cityController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _countryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Welcome",
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(normalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              const HeadingText1(title: "What's your location ?"),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              CountryPickerTextField(
                controller: _countryController,
                labelText: "Country*",
                validator: Validators().requiredFieldValidator,
              ),
              const SizedBox(height: 20),
              RegularTextField(
                keyboardType: TextInputType.name,
                labelText: "City",
                validator: Validators().requiredFieldValidator,
                controller: _cityController,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    slideTo(context, const FillHeadline());
                  }
                },
                child: Opacity(
                    opacity: _isButtonEnabled ? 1.0 : 0.5,
                    child: const Button(text: "Next")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
