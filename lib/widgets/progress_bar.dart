import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.progress,
    required this.currentPage,
    required this.totalPages,
  });

  final double progress;
  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Container(color: Colors.white),
                  AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 350 * progress,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Page $currentPage of $totalPages',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}


