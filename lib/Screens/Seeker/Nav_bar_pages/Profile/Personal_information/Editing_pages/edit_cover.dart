import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazafny/models/profile_model.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';

class EditCover extends StatelessWidget {
  const EditCover({super.key});

  @override
  Widget build(BuildContext context) {
    final seekerProfile = context.read<SeekerProfileModel>();
    return Scaffold(
      appBar: CustomAppBar1(
        title: "Application Response",
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Column(
        children: [Text("${seekerProfile.headline}")],
      ),
    );
  }
}
