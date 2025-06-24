import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

import 'package:wazafny/Screens/login_and_signup/repo/password_reset_service.dart';
import 'reset_password.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.role, required this.email});
  final String role;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isButtonEnabled = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController otbController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otbController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled =
          otbController.text.isNotEmpty && otbController.text.length == 6;
    });
  }

  @override
  void dispose() {
    otbController.dispose();
    super.dispose();
  }

  String? get email => widget.email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // No need for extra logic, email is now always available from widget
  }

  Future<void> _verifyOtp() async {
    if (email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email not found. Please try again.')),
      );
      return;
    }
    final result = await PasswordResetService().verifyPasswordResetOtp(
      email: email!,
      otp: otbController.text.trim(),
    );
    if (result['statusCode'] == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassword(
            role: widget.role,
            email: email!,
            otp: otbController.text.trim(),
          ),
        ),
      );
    } else {
      final errorMsg = result['error'] ?? 'Invalid OTP. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = darkPrimary;
    const fillColor = Colors.white;
    const borderColor = linesColor;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 70,
      textStyle: const TextStyle(
        fontSize: 22,
        color: darkPrimary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor, width: 2),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: ForgetPasswordCustomAppBar(
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(normalPadding),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                const HeadingText1(title: "Email Sent"),
                const SizedBox(height: 20),
                const SubHeadingText(
                    title:
                        "If this email address was used to create an account, an OTP will be sent to you. Please check your email."),
                const SizedBox(height: 20),
                //OTB
                Center(
                  child: Pinput(
                    length: 6,
                    controller: otbController,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'OTP is required';
                      }
                      return null;
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: focusedBorderColor, width: 2),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: focusedBorderColor, width: 2),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _verifyOtp();
                    }
                  },
                  child: Opacity(
                      opacity: _isButtonEnabled ? 1.0 : 0.5,
                      child: const Button(text: "Submit")),
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't get OTP ?",
                      style: TextStyle(
                        color: darkPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Try Again",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
