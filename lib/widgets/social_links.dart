import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.linkedin),
          onPressed: () {
            // TODO: Launch LinkedIn URL
          },
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.github),
          onPressed: () {
            // TODO: Launch GitHub URL
          },
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.envelope),
          onPressed: () {
            // TODO: Launch Email
          },
        ),
      ],
    );
  }
}