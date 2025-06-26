import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bgController;
  late AnimationController _orbitController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rippleAnimation;
  late Animation<double> _orbitAnimation;
  late Animation<Color?> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutExpo,
      ),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutSine,
      ),
    );

    _orbitAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(
        parent: _orbitController,
        curve: Curves.linear,
      ),
    );

    _gradientAnimation = ColorTween(
      begin: Colors.cyan.shade800,
      end: Colors.purple.shade700,
    ).animate(_bgController);

    _controller.forward().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          context.go('/');
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _bgController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final textTheme = Theme.of(context).textTheme;

    // Responsive font size adjustments
    final responsiveTextTheme = textTheme.copyWith(
      headlineMedium: textTheme.headlineMedium!.copyWith(
        fontSize: isMobile ? 22 : 28, // Reduced from ~32-34 for mobile
      ),
      titleLarge: textTheme.titleLarge!.copyWith(
        fontSize: isMobile ? 16 : 20, // Reduced from ~20-22 for mobile
      ),
    );

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_controller, _bgController, _orbitController]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _gradientAnimation.value ?? Colors.cyan.shade800,
                  Colors.purple.shade600,
                  Colors.blue.shade900,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.4, 1.0],
                transform: GradientRotation(_bgController.value * 3.14159),
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple effect with clamped opacity
                  Transform.scale(
                    scale: _rippleAnimation.value * (isMobile ? 1.2 : 1.5),
                    child: Container(
                      width: isMobile ? 140 : 180,
                      height: isMobile ? 140 : 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.cyan.withOpacity((0.15 * (1 - _rippleAnimation.value)).clamp(0.0, 1.0)),
                      ),
                    ),
                  ),
                  // Futuristic orbiting planet design
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Planet-like orb with orbiting rings
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Core orb
                              Container(
                                width: isMobile ? 100 : 120,
                                height: isMobile ? 100 : 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.cyan.shade200,
                                      Colors.blue.shade900,
                                    ],
                                    center: Alignment.center,
                                    radius: 0.6,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyan.shade300.withOpacity(0.5),
                                      blurRadius: isMobile ? 20 : 25,
                                      spreadRadius: isMobile ? 6 : 8,
                                    ),
                                  ],
                                ),
                              ),
                              // Orbiting ring 1
                              Transform.rotate(
                                angle: _orbitAnimation.value,
                                child: Container(
                                  width: isMobile ? 130 : 160,
                                  height: isMobile ? 130 : 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.cyan.withOpacity(0.4),
                                      width: isMobile ? 1.2 : 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Orbiting ring 2
                              Transform.rotate(
                                angle: -_orbitAnimation.value * 0.7,
                                child: Container(
                                  width: isMobile ? 115 : 140,
                                  height: isMobile ? 115 : 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.purple.withOpacity(0.4),
                                      width: isMobile ? 1.2 : 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: isMobile ? 32 : 40),
                          // Name with cyberpunk gradient text
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.cyan.shade300,
                                Colors.purple.shade300,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              'Nadeem Ahmed Ansari',
                              style: responsiveTextTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontFamily: 'Orbitron',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),
                          // Profession with neon effect
                          Opacity(
                            opacity: _opacityAnimation.value * 0.85,
                            child: Text(
                              'Flutter Developer',
                              style: responsiveTextTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.cyan.shade100.withOpacity(0.9),
                                letterSpacing: 1.0,
                                fontFamily: 'Orbitron',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: isMobile ? 32 : 40),
                          // Custom loading indicator with pulse
                          SizedBox(
                            width: isMobile ? 28 : 32,
                            height: isMobile ? 28 : 32,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: isMobile ? 2 : 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.cyan.withOpacity(0.8),
                                  ),
                                ),
                                Container(
                                  width: isMobile ? 10 : 12,
                                  height: isMobile ? 10 : 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.cyan.shade300,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        blurRadius: isMobile ? 8 : 10,
                                        spreadRadius: isMobile ? 2 : 3,
                                      ),
                                    ],
                                  ),
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
            ),
          );
        },
      ),
    );
  }
}