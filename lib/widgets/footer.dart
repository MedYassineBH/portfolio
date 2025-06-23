import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool _isGitHubHovered = false;
  bool _isLinkedInHovered = false;
  bool _isEmailHovered = false;
  bool _isFacebookHovered = false;
  bool _isInstagramHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final scaleFactor = isSmallScreen ? 0.8 : 1.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 8 : 16),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconButton(
                context,
                icon: 'assets/icons/github_dark.png',
                tooltip: 'GitHub',
                url: 'https://github.com/your-github-username',
                isHovered: _isGitHubHovered,
                onHoverEnter: () => setState(() => _isGitHubHovered = true),
                onHoverExit: () => setState(() => _isGitHubHovered = false),
                isSmallScreen: isSmallScreen,
              ),
              _buildIconButton(
                context,
                icon: 'assets/icons/linkedin_dark.png',
                tooltip: 'LinkedIn',
                url: 'https://linkedin.com/in/yassine-ben-hamouda-52b9512a1',
                isHovered: _isLinkedInHovered,
                onHoverEnter: () => setState(() => _isLinkedInHovered = true),
                onHoverExit: () => setState(() => _isLinkedInHovered = false),
                isSmallScreen: isSmallScreen,
              ),
              _buildIconButton(
                context,
                icon: 'assets/icons/facebook_dark.png',
                tooltip: 'Facebook',
                url: 'https://www.facebook.com/yassin.benhamouda.92',
                isHovered: _isFacebookHovered,
                onHoverEnter: () => setState(() => _isFacebookHovered = true),
                onHoverExit: () => setState(() => _isFacebookHovered = false),
                isSmallScreen: isSmallScreen,
              ),
              _buildIconButton(
                context,
                icon: 'assets/icons/instagram_dark.png',
                tooltip: 'Instagram',
                url: 'https://www.instagram.com/yassinebh__/',
                isHovered: _isInstagramHovered,
                onHoverEnter: () => setState(() => _isInstagramHovered = true),
                onHoverExit: () => setState(() => _isInstagramHovered = false),
                isSmallScreen: isSmallScreen,
              ),
              _buildIconButton(
                context,
                icon: 'assets/icons/mail_dark.png',
                tooltip: 'Email',
                url: 'mailto:medyassinebenhamouda04@gmail.com',
                isHovered: _isEmailHovered,
                onHoverEnter: () => setState(() => _isEmailHovered = true),
                onHoverExit: () => setState(() => _isEmailHovered = false),
                isSmallScreen: isSmallScreen,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            isDark ? 'footer_dark'.tr : 'footer_light'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: isDark ? const Color(0xFFEEEEEE) : const Color(0xFF222831),
              fontSize: 12 * scaleFactor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required String icon,
    required String tooltip,
    required String url,
    required bool isHovered,
    required VoidCallback onHoverEnter,
    required VoidCallback onHoverExit,
    required bool isSmallScreen,
  }) {
    return MouseRegion(
      onEnter: (_) => onHoverEnter(),
      onExit: (_) => onHoverExit(),
      child: GestureDetector(
        onTapDown: (_) => onHoverEnter(),
        onTapUp: (_) => onHoverExit(),
        onTapCancel: onHoverExit,
        onTap: () => _launchURL(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          transform: Matrix4.identity()..scale(isHovered ? 1.2 : 1.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: const Color(0xFF00ADB5).withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Image.asset(
            icon,
            height: isSmallScreen ? 16 : 20,
            color: Theme.of(context).iconTheme.color,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
