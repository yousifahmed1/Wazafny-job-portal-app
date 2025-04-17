import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:wazafny/constants.dart';
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
            const  Spacer(),
            Image.asset(
              "assets/Images/welcome.png",
              width: SizeConfig.screenWidth,
              fit: BoxFit.fill,
            ),


            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child:
            //     Column(
            //       children: [
            //         SizedBox(
            //           height: SizeConfig.screenHeight * 0.2,
            //         ),
            //         // Image.asset(
            //         //   "assets/logo_white.png",
            //         // ),
            //         SvgPicture.asset(
            //           "assets/Images/logo_white.svg",
            //           height: 50,
            //         ),
            //         SizedBox(
            //           height: SizeConfig.screenHeight * 0.05,
            //         ),
            //         Text(
            //           "Find Your Dream Job or Hire the Best Talent",
            //           textAlign: TextAlign.center,
            //           softWrap: true,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 30,
            //             fontWeight: FontWeight.w700,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: SizeConfig.screenHeight *(1/3) ,
              width: double.infinity,
              //height: SizeConfig.screenHeight*0.32,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  const Text(
                    "YOU ARE A",
                    style: TextStyle(
                      color: loginTextColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            slideTo(context, const LoginPage(role: "Seeker"));
                          },
                          child: const Button(text: "JOB SEEKER"),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            slideTo(context, const LoginPage(role: "Company"));
                          },
                          child: const Button(text: "COMPANY"),
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
