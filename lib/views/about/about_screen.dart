import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/widgets/social_links.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Me')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'About Me',
              style: Theme.of(context).textTheme.headlineMedium,
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 16),
            Text(
              'I am a passionate Flutter developer with expertise in building cross-platform apps. My journey includes working with Python, Machine Learning, and cloud technologies like AWS. I love creating intuitive and performant applications.',
              style: Theme.of(context).textTheme.bodyLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
            const SizedBox(height: 24),
            Text(
              'Tech Stack',
              style: Theme.of(context).textTheme.titleLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: const [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('Python')),
                Chip(label: Text('Scikit-learn')),
                Chip(label: Text('Firebase')),
                Chip(label: Text('AWS')),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
            const SizedBox(height: 24),
            const SocialLinks(),
          ],
        ),
      ),
    );
  }
}