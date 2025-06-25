import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color; // Optional color for customization

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.2, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    final baseColor = widget.color ?? Colors.cyan.shade400;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    baseColor.withOpacity(0.8),
                    Colors.purple.shade400.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: baseColor.withOpacity(_glowAnimation.value),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: baseColor.withOpacity(_isHovered ? 0.6 : _glowAnimation.value),
                    blurRadius: _isHovered ? 20 : 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                widget.text,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontFamily: 'Orbitron',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        },
      ).animate().scaleXY(
        begin: 0.95,
        end: _isHovered ? 1.05 : 1.0,
        duration: 300.ms,
        curve: Curves.easeOutBack,
      ).fadeIn(
        duration: 800.ms,
        curve: Curves.easeInOut,
      ).shimmer(
        color: Colors.cyan.shade200.withOpacity(0.5),
        duration: 2000.ms,
      ),
    );
  }
}