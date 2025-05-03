import 'package:flutter/material.dart';
import 'package:wazafny/widgets/search_bar_profile_circle.dart';
import 'package:wazafny/constants.dart';
import 'company/companies_list_view.dart';
import 'job_posts/widgets/jobs_list_view.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Column(
            children: [
              // Search Bar & Profile Circle
              SearchBarProfileCircle(searchController: _searchController),
              const SizedBox(height: 15),
              // TabBar

              // TabBar
              Container(
                height: 60,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  overlayColor: WidgetStateColor.transparent,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  enableFeedback: false,
                  dividerColor: Colors.transparent,
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      child: Center(
                        child: Text(
                          'Jobs',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Company',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // TabBar
              // TabBarView
              const Expanded(
                child: TabBarView(
                  physics:  BouncingScrollPhysics(),
                  children: [
                    JobsListView(),
                    // Company Tab Content
                     CompaniesListView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
