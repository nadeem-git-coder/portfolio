import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/widgets/social_links.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch',
              style: Theme.of(context).textTheme.headlineMedium,
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 16),
            Text(
              'Feel free to reach out via email or connect with me on social media!',
              style: Theme.of(context).textTheme.bodyLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
            const SizedBox(height: 24),
            const SocialLinks().animate().fadeIn(duration: 600.ms, delay: 400.ms),
          ],
        ),
      ),
    );
  }
}