import 'package:flutter/material.dart';

void main() {
  runApp(const JobPostingApp());
}

class JobPostingApp extends StatelessWidget {
  const JobPostingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const JobPostingScreen(),
    );
  }
}

class JobPostingScreen extends StatelessWidget {
  const JobPostingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Handle close button press
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Logo and Job Title
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red, // Placeholder for Vodafone logo
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "V",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Flutter Mobile App Developer",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Vodafone Egypt · Cairo, Egypt · 4 days ago",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Remote and Full-time Tags
                Row(
                  children: const [
                    Chip(
                      label: Text("REMOTE"),
                      backgroundColor: Colors.grey,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Chip(
                      label: Text("Full-time"),
                      backgroundColor: Colors.grey,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Skills Section
                const Text(
                  "Skills",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: const [
                    Chip(label: Text("Dart")),
                    Chip(label: Text("Kotlin")),
                    Chip(label: Text("Java")),
                    Chip(label: Text("Firebase")),
                  ],
                ),
                const SizedBox(height: 16),
                // About the Job Section
                const Text(
                  "About the job",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "We’re seeking an experienced Mobile Software Engineer with a passion for development and a team-oriented attitude, ready to bring powerful software to life.\n\n"
                      "As a Mobile Engineer at Blink22, your role will involve collaborating with various departments within the company to ensure the successful creation and implementation of innovative and streamlined mobile experiences. Additionally, you will actively contribute to enhancing our internal workflows and fostering a culture of excellence.\n\n"
                  // Adding more text to make the content long enough to scroll
                      "You will work closely with product managers, designers, and other engineers to deliver high-quality mobile applications. Your responsibilities will include writing clean, maintainable code, participating in code reviews, and staying up-to-date with the latest industry trends and technologies.\n\n"
                      "We value collaboration, creativity, and a proactive attitude. If you’re someone who thrives in a dynamic environment and loves solving complex problems, we’d love to hear from you!",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 80), // Extra space to avoid overlap with the fixed button
              ],
            ),
          ),
          // Fixed "Apply Now" button at the bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () {
                // Handle apply now button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Center(
                child: Text(
                  "Apply Now",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}