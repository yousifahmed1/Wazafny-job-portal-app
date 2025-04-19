import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/profile_states.dart';

class EditCover extends StatelessWidget {
  const EditCover({super.key});

  @override
  Widget build(BuildContext context) {
    final seekerProfile = context.watch<ProfileCubit>().state;

    if (seekerProfile is ProfileLoaded) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar1(
          title: "Cover Photo",
          onBackPressed: () => Navigator.pop(context),
        ),
        body: Column(
          children: [Text(seekerProfile.profile.firstName)],
        ),
      );
    } else if (seekerProfile is ProfileLoading) {
      return const CircularProgressIndicator(); // Show loading
    } else if (seekerProfile is ProfileError) {
      return const Text('Failed to load profile');
    }
    return Container();
  }
}
