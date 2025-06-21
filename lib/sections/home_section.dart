import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final scaleFactor = isSmallScreen ? 0.8 : 1.0;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 32 : 64,
        horizontal: isSmallScreen ? 16 : 32,
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: CircleAvatar(
                radius: isSmallScreen ? 60 * scaleFactor : 80,
                backgroundImage: AssetImage(
                  _isHovered && !isSmallScreen
                      ? 'assets/images/avatar_hover.jpeg'
                      : 'assets/images/avatar.jpg',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Mohamed Yassine Ben Hamouda',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 28 * scaleFactor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'portfolio_title'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20 * scaleFactor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
