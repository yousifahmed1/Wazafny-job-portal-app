import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Company/nav_bar_company.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/core/constants/textfields_validators.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/text_fields/password_text_filed.dart';
import 'package:wazafny/widgets/text_fields/regular_text_field.dart';

import '../../Seeker/Nav_bar_pages/nav_bar.dart';
import '../signup/sign_up.dart';
import 'forget_password/enter_email.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.role});
  final String role;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      bool loginSuccessful = await AuthRepository().login(
        _emailController.text,
        _passwordController.text,
        widget.role,
      );

      if (loginSuccessful) {
        widget.role == "Seeker"
            ? slideTo(context, const NavBarSeeker())
            : slideTo(context, const NavBarCompany());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: darkPrimary,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        widget.role,
                        style: const TextStyle(
                          color: darkPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RegularTextField(
                    labelText: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators().emailValidator,
                  ),
                  const SizedBox(height: 10),
                  PasswordTextField(
                    labelText: "Password",
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                      // slideTo(context, const NavBar());
                    },
                    child: Opacity(
                        opacity: _isButtonEnabled ? 1.0 : 0.5,
                        child: const Button(text: "LOGIN")),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () =>
                        slideTo(context, ForgetEnterEmail(role: widget.role)),
                    child: const Text(
                      "Forget your password ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New user ?",
                        style: TextStyle(
                          color: darkPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => slideTo(
                            context,
                            SignUpPage(
                              role: widget.role,
                            )),
                        child: const Text(
                          " Create Account",
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
      ),
    );
  }
}
