import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/nav_bar.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/text_fields/regular_text_field.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/texts/heading_text.dart';

class FillHeadline extends StatefulWidget {
  const FillHeadline({super.key});

  @override
  State<FillHeadline> createState() => _FillHeadlineState();
}

class _FillHeadlineState extends State<FillHeadline> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isButtonEnabled = false;

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
                    return 'City is required';
                  }
                  return null;
                },
                controller: _headlineController,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    slideTo(context, const NavBar());
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
