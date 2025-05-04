import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/model/profile_model.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/services/company_services.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/button.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/widgets/text_fields/search_field.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class FollowingsPage extends StatefulWidget {
  const FollowingsPage({super.key, required this.followings});
  final List<FollowingsModel> followings;

  @override
  State<FollowingsPage> createState() => _FollowingsPageState();
}

class _FollowingsPageState extends State<FollowingsPage> {
  final TextEditingController _searchController = TextEditingController();

  late List<bool> isFollowedList;
  late List followingsList; // for search filtering

  @override
  void initState() {
    super.initState();
    isFollowedList = List.generate(widget.followings.length, (index) => true);
    followingsList = List.from(widget.followings);

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      followingsList = widget.followings
          .where((company) =>
              company.companName!.toLowerCase().contains(searchText))
          .toList();
    });
  }

  Future<void> _followCompany(final int companyId) async {
    await CompanyServices().followCompany(companyId: companyId);
  }

  Future<void> _unfollowCompany(final int companyId) async {
    await CompanyServices().unfollowCompany(companyId: companyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar1(
          title: "Followings",
          onBackPressed: () {
            Navigator.pop(context);
            context.read<ProfileCubit>().fetchProfile();
          }),
      body: followingsList.isEmpty
          ? const Center(child: SubHeadingText(title: 'No followings'))
          : Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SearchTextField(controller: _searchController),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: followingsList.length,
                      itemBuilder: (context, index) {
                        final company = followingsList[index];
                        final originalIndex =
                            widget.followings.indexOf(company);

                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: company.profileImg != null &&
                                      company.profileImg!.isNotEmpty
                                  ? Image.network(
                                      company.profileImg!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill,
                                    )
                                  : SvgPicture.asset(
                                      "assets/Images/Profile-default-image.svg",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(width: 10),
                            SubHeadingText(
                              title: company.companName ?? "",
                              fontSize: 18,
                              titleColor: darkPrimary,
                            ),
                            const Spacer(),
                            isFollowedList[originalIndex] == false
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        isFollowedList[originalIndex] = true;
                                      });
                                      _followCompany(company.companyId!);
                                    },
                                    child: const Button1(
                                      text: "Follow",
                                      size: 18,
                                      btnColor: darkPrimary,
                                      width: 110,
                                      height: 50,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        isFollowedList[originalIndex] = false;
                                      });
                                      _unfollowCompany(company.companyId!);
                                    },
                                    child: const RoundedButton(
                                      text: "Following",
                                      size: 16,
                                      borderColor: darkPrimary,
                                      width: 110,
                                      height: 50,
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
