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
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'portfolio_title'.tr,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 24 * scaleFactor,
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
