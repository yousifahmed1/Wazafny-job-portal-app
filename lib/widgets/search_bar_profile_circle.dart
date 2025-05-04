import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/Screens/welcome.dart';
//import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/text_fields/search_field.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

import '../core/constants/constants.dart';

class SearchBarProfileCircle extends StatelessWidget {
  const SearchBarProfileCircle({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search Bar
          Expanded(
            child: SizedBox(
              height: 60,
              child: SearchTextField(controller: _searchController),
            ),
          ),

          const SizedBox(width: 12),

          //Profile Circle
          InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              showModalBottomSheet(context: context, builder: (context) {
                return Container(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: InkWell(
                          onTap: ()  async {
                            final response = await AuthRepository().logoutService();
                            log(response.toString());
                            if (response){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WelcomePage()),
                              );
                            }else log("error logout");


                          },
                          child: Row(
                            children: [
                              HeadingText(title: "Logout"),
                              Spacer(),
                              Icon(Icons.logout_sharp,
                                size: 40,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },);
            },
            // onTap: () => slideTo(context, const LogoutPage()),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: darkPrimary,
              child: Text(
                "YA",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
