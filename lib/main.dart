import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nadeem | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
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
    {"name": "ML", "icon": Icons.memory},
    {"name": "Firebase", "icon": Icons.cloud},
    {"name": "SQL", "icon": Icons.storage},
    {"name": "Git", "icon": Icons.merge_type},
  ];

  final List<Map<String, String>> projects = [
    {
      "title": "Farm Expert",
      "description": "ML-powered crop prediction system.",
      "url": "https://github.com/nadeemahmedansari/farm-expert"
    },
    {
      "title": "Notification App",
      "description": "Dynamic form with conditional rendering in Flutter.",
      "url": "https://github.com/nadeemahmedansari/notification-app"
    },
    {
      "title": "Damage Assessment",
      "description": "Satellite-based disaster assessment using CNN.",
      "url": "https://github.com/nadeemahmedansari/damage-assessment"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Lottie.asset('assets/dev.json', height: 200),
                    SizedBox(height: 20),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Hi, I am Nadeem Ahmed Ansari'),
                          TyperAnimatedText('Flutter Developer'),
                          TyperAnimatedText('ML Enthusiast'),
                          TyperAnimatedText('Software Engineer'),
                        ],
                        repeatForever: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text("About Me", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                "I’m a Software Engineer skilled in Flutter, Machine Learning, and Python. I enjoy solving real-world problems and building responsive mobile applications.",
              ),
              SizedBox(height: 30),
              Text("Skills", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: skills
                    .map(
                      (skill) => Chip(
                    avatar: Icon(skill['icon'], color: Colors.white),
                    label: Text(skill['name']),
                    backgroundColor: Colors.teal,
                  ),
                )
                    .toList(),
              ),
              SizedBox(height: 30),
              Text("Projects", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Column(
                children: projects
                    .map(
                      (project) => Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(project['title']!),
                      subtitle: Text(project['description']!),
                      trailing: IconButton(
                        icon: Icon(Icons.open_in_new, color: Colors.blueAccent),
                        onPressed: () => launchUrl(Uri.parse(project['url']!)),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
              SizedBox(height: 30),
              Text("Contact Me", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Email: nadeem.dev.connect@gmail.com"),
              Text("LinkedIn: linkedin.com/in/nadeemahmedansari"),
              Text("GitHub: github.com/nadeemahmedansari"),
              SizedBox(height: 50),
              Center(child: Text("Built with ❤️ in Flutter"))
            ],
          ),
        ),
      ),
    );
  }
}
