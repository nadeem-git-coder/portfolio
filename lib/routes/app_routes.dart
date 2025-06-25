import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/views/home/home_screen.dart';
import 'package:portfolio/views/splash/splash_screen.dart'; // Add this import

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash', // Start with splash screen
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        // Optional redirect to ensure splash is shown first
        // redirect: (context, state) => state.uri.path == '/' ? '/splash' : null,
      ),
    ],
  );
});