import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withOpacity(0.5),
          border: Border.all(
            color: _isHovered
                ? Colors.cyan.shade200.withOpacity(0.8)
                : Colors.cyan.shade200.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.cyan.shade200.withOpacity(0.15)
                  : Colors.transparent,
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Holographic effect on hover
            if (_isHovered)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.8,
                        colors: [
                          Colors.cyan.shade200.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Project content with bottom-aligned buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main content that can expand
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.terminal,
                              color: Colors.cyan.shade200,
                              size: isMobile ? 18 : 22,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.project.title,
                                style: TextStyle(
                                  fontSize: isMobile ? 15 : 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan.shade200,
                                  fontFamily: 'Orbitron',
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isMobile ? 8 : 12),
                        Text(
                          widget.project.description,
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 13,
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Orbitron',
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: isMobile ? 8 : 12),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: widget.project.tags.map((tag) {
                            return AnimatedContainer(
                              duration: 200.ms,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 8 : 10,
                                vertical: isMobile ? 4 : 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _isHovered
                                      ? Colors.cyan.shade200
                                      : Colors.cyan.shade200.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: isMobile ? 9 : 10,
                                  color: Colors.cyan.shade200,
                                  fontFamily: 'Orbitron',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action buttons container (always at bottom)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (widget.project.githubLink?.isNotEmpty ?? false)
                        AnimatedContainer(
                          duration: 200.ms,
                          transform: Matrix4.identity()
                            ..translate(_isHovered ? -5.0 : 0.0),
                          child: TextButton(
                            onPressed: () =>
                                _launchURL(widget.project.githubLink ?? ""),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 10 : 12,
                                vertical: isMobile ? 6 : 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.code,
                                  size: isMobile ? 14 : 16,
                                  color: Colors.cyan.shade200,
                                ),
                                SizedBox(width: isMobile ? 4 : 6),
                                Text(
                                  'Code',
                                  style: TextStyle(
                                    color: Colors.cyan.shade200,
                                    fontFamily: 'Orbitron',
                                    fontSize: isMobile ? 11 : 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (widget.project.demoLink?.isNotEmpty ?? false)
                        SizedBox(width: isMobile ? 4 : 12),
                      if (widget.project.demoLink?.isNotEmpty ?? false)
                        AnimatedContainer(
                          duration: 200.ms,
                          transform: Matrix4.identity()
                            ..translate(_isHovered ? -5.0 : 0.0),
                          child: TextButton(
                            onPressed: () =>
                                _launchURL(widget.project.demoLink ?? ""),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 10 : 12,
                                vertical: isMobile ? 6 : 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.launch,
                                  size: isMobile ? 14 : 16,
                                  color: Colors.cyan.shade200,
                                ),
                                SizedBox(width: isMobile ? 4 : 6),
                                Text(
                                  'Live',
                                  style: TextStyle(
                                    color: Colors.cyan.shade200,
                                    fontFamily: 'Orbitron',
                                    fontSize: isMobile ? 11 : 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}