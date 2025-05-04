import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/regular_text_field.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import 'otp_screen.dart';

class ForgetEnterEmail extends StatefulWidget {
  const ForgetEnterEmail({super.key, required this.role});

  final String role;

  @override
  State<ForgetEnterEmail> createState() => _ForgetEnterEmailState();
}

class _ForgetEnterEmailState extends State<ForgetEnterEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isButtonEnabled = false;

  final TextEditingController _emailController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled =
          _emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ForgetPasswordCustomAppBar(
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(normalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              const HeadingText1(title: "Forgot Password ?"),
              const SizedBox(height: 20),
              const SubHeadingText(title: "Enter the email address you used when you joined and we’ll send you instructions to reset your password."),
              const SizedBox(height: 20),
              RegularTextField(
                keyboardType: TextInputType.emailAddress,
                labelText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                controller: _emailController ,
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtpScreen(role: widget.role,)),
                    );
                  }
                },
                child: Opacity(
                    opacity: _isButtonEnabled ? 1.0 : 0.5,
                    child: const Button(text: "Send OTP")),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


