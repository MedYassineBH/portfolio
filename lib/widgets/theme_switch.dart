import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.themeMode.value == ThemeMode.dark;
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.2 : 1.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: const Color(0xFF00ADB5).withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              themeController.toggleTheme(); // Changed from switchTheme to toggleTheme
              themeController.update();
            },
            tooltip: isDark ? 'Switch to Light Theme' : 'Switch to Dark Theme',
          ),
        ),
      );
    });
  }
}
