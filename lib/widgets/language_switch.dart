import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/locale_controller.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Obx(() {
      final isEnglish = localeController.locale.value.languageCode == 'en';
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered && !isSmallScreen ? 1.2 : 1.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (_isHovered && !isSmallScreen)
                BoxShadow(
                  color: const Color(0xFF00ADB5).withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: IconButton(
            icon: Image.asset(
              isEnglish ? 'assets/images/en_flag.png' : 'assets/images/fr_flag.png',
              height: isSmallScreen ? 20 : 24,
            ),
            onPressed: () {
              localeController.switchLocale();
            },
            tooltip: isEnglish ? 'Switch to French' : 'Switch to English',
          ),
        ),
      );
    });
  }
}
