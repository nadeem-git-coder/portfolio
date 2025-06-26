import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/core/theme/theme_provider.dart';
import 'package:portfolio/widgets/animated_button.dart';
import 'package:portfolio/widgets/social_links.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/widgets/project_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Global keys for scrolling to sections
    final homeKey = GlobalKey();
    final aboutKey = GlobalKey();
    final projectsKey = GlobalKey();
    final skillsKey = GlobalKey();
    final contactKey = GlobalKey();

    // Function to scroll to a section
    void scrollToSection(GlobalKey key) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
        );
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // Dynamic holographic background
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.blue.shade900.withOpacity(0.8),
                  Colors.purple.shade900.withOpacity(0.6),
                  Colors.black.withOpacity(0.9),
                ],
                center: Alignment.center,
                radius: 1.2,
              ),
            ),
          ).animate().fadeIn(duration: 1200.ms),
          // Animated particle effects for futuristic ambiance
          Positioned.fill(
            child: Stack(
              children: List.generate(15, (index) {
                return Positioned(
                  left: (index * 150) % size.width,
                  top: (index * 250) % size.height,
                  child: Container(
                    width: 10 + (index % 5).toDouble(),
                    height: 10 + (index % 5).toDouble(),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyan.withOpacity(0.3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ).animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  ).moveY(
                    begin: -30,
                    end: 30,
                    duration: (1500 + index * 300).ms,
                    curve: Curves.easeInOutSine,
                  ).fade(
                    begin: 0.3,
                    end: 0.8,
                    duration: (1500 + index * 300).ms,
                  ),
                );
              }),
            ),
          ),
          // Main content
          Column(
            children: [
              // Top navigation bar with neon glow
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.shade200.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Portfolio',
                      style: textTheme.titleLarge!.copyWith(
                        color: Colors.cyan.shade300,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Orbitron',
                        letterSpacing: 2,
                      ),
                    ).animate().fadeIn(duration: 800.ms).scaleXY(
                      begin: 0.8,
                      end: 1.0,
                      duration: 800.ms,
                      curve: Curves.easeOutExpo,
                    ),
                    isMobile
                        ? PopupMenuButton<String>(
                      icon: Icon(Icons.menu, color: Colors.cyan.shade200),
                      color: Colors.black87,
                      onSelected: (value) {
                        if (value == 'home') scrollToSection(homeKey);
                        if (value == 'about') scrollToSection(aboutKey);
                        if (value == 'projects') scrollToSection(projectsKey);
                        if (value == 'skills') scrollToSection(skillsKey);
                        if (value == 'contact') scrollToSection(contactKey);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'home',
                          child: Text('Home', style: TextStyle(color: Colors.cyan.shade200)),
                        ),
                        PopupMenuItem(
                          value: 'about',
                          child: Text('About', style: TextStyle(color: Colors.cyan.shade200)),
                        ),
                        PopupMenuItem(
                          value: 'projects',
                          child: Text('Projects', style: TextStyle(color: Colors.cyan.shade200)),
                        ),
                        PopupMenuItem(
                          value: 'skills',
                          child: Text('Skills', style: TextStyle(color: Colors.cyan.shade200)),
                        ),
                        PopupMenuItem(
                          value: 'contact',
                          child: Text('Contact', style: TextStyle(color: Colors.cyan.shade200)),
                        ),
                      ],
                    ).animate().fadeIn(duration: 800.ms, delay: 200.ms)
                        : Row(
                      children: [
                        _NavButton(
                          text: 'Home',
                          onPressed: () => scrollToSection(homeKey),
                          colorScheme: colorScheme,
                        ),
                        _NavButton(
                          text: 'About',
                          onPressed: () => scrollToSection(aboutKey),
                          colorScheme: colorScheme,
                        ),
                        _NavButton(
                          text: 'Projects',
                          onPressed: () => scrollToSection(projectsKey),
                          colorScheme: colorScheme,
                        ),
                        _NavButton(
                          text: 'Skills',
                          onPressed: () => scrollToSection(skillsKey),
                          colorScheme: colorScheme,
                        ),
                        _NavButton(
                          text: 'Contact',
                          onPressed: () => scrollToSection(contactKey),
                          colorScheme: colorScheme,
                        ),
                      ],
                    ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
                  ],
                ),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Home section with holographic profile
                      Container(
                        key: homeKey,
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Holographic profile animation
                            Container(
                              width: isMobile ? 180 : 250,
                              height: isMobile ? 180 : 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.cyan.shade200.withOpacity(0.4),
                                    Colors.transparent,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyan.shade300.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Lottie.asset(
                                    'assets/dev.json', // Replace with a futuristic hologram Lottie
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: isMobile ? 120 : 160,
                                    height: isMobile ? 120 : 160,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.cyan.shade200.withOpacity(0.5),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().scaleXY(
                              begin: 0.5,
                              end: 1.0,
                              duration: 1000.ms,
                              curve: Curves.easeOutBack,
                            ).fadeIn(duration: 1200.ms),
                            SizedBox(height: isMobile ? 24 : 40),
                            // Name with neon glow
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [Colors.cyan.shade300, Colors.purple.shade300],
                              ).createShader(bounds),
                              child: Text(
                                'Nadeem Ahmed Ansari',
                                style: textTheme.displaySmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Orbitron',
                                  letterSpacing: 2,
                                  shadows: [
                                    Shadow(
                                      color: Colors.cyan.shade300.withOpacity(0.5),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                                .fadeIn(duration: 1200.ms, delay: 200.ms)
                                .scaleXY(
                              begin: 0.9,
                              end: 1.1,
                              duration: 3000.ms,
                              curve: Curves.easeInOutSine,
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            // Role with dynamic color shift
                            Text(
                              'Software Engineer | Flutter Developer | ML Enthusiast',
                              style: textTheme.titleLarge!.copyWith(
                                color: Colors.cyan.shade100.withOpacity(0.8),
                                fontFamily: 'Orbitron',
                                fontSize: isMobile ? 14 : 18,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ).animate(onPlay: (controller) => controller.repeat())
                                .fadeIn(duration: 1200.ms, delay: 400.ms)
                                .custom(
                              duration: 4000.ms,
                              builder: (context, value, child) {
                                return DefaultTextStyle(
                                  style: textTheme.titleLarge!.copyWith(
                                    color: Color.lerp(
                                      Colors.cyan.shade100.withOpacity(0.8),
                                      Colors.purple.shade200.withOpacity(0.8),
                                      value,
                                    ),
                                    fontFamily: 'Orbitron',
                                    fontSize: isMobile ? 14 : 18,
                                    letterSpacing: 1.5,
                                  ),
                                  child: child,
                                );
                              },
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            // Tagline with holographic shimmer
                            Text(
                              '"Building the future, one pixel at a time."',
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Orbitron',
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                                .fadeIn(duration: 1200.ms, delay: 600.ms)
                                .shimmer(
                              color: Colors.cyan.shade200.withOpacity(0.5),
                              duration: 3000.ms,
                            )
                                .moveY(
                              begin: -10,
                              end: 10,
                              duration: 2000.ms,
                              curve: Curves.easeInOutSine,
                            ),
                            SizedBox(height: isMobile ? 32 : 48),
                            // Call-to-action buttons with neon hover
                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              alignment: WrapAlignment.center,
                              children: [
                                AnimatedButton(
                                  text: 'View Projects',
                                  onPressed: () => scrollToSection(projectsKey),
                                  color: Colors.cyan.shade400,
                                ),
                                AnimatedButton(
                                  text: 'Contact Me',
                                  onPressed: () => scrollToSection(contactKey),
                                  color: Colors.purple.shade400,
                                ),
                                AnimatedButton(
                                  text: 'Download Resume',
                                  onPressed: () {
                                    // TODO: Implement resume download
                                  },
                                  color: Colors.blue.shade400,
                                ),
                              ],
                            ).animate().fadeIn(duration: 1200.ms, delay: 800.ms).slideY(
                              begin: 0.3,
                              end: 0.0,
                              curve: Curves.easeOutCubic,
                            ),
                          ],
                        ),
                      ),
                      // About section with parallax effect
                      Container(
                        key: aboutKey,
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Colors.cyan.shade200.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Me',
                              style: textTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
                                fontFamily: 'Orbitron',
                                letterSpacing: 1.5,
                              ),
                            ).animate().fadeIn(duration: 800.ms).slideX(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'I’m a passionate Flutter developer crafting seamless cross-platform apps with a flair for innovation. My expertise spans Python, Machine Learning, and cloud technologies like AWS. I thrive on building intuitive, high-performance applications that push boundaries.',
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.white70,
                                fontFamily: 'Orbitron',
                              ),
                            ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
                            SizedBox(height: 24),
                            Text(
                              'Tech Stack',
                              style: textTheme.titleLarge!.copyWith(
                                color: Colors.cyan.shade200,
                                fontFamily: 'Orbitron',
                              ),
                            ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
                            SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: const [
                                Chip(
                                  label: Text('Flutter', style: TextStyle(fontFamily: 'Orbitron')),
                                  backgroundColor: Colors.cyanAccent,
                                  labelStyle: TextStyle(color: Colors.black87),
                                ),
                                Chip(
                                  label: Text('Dart', style: TextStyle(fontFamily: 'Orbitron')),
                                  backgroundColor: Colors.cyanAccent,
                                  labelStyle: TextStyle(color: Colors.black87),
                                ),
                                Chip(
                                  label: Text('Python', style: TextStyle(fontFamily: 'Orbitron')),
                                  backgroundColor: Colors.cyanAccent,
                                  labelStyle: TextStyle(color: Colors.black87),
                                ),
                                Chip(
                                  label: Text('Scikit-learn', style: TextStyle(fontFamily: 'Orbitron')),
                                  backgroundColor: Colors.cyanAccent,
                                  labelStyle: TextStyle(color: Colors.black87),
                                ),
                                Chip(
                                  label: Text('Firebase', style: TextStyle(fontFamily: 'Orbitron')),
                                  backgroundColor: Colors.cyanAccent,
                                  labelStyle: TextStyle(color: Colors.black87),
                                ),
                                Chip(
                                  label: Text('AWS', style: TextStyle(fontFamily: 'Orbitron')),
                                  backgroundColor: Colors.cyanAccent,
                                  labelStyle: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
                          ],
                        ),
                      ),
                      // Projects section with holographic cards
                      Container(
                        key: projectsKey,
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Projects',
                              style: textTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
                                fontFamily: 'Orbitron',
                                letterSpacing: 1.5,
                              ),
                            ).animate().fadeIn(duration: 800.ms).slideX(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: isMobile ? 14 : 16),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: isMobile?SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isMobile ? 1 : 2, // 1 column for mobile, 2 for larger screens
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: isMobile ? 1.2 : 0.75, // Adjusted aspect ratio for mobile
                              ):SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: isMobile ? 300 : 400,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: _projects.length,
                              itemBuilder: (context, index) {
                                return ProjectCard(project: _projects[index]).animate().fadeIn(
                                  duration: 800.ms,
                                  delay: (index * 200).ms,
                                ).scaleXY(
                                  begin: 0.8,
                                  end: 1.0,
                                  curve: Curves.easeOutCubic,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Skills section with progress bars
                      Container(
                        key: skillsKey,
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Colors.cyan.shade200.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Skills',
                              style: textTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
                                fontFamily: 'Orbitron',
                                letterSpacing: 1.5,
                              ),
                            ).animate().fadeIn(duration: 800.ms).slideX(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: 16),
                            ..._skills.asMap().entries.map((entry) {
                              final skill = entry.value;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      skill['name'],
                                      style: textTheme.titleMedium!.copyWith(
                                        color: Colors.cyan.shade100,
                                        fontFamily: 'Orbitron',
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: skill['rating'] / 5.0,
                                      backgroundColor: Colors.black45,
                                      color: Colors.cyan.shade300,
                                      minHeight: 8,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                ).animate().fadeIn(
                                  duration: 800.ms,
                                  delay: (entry.key * 200).ms,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      // Contact section
                      Container(
                        key: contactKey,
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Get in Touch',
                              style: textTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
                                fontFamily: 'Orbitron',
                                letterSpacing: 1.5,
                              ),
                            ).animate().fadeIn(duration: 800.ms).slideX(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Let’s connect! Reach out via email or find me on social media to discuss projects or opportunities.',
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.white70,
                                fontFamily: 'Orbitron',
                              ),
                            ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
                            SizedBox(height: 24),
                            const SocialLinks().animate().fadeIn(
                              duration: 800.ms,
                              delay: 400.ms,
                            ).scaleXY(
                              begin: 0.8,
                              end: 1.0,
                              curve: Curves.easeOutCubic,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Theme toggle with futuristic button
          Positioned(
            top: 80,
            right: 20,
            child: GestureDetector(
              onTap: () {
                ref.read(themeModeProvider.notifier).state =
                ref.read(themeModeProvider) == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.7),
                  border: Border.all(color: Colors.cyan.shade200, width: 1.5),
                ),
                child: Icon(
                  ref.watch(themeModeProvider) == ThemeMode.light
                      ? Icons.brightness_high
                      : Icons.brightness_low,
                  color: Colors.cyan.shade200,
                  size: 24,
                ),
              ),
            ).animate().fadeIn(duration: 1000.ms).scaleXY(
              begin: 0.5,
              end: 1.0,
              curve: Curves.easeOutBack,
            ),
          ),
        ],
      ),
    );
  }

  // Project data
  // Project data
  static const List<ProjectModel> _projects = [
    ProjectModel(
      title: 'Crop Prediction | Farm Expert',
      description:
      'A machine learning web app facilitating accurate prediction of optimal crop selection with a precision rate of 90%. The system employs predictive analytics by analyzing variables such as rainfall, temperature, nitrogen, and phosphorous levels to forecast crop outcomes.',
      tags: ['NumPy', 'Data Analysis', 'Pandas', 'Flask', 'Data Visualization'],
      githubLink: 'https://github.com/nadeem-git-coder/Crop-Prediction',
      demoLink: 'https://crop-prediction-fha3.onrender.com/',
    ),
    ProjectModel(
      title: 'Flower Species Image Classifier',
      description:
      'A personalized image classifier to identify different flower species. Built a robust neural network using PyTorch with a command-line interface for seamless usage, leveraging NumPy, Pandas, and Matplotlib for data manipulation and visualization.',
      tags: ['PyTorch', 'Data Visualization', 'Neural Networks', 'Computer Vision'],
      githubLink: 'https://github.com/nadeem-git-coder/AI-Programming-with-Python-Udacity-Nandegree',
    ),
    ProjectModel(
      title: 'Dog Breed Image Classifier',
      description:
      'An image classification project using convolutional neural networks (CNNs) like AlexNet, VGG, and ResNet to identify dog breeds. Trained on ImageNet, the classifier processes and predicts image content with high accuracy.',
      tags: ['Convolutional Neural Networks (CNN)', 'Data Visualization', 'Computer Vision'],
      githubLink: 'https://github.com/nadeem-git-coder/AI-Programming-with-Python-Udacity-Nandegree',
    ),
    ProjectModel(
      title: 'Bike Sharing Demand Prediction',
      description:
      'Utilized AutoGluon on AWS SageMaker to predict bike-sharing demand, achieving a Kaggle score of 0.59830. Conducted exploratory data analysis and feature engineering to uncover patterns and optimize model performance.',
      tags: ['AutoGluon', 'Feature Engineering', 'Data Visualization', 'EDA', 'AWS SageMaker', 'Hyperparameter Tuning'],
      githubLink: 'https://github.com/nadeem-git-coder/bike-sharing-demand-',
    ),
  ];

  // Skills data
  static const List<Map<String, dynamic>> _skills = [
    {'name': 'Flutter', 'rating': 4.5},
    {'name': 'Dart', 'rating': 4.0},
    {'name': 'Python', 'rating': 4.5},
    {'name': 'Scikit-learn', 'rating': 3.5},
    {'name': 'Firebase', 'rating': 4.0},
    {'name': 'AWS', 'rating': 3.5},
  ];
}

// Custom navigation button with neon hover effect
class _NavButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ColorScheme colorScheme;

  const _NavButton({
    required this.text,
    required this.onPressed,
    required this.colorScheme,
  });

  @override
  _NavButtonState createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(
              color: _isHovered ? Colors.cyan.shade200 : Colors.transparent,
              width: 2,
            )),
          ),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: _isHovered ? Colors.cyan.shade200 : Colors.cyan.shade100,
              fontFamily: 'Orbitron',
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}