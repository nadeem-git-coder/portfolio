import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/views/about/about_screen.dart';
import 'package:portfolio/views/contact/contact_screen.dart';
import 'package:portfolio/views/home/home_screen.dart';
import 'package:portfolio/views/projects/projects_screen.dart';
import 'package:portfolio/views/skills/skills_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
      GoRoute(path: '/projects', builder: (context, state) => const ProjectsScreen()),
      GoRoute(path: '/skills', builder: (context, state) => const SkillsScreen()),
      GoRoute(path: '/contact', builder: (context, state) => const ContactScreen()),
    ],
  );
});