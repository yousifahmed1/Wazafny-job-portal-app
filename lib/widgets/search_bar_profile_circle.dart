import 'package:flutter/material.dart';
//import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/text_fields/search_field.dart';

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

          // const SizedBox(width: 12),

          // //Profile Circle
          // const CircleAvatar(
          //   radius: 30,
          //   backgroundColor: darkPrimary,
          //   child: Text(
          //     "YA",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 22),
          //   ),
          // ),
        ],
      ),
    );
  }
}
