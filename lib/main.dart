import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(MyPortfolioApp());

class MyPortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nadeem Ahmed Ansari | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
      ),
      home: PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  final List<Map<String, dynamic>> skills = [
    {"name": "Flutter", "icon": Icons.flutter_dash},
    {"name": "Python", "icon": Icons.code},
    {"name": "Machine Learning", "icon": Icons.memory},
    {"name": "Firebase", "icon": Icons.cloud},
    {"name": "SQL / NoSQL", "icon": Icons.storage},
    {"name": "Git / GitHub", "icon": Icons.merge_type},
    {"name": "REST APIs", "icon": Icons.api},
    {"name": "AWS", "icon": Icons.cloud_circle},
  ];

  final List<Map<String, String>> projects = [
    {
      "title": "Farm Expert",
      "description": "A smart ML model to recommend crops based on soil and climate data.",
      "url": "https://github.com/nadeemahmedansari/farm-expert"
    },
    {
      "title": "Notification App",
      "description": "A Flutter app with dynamic forms and radio-based UI rendering.",
      "url": "https://github.com/nadeemahmedansari/notification-app"
    },
    {
      "title": "Damage Assessment",
      "description": "CNN-based model for satellite image disaster classification.",
      "url": "https://github.com/nadeemahmedansari/damage-assessment"
    },
  ];

  final List<Map<String, String>> education = [
    {
      "degree": "B.Tech in Computer Science",
      "institution": "Pranveer Singh Institute of Technology, Kanpur",
      "year": "2022 - 2026",
      "details": "CGPA: 8.53 | 81.42% | Strong foundation in software engineering & ML"
    },
    {
      "degree": "Class 12th (CBSE)",
      "institution": "Gyan Peethika School",
      "year": "2022",
      "details": "Scored 86.67%"
    },
    {
      "degree": "Class 10th (CBSE)",
      "institution": "Gyan Kunj Academy",
      "year": "2020",
      "details": "Scored 83%"
    },
  ];

  final List<String> achievements = [
    "AIR 247 in Innovate India Coding Championship by AICTE (out of 1 lakh+)",
    "Built ML project for vehicle classification using AWS SageMaker & Lambda",
    "Completed AWS Machine Learning Nanodegree & AI Programming with Python",
    "Inter-college Basketball Champion",
    "Working at Digichorus as Flutter Developer",
    "Former Salesforce Developer Intern at SmartInternz",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Center(
              child: Column(
              children: [
                  Lottie.asset('assets/dev.json', height: 220),
              SizedBox(height: 20),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Hi, I am Nadeem Ahmed Ansari'),
                    TyperAnimatedText('Flutter Developer'),
                    TyperAnimatedText('Machine Learning Enthusiast'),
                    TyperAnimatedText('Problem Solver | Software Engineer'),
                  ],
                  repeatForever: true,
                ),
              ),
              ],
            ),
          ),
            SizedBox(height: 30),
            sectionTitle("About Me"),
            sectionText("I’m a Software Engineer skilled in Flutter, Machine Learning, and Python. I enjoy solving real-world problems and building responsive mobile applications."),

            SizedBox(height: 30),
            sectionTitle("Skills"),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: skills
                  .map((skill) => Chip(
                avatar: Icon(skill['icon'], color: Colors.white),
                label: Text(skill['name']),
                backgroundColor: Colors.teal,
              ))
                  .toList(),
            ),

            SizedBox(height: 30),
            sectionTitle("Projects"),
            ...projects.map((p) => projectCard(p)).toList(),

            SizedBox(height: 30),
            sectionTitle("Education"),
            ...education.map((e) => educationCard(e)).toList(),

            SizedBox(height: 30),
            sectionTitle("Achievements"),
            ...achievements.map((a) => ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text(a),
            )),

            SizedBox(height: 30),
            sectionTitle("Contact Me"),
            sectionText("Email: nadeem.dev.connect@gmail.com\nLinkedIn: linkedin.com/in/nadeemahmedansari\nGitHub: github.com/nadeemahmedansari"),
            SizedBox(height: 30),
            Center(child: Text("Built with ❤️ using Flutter & Dart"))
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) => Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold));
  Widget sectionText(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(text, style: TextStyle(fontSize: 16)),
  );
  Widget projectCard(Map<String, String> project) => Card(
    color: Colors.grey[900],
    margin: EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      title: Text(project['title']!),
      subtitle: Text(project['description']!),
      trailing: IconButton(
        icon: Icon(Icons.open_in_new, color: Colors.blueAccent),
        onPressed: () => launchUrl(Uri.parse(project['url']!)),
      ),
    ),
  );
  Widget educationCard(Map<String, String> edu) => Card(
    color: Colors.grey[850],
    margin: EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      title: Text(edu['degree']!),
      subtitle: Text("${edu['institution']}\n${edu['year']}\n${edu['details']}"),
      isThreeLine: true,
    ),
  );
}
