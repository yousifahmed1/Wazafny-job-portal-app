
import 'package:flutter/material.dart';
import 'package:wazafny/widgets/settings.dart';
import 'package:wazafny/widgets/text_fields/search_field.dart';

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
          const SettingsIcon(),
        ],
      ),
    );
  }
}

