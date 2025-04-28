import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/company/services/company_services.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/company/Screens/company_view.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/home_page/company/model/company_model.dart'; // Import your model

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({super.key});

  @override
  State<CompaniesListView> createState() => _CompaniesListViewState();
}

class _CompaniesListViewState extends State<CompaniesListView> {
  late Future<List<CompanyModel>> future; // Make it typed properly

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  // Create an async function to load companies
  Future<void> _loadCompanies() async {
    future = CompanyServices().fetchCompanies();
    setState(() {}); // Trigger a rebuild after data is loaded
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompanyModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error
        } else if (snapshot.hasData) {
          final companies = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 105), // navbar height
            physics: const BouncingScrollPhysics(),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return InkWell(
                onTap: () => slideTo(
                    context,
                    CompanyView(
                      companyID: company.companyId,
                    )),
                overlayColor: WidgetStateColor.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: company.profileImg != null &&
                                      company.profileImg != ""
                                  ? Image.network(
                                      company.profileImg!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    )
                                  : SvgPicture.asset(
                                      "assets/Images/Profile-default-image.svg",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  company.companyName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${company.companyCity ?? ""}, ${company.companyCountry ?? ""}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  "${company.followersCount}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  "Followers",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  "${company.jobsCount}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  "Jobs",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          company.about ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No companies found.'));
        }
      },
    );
  
  }
}
