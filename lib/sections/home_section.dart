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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final scaleFactor = screenWidth < 320
        ? 0.5
        : (screenWidth < 425
            ? 0.7
            : (screenWidth < 600 ? 0.8 : 1.0));
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 32 : 64,
        horizontal: isSmallScreen ? 16 : 32,
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: CircleAvatar(
                radius: isSmallScreen ? 80 * scaleFactor : 100,
                backgroundImage: AssetImage(
                  _isHovered && !isSmallScreen
                      ? 'assets/images/avatar_hover.jpeg'
                      : 'assets/images/avatar.jpg',
                ),
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mohamed Yassine Ben Hamouda',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 32 * scaleFactor,
                          height: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'portfolio_title'.tr,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 24 * scaleFactor,
                          height: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
