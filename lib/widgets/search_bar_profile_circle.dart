import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/login_and_signup/repo/auth_repository.dart';
import 'package:wazafny/Screens/welcome.dart';
import 'package:wazafny/widgets/text_fields/search_field.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';

class SearchBarProfileCircle extends StatelessWidget {
  const SearchBarProfileCircle({
    super.key,
    required TextEditingController searchController,
    this.onSearchChanged, // Add the onSearchChanged callback
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final ValueChanged<String>?
      onSearchChanged; // Add the onSearchChanged callback type

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
              child: SearchTextField(
                controller: _searchController,
                onChanged: onSearchChanged, // Pass the onSearchChanged callback
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Profile Circle
          InkWell(
            overlayColor: WidgetStateColor.transparent,
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: InkWell(
                              onTap: () async {
                                final response =
                                    await AuthRepository().logoutService();
                                log(response.toString());
                                if (response) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomePage()),
                                  );
                                } else {
                                  log("Error logging out");
                                }
                              },
                              child: const Row(
                                children: [
                                  HeadingText(title: "Logout"),
                                  Spacer(),
                                  Icon(
                                    Icons.logout_sharp,
                                    size: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: SvgPicture.asset(
              'assets/Icons/settings.svg',
              width: 50,
              height: 50,
            ),
            //const CircleAvatar(
            //   radius: 30,
            //   backgroundColor: darkerPrimary,
            //   child: Text(
            //     "YA",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w600,
            //       fontSize: 22,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
