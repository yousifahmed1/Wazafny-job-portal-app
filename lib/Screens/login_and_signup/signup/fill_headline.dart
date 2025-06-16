import 'package:flutter/material.dart';
import 'package:wazafny/Screens/login_and_signup/signup/fill_location.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/text_fields/regular_text_field.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/texts/heading_text.dart';
import 'services/signup_service.dart';

class FillHeadline extends StatefulWidget {
  const FillHeadline({super.key});

  @override
  State<FillHeadline> createState() => _FillHeadlineState();
}

class _FillHeadlineState extends State<FillHeadline> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignupService _signupService = SignupService();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  final TextEditingController _headlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _headlineController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _headlineController.text.isNotEmpty;
    });
  }

  Future<void> _updateHeadline() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _signupService.updateHeadline(
        headline: _headlineController.text,
      );

      if (mounted) {
        slideTo(context, const FillLocation());
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update headline: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _headlineController.dispose();
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
              const HeadingText1(title: "Tell us more about you"),
              const SizedBox(height: 20),
              RegularTextField(
                keyboardType: TextInputType.name,
                labelText: "Headline",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Headline is required';
                  }
                  return null;
                },
                controller: _headlineController,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _isButtonEnabled && !_isLoading ? _updateHeadline : null,
                child: Opacity(
                  opacity: _isButtonEnabled ? 1.0 : 0.5,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Button(text: "Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
