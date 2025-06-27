import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/core/theme/theme_provider.dart';
import 'package:portfolio/widgets/animated_button.dart';
import 'package:portfolio/widgets/social_links.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 900;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Responsive text theme
    final responsiveTextTheme = textTheme.copyWith(
      displaySmall: textTheme.displaySmall!.copyWith(
        fontSize: isMobile ? 28 : isTablet ? 34 : 36,
      ),
      headlineMedium: textTheme.headlineMedium!.copyWith(
        fontSize: isMobile ? 22 : isTablet ? 26 : 28,
        fontFamily: 'Orbitron',
        letterSpacing: 1.5,
      ),
      titleLarge: textTheme.titleLarge!.copyWith(
        fontSize: isMobile ? 20 : isTablet ? 22 : 24,
        fontFamily: 'Orbitron',
      ),
      titleMedium: textTheme.titleMedium!.copyWith(
        fontSize: isMobile ? 14 : isTablet ? 16 : 18,
        fontFamily: 'Orbitron',
      ),
      bodyLarge: textTheme.bodyLarge!.copyWith(
        fontSize: isMobile ? 14 : isTablet ? 15 : 16,
        fontFamily: 'Orbitron',
      ),
      bodyMedium: textTheme.bodyMedium!.copyWith(
        fontSize: isMobile ? 12 : isTablet ? 13 : 14,
        fontFamily: 'Orbitron',
      ),
    );

    // Global keys for scrolling to sections
    final homeKey = GlobalKey();
    final aboutKey = GlobalKey();
    final projectsKey = GlobalKey();
    final skillsKey = GlobalKey();
    final certificationsKey = GlobalKey();
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

    // Function to launch URL
    Future<void> _launchURL(String url) async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $url')),
          );
        }
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
          // Animated particle effects
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
              // Top navigation bar
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
                      style: responsiveTextTheme.titleLarge!.copyWith(
                        color: Colors.cyan.shade300,
                        fontWeight: FontWeight.w900,
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
                        // if (value == 'certifications') scrollToSection(certificationsKey);
                        if (value == 'contact') scrollToSection(contactKey);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'home',
                          child: Text(
                            'Home',
                            style: responsiveTextTheme.bodyLarge!.copyWith(
                              color: Colors.cyan.shade200,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'about',
                          child: Text(
                            'About',
                            style: responsiveTextTheme.bodyLarge!.copyWith(
                              color: Colors.cyan.shade200,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'projects',
                          child: Text(
                            'Projects',
                            style: responsiveTextTheme.bodyLarge!.copyWith(
                              color: Colors.cyan.shade200,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'skills',
                          child: Text(
                            'Skills',
                            style: responsiveTextTheme.bodyLarge!.copyWith(
                              color: Colors.cyan.shade200,
                            ),
                          ),
                        ),
                        // PopupMenuItem(
                        //   value: 'certifications',
                        //   child: Text(
                        //     'Certifications',
                        //     style: responsiveTextTheme.bodyLarge!.copyWith(
                        //       color: Colors.cyan.shade200,
                        //     ),
                        //   ),
                        // ),
                        PopupMenuItem(
                          value: 'contact',
                          child: Text(
                            'Contact',
                            style: responsiveTextTheme.bodyLarge!.copyWith(
                              color: Colors.cyan.shade200,
                            ),
                          ),
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
                        // _NavButton(
                        //   text: 'Certifications',
                        //   onPressed: () => scrollToSection(certificationsKey),
                        //   colorScheme: colorScheme,
                        // ),
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
                      // Home section
                      Container(
                        key: homeKey,
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : isTablet ? 60 : 80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: isMobile ? 180 : isTablet ? 220 : 250,
                              height: isMobile ? 180 : isTablet ? 220 : 250,
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
                                    'assets/dev.json',
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: isMobile ? 120 : isTablet ? 140 : 160,
                                    height: isMobile ? 120 : isTablet ? 140 : 160,
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
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [Colors.cyan.shade300, Colors.purple.shade300],
                              ).createShader(bounds),
                              child: Text(
                                'Nadeem Ahmed Ansari',
                                style: responsiveTextTheme.displaySmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
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
                            Text(
                              'Software Engineer | Flutter Developer | ML Enthusiast',
                              style: responsiveTextTheme.titleLarge!.copyWith(
                                color: Colors.cyan.shade100.withOpacity(0.8),
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ).animate(onPlay: (controller) => controller.repeat())
                                .fadeIn(duration: 1200.ms, delay: 400.ms)
                                .custom(
                              duration: 4000.ms,
                              builder: (context, value, child) {
                                return DefaultTextStyle(
                                  style: responsiveTextTheme.titleLarge!.copyWith(
                                    color: Color.lerp(
                                      Colors.cyan.shade100.withOpacity(0.8),
                                      Colors.purple.shade200.withOpacity(0.8),
                                      value,
                                    ),
                                    letterSpacing: 1.5,
                                  ),
                                  child: child,
                                );
                              },
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            Text(
                              '"Building the future, one pixel at a time."',
                              style: responsiveTextTheme.bodyLarge!.copyWith(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
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
                                    _launchURL("https://drive.google.com/file/d/1AA5idtTwIjnJ3nfrPt6SbxMeLEhVcBkf/view?usp=drive_link");
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
                      // About section
                      Container(
                        key: aboutKey,
                        padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 32),
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
                              style: responsiveTextTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
                              ),
                            ).animate().fadeIn(duration: 800.ms).slideX(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'I’m a passionate Flutter developer crafting seamless cross-platform apps with a flair for innovation. My expertise spans Python, Machine Learning, and cloud technologies like AWS. I thrive on building intuitive, high-performance applications that push boundaries.',
                              style: responsiveTextTheme.bodyLarge!.copyWith(
                                color: Colors.white70,
                              ),
                            ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
                          ],
                        ),
                      ),
                      // Projects section
                      Container(
                        key: projectsKey,
                        padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Projects',
                              style: responsiveTextTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
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
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: isMobile ? 300 : isTablet ? 350 : 400,
                                crossAxisSpacing: isMobile ? 12 : 16,
                                mainAxisSpacing: isMobile ? 12 : 16,
                                childAspectRatio: isMobile ? 0.85 : 0.9,
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
                      // Skills section
                      Container(
                        key: skillsKey,
                        padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 32),
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
                              style: responsiveTextTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
                              ),
                            ).animate().fadeIn(duration: 800.ms).slideX(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: 16),
                            ..._skillCategories.asMap().entries.map((entry) {
                              final category = entry.value;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.cyan.shade300.withOpacity(0.4),
                                      width: 1.5,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.blue.shade900.withOpacity(0.6),
                                          Colors.purple.shade900.withOpacity(0.6),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                        splashColor: Colors.cyan.shade200.withOpacity(0.2),
                                      ),
                                      child: ExpansionTile(
                                        title: Text(
                                          category['category'],
                                          style: responsiveTextTheme.titleLarge!.copyWith(
                                            color: Colors.cyan.shade100,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        collapsedBackgroundColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        childrenPadding: EdgeInsets.all(isMobile ? 8 : 12),
                                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: (category['skills'] as List<String>).map((skill) {
                                              return Chip(
                                                label: Text(
                                                  skill,
                                                  style: responsiveTextTheme.bodyMedium!.copyWith(
                                                    color: Colors.black87,
                                                    fontSize: isMobile ? 12 : isTablet ? 13 : 14,
                                                  ),
                                                ),
                                                backgroundColor: Colors.cyanAccent.withOpacity(0.9),
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).animate().fadeIn(
                                  duration: 800.ms,
                                  delay: (entry.key * 200).ms,
                                ).scaleXY(
                                  begin: 0.9,
                                  end: 1.0,
                                  curve: Curves.easeOutCubic,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      // Certifications section
                      Container(
                        key: certificationsKey,
                        padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [Colors.cyan.shade300, Colors.purple.shade300],
                              ).createShader(bounds),
                              child: Text(
                                'Certifications',
                                style: responsiveTextTheme.headlineMedium!.copyWith(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.cyan.shade300.withOpacity(0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fadeIn(duration: 1000.ms).slideY(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: isMobile ? 8 : 12),
                            Text(
                              'Validated Expertise in AI & Cloud Technologies',
                              style: responsiveTextTheme.bodyLarge!.copyWith(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ).animate().fadeIn(duration: 1000.ms, delay: 200.ms).shimmer(
                              color: Colors.cyan.shade200.withOpacity(0.5),
                              duration: 3000.ms,
                            ),
                            SizedBox(height: isMobile ? 24 : 32),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // Timeline line
                                Container(
                                  width: isMobile ? 2 : isTablet ? 3 : 3,
                                  height: _certifications.length * (isMobile ? 200 : 220) + 40,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.cyan.shade300.withOpacity(0.4),
                                        Colors.cyan.shade300.withOpacity(0.8),
                                        Colors.cyan.shade300.withOpacity(0.4),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ).animate(
                                  onPlay: (controller) => controller.repeat(reverse: true),
                                ).fade(
                                  begin: 0.4,
                                  end: 0.8,
                                  duration: 2000.ms,
                                ),
                                // Certification cards
                                Column(
                                  children: _certifications.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final cert = entry.value;
                                    final isLeft = index % 2 == 0;
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: isMobile ? 24 : 32),
                                      child: Align(
                                        alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
                                        child: Container(
                                          width: isMobile ? size.width * 0.9 : size.width * 0.45,
                                          child: _CertificationCard(
                                            title: cert['title'],
                                            skills: cert['skills'],
                                            link: cert['link'],
                                            iconPath: 'assets/images/udacity_logo.png',
                                            onTapLink: _launchURL,
                                            isLeft: isLeft,
                                          ).animate().fadeIn(
                                            duration: 1200.ms,
                                            delay: (index * 400).ms,
                                          ).slideX(
                                            begin: isLeft ? -0.3 : 0.3,
                                            end: 0.0,
                                            curve: Curves.easeOutCubic,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Contact section
                      Container(
                        key: contactKey,
                        padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Get in Touch',
                              style: responsiveTextTheme.headlineMedium!.copyWith(
                                color: Colors.cyan.shade200,
                              ),
                            ).animate().fadeIn(duration: 800.ms).slideX(
                              begin: -0.2,
                              end: 0.0,
                              curve: Curves.easeOutQuad,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Let’s connect! Reach out via email or find me on social media to discuss projects or opportunities.',
                              style: responsiveTextTheme.bodyLarge!.copyWith(
                                color: Colors.white70,
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
          // Theme toggle
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
                  size: isMobile ? 20 : 24,
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

  // Skill categories data
  static const List<Map<String, dynamic>> _skillCategories = [
    {
      'category': 'Programming Languages',
      'skills': [
        'Python',
        'Java',
        'Dart',
        'SQL (MySQL, PostgreSQL)',
        'NoSQL (MongoDB)',
      ],
    },
    {
      'category': 'Software Development & Tools',
      'skills': [
        'Flutter',
        'Django',
        'Flask',
        'Git & GitHub',
        'Android Studio',
        'VS Code',
        'Postman',
        'Firebase',
      ],
    },
    {
      'category': 'Data & Cloud Technologies',
      'skills': [
        'AWS Services (SageMaker, Lambda, Step Functions, S3, CloudWatch)',
        'Machine Learning',
        'Scikit-learn',
        'Pandas',
        'NumPy',
        'Jupyter Notebook',
        'Image Classification',
        'Predictive Analytics',
      ],
    },
    {
      'category': 'Software & System Design',
      'skills': [
        'Software Architecture',
        'Database Design',
        'API Integration & Automation',
        'Event-driven Architecture',
      ],
    },
    {
      'category': 'Tools & Platforms',
      'skills': [
        'Salesforce Developer Tools (Apex, Lightning Web Components)',
        'Salesforce CLI',
        'Trailhead Modules',
      ],
    },
    {
      'category': 'Soft Skills & Professional Traits',
      'skills': [
        'Team Leadership',
        'Problem Solving (DSA)',
        'Communication',
        'Time Management',
        'Adaptability in Tech Environments',
      ],
    },
  ];

  // Certifications data
  static const List<Map<String, dynamic>> _certifications = [
    {
      'title': 'AWS Machine Learning Fundamentals Nanodegree',
      'skills': [
        'AWS SageMaker',
        'Lambda',
        'Step Functions',
        'Predictive Modeling',
        'Image Classification',
      ],
      'link': 'https://www.udacity.com/certificate/e/c2af05fe-f6c0-11ee-a09c-67a209556aa8',
      'iconPath': 'assets/udacity_logo.png',
    },
    {
      'title': 'AI Programming with Python Nanodegree',
      'skills': [
        'Python',
        'NumPy',
        'Pandas',
        'Matplotlib',
        'Linear Algebra',
        'Neural Networks',
      ],
      'link': 'https://www.udacity.com/certificate/e/86ce0d5a-6c23-11ee-9745-e30b407e96bc',
      'iconPath': 'assets/udacity_logo.png',
    },
    {
      'title': 'Foundation of Generative AI',
      'skills': [
        'Large Language Models (LLM)',
        'Generative AI',
        'Hugging Face Products',
        'Transfer Learning',
        'Prompt Design',
      ],
      'link': 'https://www.udacity.com/certificate/e/95842024-b7bc-11ef-a802-03ea2f06c24a',
      'iconPath': 'assets/udacity_logo.png',
    },
  ];
}

// Certification card widget
class _CertificationCard extends StatefulWidget {
  final String title;
  final List<String> skills;
  final String link;
  final String iconPath;
  final void Function(String) onTapLink;
  final bool isLeft;

  const _CertificationCard({
    required this.title,
    required this.skills,
    required this.link,
    required this.iconPath,
    required this.onTapLink,
    required this.isLeft,
  });

  @override
  _CertificationCardState createState() => _CertificationCardState();
}

class _CertificationCardState extends State<_CertificationCard> with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _tiltAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeOutBack,
      ),
    );
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeInOut,
      ),
    );
    _tiltAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 900;
    final responsiveTextTheme = Theme.of(context).textTheme.copyWith(
      titleLarge: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: isMobile ? 20 : isTablet ? 22 : 24,
        fontFamily: 'Orbitron',
        color: Colors.cyan.shade100,
        fontWeight: FontWeight.w700,
        shadows: [
          Shadow(
            color: Colors.cyan.shade300.withOpacity(0.5),
            blurRadius: 8,
          ),
        ],
      ),
      bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: isMobile ? 12 : isTablet ? 13 : 14,
        fontFamily: 'Orbitron',
        color: Colors.black87,
      ),
    );

    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: GestureDetector(
        onLongPress: isMobile ? () => _hoverController.forward() : null,
        onLongPressEnd: isMobile ? (_) => _hoverController.reverse() : null,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective for 3D tilt
                ..rotateY(widget.isLeft ? _tiltAnimation.value : -_tiltAnimation.value),
              alignment: widget.isLeft ? Alignment.centerRight : Alignment.centerLeft,
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.cyan.shade300.withOpacity(_glowAnimation.value),
                    width: 2,
                  ),
                ),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.blue.shade900.withOpacity(0.7),
                        Colors.purple.shade900.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.shade300.withOpacity(_glowAnimation.value),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.purple.shade300.withOpacity(_glowAnimation.value * 0.8),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(isMobile ? 12 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Provider icon
                          Container(
                            width: isMobile ? 40 : isTablet ? 48 : 56,
                            height: isMobile ? 40 : isTablet ? 48 : 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.cyan.shade200.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                widget.iconPath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ).animate().fadeIn(duration: 800.ms).scaleXY(
                            begin: 0.7,
                            end: 1.0,
                            curve: Curves.easeOutBack,
                          ),
                          SizedBox(width: isMobile ? 12 : 16),
                          // Title
                          Expanded(
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.cyan.shade300,
                                  Colors.purple.shade300,
                                ],
                              ).createShader(bounds),
                              child: Text(
                                widget.title,
                                style: responsiveTextTheme.titleLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      // Skills
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.skills.map((skill) {
                          return MouseRegion(
                            onEnter: (_) => _hoverController.forward(),
                            onExit: (_) => _hoverController.reverse(),
                            child: Chip(
                              label: Text(
                                skill,
                                style: responsiveTextTheme.bodyMedium,
                              ),
                              backgroundColor: Colors.cyanAccent.withOpacity(0.9),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              side: BorderSide(
                                color: Colors.cyan.shade200.withOpacity(_glowAnimation.value * 0.5),
                              ),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ).animate().scaleXY(
                              begin: 1.0,
                              end: _hoverController.isAnimating ? 1.1 : 1.0,
                              curve: Curves.easeOutBack,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      // Verify button
                      GestureDetector(
                        onTap: () => widget.onTapLink(widget.link),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 20,
                            vertical: isMobile ? 8 : 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.cyan.shade300.withOpacity(_glowAnimation.value),
                              width: 1.5,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.cyan.shade400.withOpacity(_glowAnimation.value),
                                Colors.purple.shade400.withOpacity(_glowAnimation.value),
                              ],
                            ),
                          ),
                          child: Text(
                            'Verify Certificate',
                            style: responsiveTextTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ).animate().fadeIn(duration: 600.ms).scaleXY(
                          begin: 0.9,
                          end: 1.0,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Custom navigation button
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovered ? Colors.cyan.shade200 : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: _isHovered ? Colors.cyan.shade200 : Colors.cyan.shade100,
              fontFamily: 'Orbitron',
              letterSpacing: 1,
              fontSize: isMobile ? 14 : 16,
            ),
          ),
        ),
      ),
    );
  }
}
