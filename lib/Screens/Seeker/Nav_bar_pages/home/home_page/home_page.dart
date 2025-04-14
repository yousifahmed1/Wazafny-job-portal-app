import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';

import 'companies_list_view.dart';
import 'jobs_list_view.dart';
import '../../../../../widgets/text_fields/search_field.dart'; // Assuming primaryColor is defined here

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Search Bar & Profile Circle
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Search Bar
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: SearchTextField(controller: _searchController),
                          ),
                        ),

                        const SizedBox(width: 12),

                        //Profile Circle
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: darkPrimary,
                          child: Text(
                            "YA",
                            style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w600,
                              fontSize: 22
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
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
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
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

                  ],
                ),
              ),

              // TabBarView
              const Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children:  [
                    // Jobs Tab Content
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

