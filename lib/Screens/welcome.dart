import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';

import '../widgets/button.dart';
import 'login_and_signup/login/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            // const Spacer(),
            // Image.asset(
            //   "assets/Images/welcome.png",
            //   width: SizeConfig.screenWidth,
            //   fit: BoxFit.fill,
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.1,
                    ),
                    Image.asset(
                      "assets/Logo/logo2.png",
                      height: 400,
                      color: whiteColor,
                    ),
                    const Text(
                      "Find Your Dream Job or Hire the Best Talent",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: SizeConfig.screenHeight * (1 / 3),
              width: double.infinity,
              //height: SizeConfig.screenHeight*0.32,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: whiteColor,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  const Text(
                    "YOU ARE A",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            slideTo(context, const LoginPage(role: "Seeker"));
                          },
                          child: const Button(
                            text: "JOB SEEKER",
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            slideTo(
                                context,
                                const LoginPage(
                                  role: "Company",
                                ));
                          },
                          child: const Button(
                            text: "COMPANY",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
