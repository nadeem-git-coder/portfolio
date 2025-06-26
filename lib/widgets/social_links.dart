import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Row(
      children: [
        _SocialIconButton(
          icon: FontAwesomeIcons.linkedin,
          url: 'https://www.linkedin.com/in/nadeem-ahmed-ansari/',
          color: Colors.cyan.shade200,
          size: isMobile ? 24.0 : 32.0,
        ),
        const SizedBox(width: 16),
        _SocialIconButton(
          icon: FontAwesomeIcons.github,
          url: 'https://github.com/nadeem-git-coder',
          color: Colors.cyan.shade200,
          size: isMobile ? 24.0 : 32.0,
        ),
        const SizedBox(width: 16),
        _SocialIconButton(
          icon: FontAwesomeIcons.envelope,
          url: 'mailto:ahmed.nadeem0219@gmail.com',
          color: Colors.cyan.shade200,
          size: isMobile ? 24.0 : 32.0,
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color color;
  final double size;

  const _SocialIconButton({
    required this.icon,
    required this.url,
    required this.color,
    required this.size,
  });

  @override
  _SocialIconButtonState createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _shimmerController;
  late Animation<double> _hoverScaleAnimation;
  late Animation<double> _hoverOpacityAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    // Controller for hover animation
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
      // Control shimmer based on hover state
      if (_hoverController.isAnimating || _hoverController.isCompleted) {
        if (!_shimmerController.isAnimating) {
          _shimmerController.repeat();
        }
      } else {
        _shimmerController.stop();
        _shimmerController.reset();
      }
    });

    // Controller for shimmer effect
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _hoverScaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeOutCubic,
      ),
    );

    _hoverOpacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeInOut,
      ),
    );

    _shimmerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
      mode: LaunchMode.externalApplication
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(widget.url),
      child: MouseRegion(
        onEnter: (_) => _hoverController.forward(),
        onExit: (_) => _hoverController.reverse(),
        child: AnimatedBuilder(
          animation: Listenable.merge([_hoverController, _shimmerController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _hoverScaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(_hoverOpacityAnimation.value * 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      widget.color.withOpacity(_hoverController.isAnimating ? _hoverOpacityAnimation.value * 0.5 : 0.0),
                      widget.color.withOpacity(_hoverController.isAnimating ? _hoverOpacityAnimation.value * 0.5 : 0.0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    tileMode: TileMode.mirror,
                    stops: [
                      _shimmerAnimation.value * 0.5,
                      _shimmerAnimation.value,
                    ],
                  ).createShader(bounds),
                  blendMode: BlendMode.srcATop,
                  child: FaIcon(
                    widget.icon,
                    color: widget.color.withOpacity(_hoverOpacityAnimation.value),
                    size: widget.size,
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