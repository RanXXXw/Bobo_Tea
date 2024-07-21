import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButtons extends StatelessWidget {
  final List<SocialMediaLink> links;

  const SocialMediaButtons({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: links
          .map(
            (link) => IconButton(
              onPressed: () {
                try {
                  launchUrl(Uri.parse(link.url));
                } catch (e) {
                  print('Error launching URL: $e');
                }
              },
              icon: Icon(link.icon),
            ),
          )
          .toList(),
    );
  }
}

class SocialMediaLink {
  final String url;
  final IconData icon;

  SocialMediaLink({required this.url, required this.icon});
}
