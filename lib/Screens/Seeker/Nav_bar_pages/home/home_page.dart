import 'package:flutter/material.dart';
import 'package:wazafny/widgets/search_bar_profile_circle.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'company/companies_list_view.dart';
import 'job_posts/jobs_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Add listener to update search query when text changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Column(
            children: [
              // Search Bar & Profile Circle with callback
              SearchBarProfileCircle(
                searchController: _searchController,
                onSearchChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
              const SizedBox(height: 15),

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
              
              // TabBarView with search query passed to list views
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    JobsListView(searchQuery: _searchQuery),
                    CompaniesListView(searchQuery: _searchQuery),
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