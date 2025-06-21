import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  static const List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'rating': 4.5},
    {'name': 'Dart', 'rating': 4.0},
    {'name': 'Python', 'rating': 4.5},
    {'name': 'Scikit-learn', 'rating': 3.5},
    {'name': 'Firebase', 'rating': 4.0},
    {'name': 'AWS', 'rating': 3.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skills')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Skills',
              style: Theme.of(context).textTheme.headlineMedium,
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 16),
            ...skills.asMap().entries.map((entry) {
              final skill = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(skill['name'], style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: skill['rating'] / 5.0,
                      backgroundColor: Colors.grey[300],
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms, delay: (entry.key * 200).ms),
              );
            }),
          ],
        ),
      ),
    );
  }
}