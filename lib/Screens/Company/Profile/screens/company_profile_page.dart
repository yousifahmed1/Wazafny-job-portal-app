import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/Profile/cubits/company_profile_cubit.dart';
import 'package:wazafny/Screens/Company/Profile/widgets/extra_informations_section.dart';
import 'package:wazafny/Screens/Company/Profile/widgets/main_infrormations_section.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({
    super.key,
  });
  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  late bool isFollwed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
        builder: (context, state) {
          if (state is CompanyProfileInitial) {
            context.read<CompanyProfileCubit>().fetchCompanyProfile();

            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is CompanyProfileLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CompanyProfileCubit>().fetchCompanyProfile();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MainInformaition(company: state.company),
                    ExrtraInformation(company: state.company)
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
