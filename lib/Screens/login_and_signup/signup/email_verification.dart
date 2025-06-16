import 'package:flutter/material.dart';
import 'package:wazafny/Screens/Company/nav_bar_company.dart';
import 'package:wazafny/Screens/login_and_signup/signup/fill_headline.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';
import '../repo/auth_repository.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage(
      {super.key, required this.email, required this.role});
  final String role;

  final String email;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _isLoading = false;

  Future<void> _checkEmailVerification() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await AuthRepository().checkEmailVerification();

      if (result == 1) {
        // Email is verified, proceed to fill headline
        if (mounted) {
          widget.role == 'seeker'
              ? slideTo(context, const FillHeadline())
              : slideTo(context, const NavBarCompany());
        }
      } else {
        // Email is not verified yet
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Email not verified yet. Please check your email and verify it.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking email verification: $e'),
            duration: const Duration(seconds: 3),
          ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const HeadingText1(title: "Verify Your Email"),
              const SizedBox(height: 20),
              SubHeadingText(
                title:
                    "We've sent a verification email to ${widget.email}. Please check your email and click the verification link to continue.",
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: _isLoading ? null : _checkEmailVerification,
                child: Opacity(
                  opacity: _isLoading ? 0.5 : 1.0,
                  child: Button(
                    text: _isLoading
                        ? "Checking..."
                        : "Check Verification Status",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SubHeadingText(
                title:
                    "After verifying your email, click the button above to continue.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
