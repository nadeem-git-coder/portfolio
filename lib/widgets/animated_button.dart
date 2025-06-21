import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class AnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: theme.elevatedButtonTheme.style?.copyWith(
        backgroundColor: WidgetStateProperty.all(theme.colorScheme.primary),
        foregroundColor: WidgetStateProperty.all(theme.colorScheme.onPrimary),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    ).animate(
      onPlay: (controller) => controller.repeat(reverse: true),
    ).scale(
      begin: Offset(0.95, 0.95),
      end: Offset(1.05, 1.05),
      duration: 2000.ms,
      curve: Curves.easeInOutSine,
    );
  }
}