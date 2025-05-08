import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/cubit/cubit/company_view_cubit.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/cubit/cubit/company_view_state.dart';
import 'package:wazafny/Screens/Seeker/Nav_bar_pages/home/company/Screens/company_view.dart';
import 'package:wazafny/widgets/Navigators/slide_to.dart';
import 'package:wazafny/core/constants/constants.dart';

class CompaniesListView extends StatefulWidget {
  final String searchQuery;

  const CompaniesListView({
    super.key,
    this.searchQuery = '',
  });

  @override
  State<CompaniesListView> createState() => _CompaniesListViewState();
}

class _CompaniesListViewState extends State<CompaniesListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyViewCubit, CompanyState>(
      builder: (context, state) {
        if (state is CompanyInitial) {
          // Automatically fetch companies when screen loads
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<CompanyViewCubit>().fetchCompany();
          });
          return const Center(child: Text('Loading companies...'));
        }
        if (state is CompanyLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CompanyError) {
          return Center(child: Text(state.error));
        }
        if (state is CompanyLoaded) {
          // Filter companies based on search query
          final filteredCompanies = widget.searchQuery.isEmpty
              ? state.companies
              : state.companies.where((company) {
                  final searchLower = widget.searchQuery.toLowerCase();
                  return company.companyName
                          .toLowerCase()
                          .contains(searchLower) ||
                      (company.companyCity ?? '')
                          .toLowerCase()
                          .contains(searchLower) ||
                      (company.companyCountry ?? '')
                          .toLowerCase()
                          .contains(searchLower) ||
                      (company.about ?? '').toLowerCase().contains(searchLower);
                }).toList();

          if (filteredCompanies.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CompanyViewCubit>().fetchCompany();
              },
              child: Center(
                child: ListView(
                  padding: const EdgeInsets.only(
                    bottom: 105,
                  ),
                  children: const [
                    SizedBox(height: 60),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No companies found ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<CompanyViewCubit>().fetchCompany();
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 105), // navbar height
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredCompanies.length,
              itemBuilder: (context, index) {
                final company = filteredCompanies[index];
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
                                      color: darkerPrimary,
                                    ),
                                  ),
                                  Text(
                                    "${company.companyCity ?? ""}, ${company.companyCountry ?? ""}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: darkerPrimary,
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
                                      color: darkerPrimary,
                                    ),
                                  ),
                                  const Text(
                                    "Followers",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
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
                                      color: darkerPrimary,
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
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: darkerPrimary,
                            ),
                          ),
                          Text(
                            company.about ?? "",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: darkerPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox(); // Empty fallback
      },
    );
  }
}
