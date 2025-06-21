import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cv_button.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isCvHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final scaleFactor = isSmallScreen ? 0.8 : 1.0;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 32 : 64,
        horizontal: isSmallScreen ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'about'.tr,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 28 * scaleFactor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'about_description'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14 * scaleFactor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Center(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isCvHovered = true),
              onExit: (_) => setState(() => _isCvHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.identity()
                  ..scale(_isCvHovered && !isSmallScreen ? 1.1 : 1.0),
                child: const CVButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
