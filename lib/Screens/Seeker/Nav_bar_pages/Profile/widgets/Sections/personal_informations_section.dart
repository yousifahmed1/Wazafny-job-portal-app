import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/edit_cover_page.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/edit_information_page.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/Edit_pages/edit_profile_img.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/Screens/followings_page.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/Profile/cubit/profile_states.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/widgets/Navigators/slide_up.dart';
import 'package:wazafny/widgets/texts/heading_text.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class PersonalInformations extends StatelessWidget {
  const PersonalInformations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final seekerProfile = context.watch<ProfileCubit>().state;

    if (seekerProfile is ProfileLoaded) {
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            InkWell(
              onTap: () => slideUp(context, const EditCover()),
              child: Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: seekerProfile.profile.cover.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(seekerProfile.profile.cover),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage(
                              "assets/Images/profile-banner-default.png"),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 125),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture
                      InkWell(
                        onTap: () => slideUp(context, const EditProfileImg()),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                          child: ClipOval(
                            child: seekerProfile.profile.image.isNotEmpty
                                ? Image.network(
                                    seekerProfile.profile.image,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    "assets/Images/Profile-default-image.svg",
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          HeadingText(
                              title:
                                  "${seekerProfile.profile.firstName} ${seekerProfile.profile.lastName}"),
                          const SizedBox(width: 10),
                          const Spacer(),
                          InkWell(
                            onTap: () =>
                                slideUp(context, const EditInformation()),
                            child: SvgPicture.asset(
                              "assets/Icons/edit_icon.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => slideTo(
                            context,
                            FollowingsPage(
                              followings:
                                  seekerProfile.profile.followings ?? [],
                            )),
                        child: SubHeadingText(
                          title: "${seekerProfile.profile.following} following",
                          titleColor: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SubHeadingText1(
                        title: seekerProfile.profile.headline,
                        titleColor: darkerPrimary,
                      ),
                      const SizedBox(height: 10),
                      SubHeadingText1(
                        title:
                            "${seekerProfile.profile.city}, ${seekerProfile.profile.country}",
                      ),
                      const SizedBox(height: 10),
                      // Handle null or empty links
                      if (seekerProfile.profile.links.isNotEmpty)
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                final url = Uri.parse(
                                    seekerProfile.profile.links[0].link!);
                                final bool launched = await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                                if (!launched) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${seekerProfile.profile.links[0].link!}')),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Icons/Link.svg",
                                    width: 25,
                                    height: 25,
                                  ),
                                  SubHeadingText(
                                    title:
                                        "${seekerProfile.profile.links[0].name}",
                                    titleColor: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            seekerProfile.profile.links.length > 1
                                ? InkWell(
                                    onTap: () {
                                      linksModalBottomSheet(
                                          context, seekerProfile);
                                    },
                                    child: SubHeadingText(
                                      title:
                                          "and ${seekerProfile.profile.links.length - 1} more",
                                      titleColor: primaryColor,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (seekerProfile is ProfileLoading) {
      return const CircularProgressIndicator(); // Show loading
    } else if (seekerProfile is ProfileError) {
      return const Text('Failed to load profile');
    }
    return Container();
  }

  Future<dynamic> linksModalBottomSheet(
      BuildContext context, ProfileLoaded seekerProfile) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "All Links",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: seekerProfile.profile.links.length,
                  itemBuilder: (context, index) {
                    final link = seekerProfile.profile.links[index];
                    return GestureDetector(
                      onTap: () async {
                        final url = Uri.parse(link.link!);
                        final bool launched = await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                        if (!launched) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Could not launch ${link.link}')),
                          );
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/Icons/Link.svg",
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SubHeadingText(
                                title: link.name ?? 'No Name',
                                titleColor: darkerPrimary,
                                fontSize: 18,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
