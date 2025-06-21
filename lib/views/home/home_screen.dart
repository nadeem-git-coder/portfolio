import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/core/theme/app_theme.dart';
import 'package:portfolio/core/theme/theme_provider.dart';
import 'package:portfolio/widgets/animated_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Dynamic gradient background based on theme
          Container(
            decoration: BoxDecoration(
              gradient: AppTheme.getBackgroundGradient(context),
            ),
          ).animate().fadeIn(duration: 1000.ms),
          // Animated particles effect
          Positioned.fill(
            child: Stack(
              children: List.generate(10, (index) {
                return Positioned(
                  left: (index * 100) % size.width,
                  top: (index * 200) % size.height,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.onSurface.withOpacity(0.2),
                    ),
                  ).animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  ).moveY(
                    begin: -20,
                    end: 20,
                    duration: (2000 + index * 200).ms,
                    curve: Curves.easeInOut,
                  ),
                );
              }),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile image with glowing effect
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Lottie.asset(
                          'assets/dev.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .scaleXY(
                    begin: 0.5,
                    end: 1.0,
                    duration: 800.ms,
                    curve: Curves.elasticOut,
                  )
                      .fadeIn(duration: 1000.ms),
                  const SizedBox(height: 32),
                  // Name with continuous pulsing and shadow animation
                  Text(
                    'Nadeem Ahmed Ansari',
                    style: textTheme.displaySmall!.copyWith(
                      color: colorScheme.tertiaryFixed,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .fadeIn(duration: 1200.ms, delay: 200.ms)
                      .slideY(begin: 0.2, end: 0.0, duration: 800.ms)
                      .scaleXY(
                    begin: 0.95,
                    end: 1.05,
                    duration: 2000.ms,
                    curve: Curves.easeInOutSine,
                  )
                      .custom(
                    duration: 2000.ms,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 2 * value),
                        child: child,
                      );
                    },
                  ),
                  // Role with continuous color cycling
                  Text(
                    'Software Engineer | Flutter Developer | ML Enthusiast',
                    style: textTheme.titleLarge!.copyWith(
                      color: colorScheme.tertiaryFixed.withOpacity(0.7),
                      fontSize: isMobile ? 16 : 20, // Responsive font size
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2, // Prevent overflow on small screens
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 1200.ms, delay: 400.ms)
                      .custom(
                    duration: 3000.ms,
                    builder: (context, value, child) {
                      final isDark = Theme.of(context).brightness == Brightness.dark;
                      return DefaultTextStyle(
                        style: textTheme.titleLarge!.copyWith(
                          color: Color.lerp(
                            colorScheme.tertiaryFixed.withOpacity(0.7),
                            isDark ? Colors.blue[300]! : Colors.purple[400]!,
                            value,
                          ),
                          fontSize: isMobile ? 16 : 20,
                        ),
                        child: child,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // Tagline with wave-like movement and shimmer
                  Text(
                    '"Building the future, one pixel at a time."',
                    style: textTheme.bodyLarge!.copyWith(
                      color: colorScheme.tertiaryFixed,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .fadeIn(duration: 1200.ms, delay: 600.ms)
                      .scaleXY(
                    begin: 0.8,
                    end: 1.0,
                    duration: 800.ms,
                    curve: Curves.bounceOut,
                  )
                      .custom(
                    duration: 2000.ms,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 5 * (value - 0.5)),
                        child: child,
                      );
                    },
                  )
                      .shimmer(
                    color: colorScheme.secondary.withOpacity(0.5),
                    duration: 2500.ms,
                  ),
                  const SizedBox(height: 48),
                  // Call-to-action buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      AnimatedButton(
                        text: 'View Projects',
                        onPressed: () => context.go('/projects'),
                      ),
                      AnimatedButton(
                        text: 'Contact Me',
                        onPressed: () => context.go('/contact'),
                      ),
                      AnimatedButton(
                        text: 'Download Resume',
                        onPressed: () {
                          // TODO: Implement resume download
                        },
                      ),
                    ],
                  ).animate().fadeIn(duration: 1200.ms, delay: 800.ms).slideY(
                    begin: 0.2,
                    end: 0.0,
                  ),
                ],
              ),
            ),
          ),
          // Theme toggle button
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: ref.watch(themeModeProvider) == ThemeMode.light
                  ? Icon(Icons.brightness_6, color: colorScheme.onSurface)
                  : Icon(Icons.brightness_4, color: colorScheme.onSurface),
              onPressed: () {
                ref.read(themeModeProvider.notifier).state =
                ref.read(themeModeProvider) == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ).animate().fadeIn(duration: 1000.ms),
          ),
        ],
      ),
    );
  }
}