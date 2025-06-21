import 'package:flutter/material.dart';
import 'package:wazafny/Screens/login_and_signup/login/login_page.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/password_text_filed.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/Screens/login_and_signup/repo/password_reset_service.dart';

class ResetPassword extends StatefulWidget {
  final String? email;
  final String? otp;
  const ResetPassword({super.key, required this.role, this.email, this.otp});
  final String role;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isButtonEnabled = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (widget.email == null || widget.otp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Missing email or OTP. Please try again.')),
      );
      return;
    }
    final result = await PasswordResetService().resetPassword(
      email: widget.email!,
      newPassword: _passwordController.text.trim(),
      otp: widget.otp!,
    );
    if (result['statusCode'] == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(role: widget.role)),
      );
    } else {
      final errorMsg =
          result['error'] ?? 'Failed to reset password. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                const HeadingText1(title: "Create New Password"),
                const SizedBox(height: 40),
                //OTB

                PasswordTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password is required';
                    if (value.length < 8)
                      return 'Password must be at least 8 characters';
                    if (!RegExp(r'[A-Z]').hasMatch(value))
                      return 'Password must contain at least one uppercase letter';
                    if (!RegExp(r'[a-z]').hasMatch(value))
                      return 'Password must contain at least one lowercase letter';
                    if (!RegExp(r'[0-9]').hasMatch(value))
                      return 'Password must contain at least one number';
                    if (!RegExp(r'[!@#\$&*~%^()\-_=+{};:,<.>?]')
                        .hasMatch(value))
                      return 'Password must contain at least one special character';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                PasswordTextField(
                  controller: _confirmPasswordController,
                  labelText: "Confirm Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _resetPassword();
                    }
                  },
                  child: Opacity(
                      opacity: _isButtonEnabled ? 1.0 : 0.5,
                      child: const Button(text: "Submit")),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
