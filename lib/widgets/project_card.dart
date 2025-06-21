import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String url;
  final bool isSmallScreen;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.isSmallScreen,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = widget.isSmallScreen ? 0.8 : 1.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scale(_isHovered && !widget.isSmallScreen ? 1.05 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (_isHovered && !widget.isSmallScreen)
              BoxShadow(
                color: const Color(0xFF00ADB5).withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Card(
          elevation: _isHovered && !widget.isSmallScreen ? 8 : 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: widget.isSmallScreen ? 250 : 300,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.identity()
                      ..scale(_isHovered && !widget.isSmallScreen ? 1.1 : 1.0),
                    child: Image.asset(
                      widget.image,
                      height: widget.isSmallScreen ? 120 : 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16 * scaleFactor,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14 * scaleFactor,
                      ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _launchURL(widget.url),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    backgroundColor: _isHovered && !widget.isSmallScreen
                        ? const Color(0xFF00ADB5).withOpacity(0.1)
                        : null,
                  ),
                  child: Text(
                    'View Project',
                    style: TextStyle(
                      color: const Color(0xFF00ADB5),
                      fontSize: 12 * scaleFactor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
