import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navbar extends StatefulWidget {
  final Function(String) onItemSelected;
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  const Navbar({
    super.key,
    required this.onItemSelected,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.toggleLanguage,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isMenuOpen = false;
  final List<bool> _isHovered = [false, false, false, false]; // About, Skills, Projects, Contact

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final scaleFactor = isSmallScreen ? 0.8 : 1.0;
    final currentLocale = Get.locale;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 8 : 16,
        horizontal: isSmallScreen ? 16 : 24,
      ),
      child: isSmallScreen
          ? _buildMobileNavbar(context, isDark, scaleFactor, currentLocale)
          : _buildDesktopNavbar(context, isDark, scaleFactor, currentLocale),
    );
  }

  Widget _buildDesktopNavbar(BuildContext context, bool isDark, double scaleFactor, Locale? currentLocale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton(
              context,
              'about'.tr,
              () => widget.onItemSelected('about'),
              isDark,
              scaleFactor,
              0,
            ),
            const SizedBox(width: 16),
            _buildNavButton(
              context,
              'skills'.tr,
              () => widget.onItemSelected('skills'),
              isDark,
              scaleFactor,
              1,
            ),
            const SizedBox(width: 16),
            _buildNavButton(
              context,
              'projects'.tr,
              () => widget.onItemSelected('projects'),
              isDark,
              scaleFactor,
              2,
            ),
            const SizedBox(width: 16),
            _buildNavButton(
              context,
              'contact'.tr,
              () => widget.onItemSelected('contact'),
              isDark,
              scaleFactor,
              3,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
                onPressed: widget.toggleTheme,
                tooltip: widget.isDarkMode
                    ? 'switch_to_light_mode'.tr
                    : 'switch_to_dark_mode'.tr,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                icon: Image.asset(
                  currentLocale?.languageCode == 'fr'
                      ? 'assets/images/en_flag.png'
                      : 'assets/images/fr_flag.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                onPressed: widget.toggleLanguage,
                tooltip: currentLocale?.languageCode == 'fr'
                    ? 'switch_to_english'.tr
                    : 'switch_to_french'.tr,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNavbar(BuildContext context, bool isDark, double scaleFactor, Locale? currentLocale) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(_isMenuOpen ? Icons.close : Icons.menu),
              onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
            ),
            Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                    icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
                    onPressed: widget.toggleTheme,
                    tooltip: widget.isDarkMode
                        ? 'switch_to_light_mode'.tr
                        : 'switch_to_dark_mode'.tr,
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                    icon: Image.asset(
                      currentLocale?.languageCode == 'fr'
                          ? 'assets/images/en_flag.png'
                          : 'assets/images/fr_flag.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    onPressed: widget.toggleLanguage,
                    tooltip: currentLocale?.languageCode == 'fr'
                        ? 'switch_to_english'.tr
                        : 'switch_to_french'.tr,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (_isMenuOpen)
          Column(
            children: [
              _buildNavButton(
                context,
                'about'.tr,
                () {
                  widget.onItemSelected('about');
                  setState(() => _isMenuOpen = false);
                },
                isDark,
                scaleFactor,
                0,
              ),
              _buildNavButton(
                context,
                'skills'.tr,
                () {
                  widget.onItemSelected('skills');
                  setState(() => _isMenuOpen = false);
                },
                isDark,
                scaleFactor,
                1,
              ),
              _buildNavButton(
                context,
                'projects'.tr,
                () {
                  widget.onItemSelected('projects');
                  setState(() => _isMenuOpen = false);
                },
                isDark,
                scaleFactor,
                2,
              ),
              _buildNavButton(
                context,
                'contact'.tr,
                () {
                  widget.onItemSelected('contact');
                  setState(() => _isMenuOpen = false);
                },
                isDark,
                scaleFactor,
                3,
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
    bool isDark,
    double scaleFactor,
    int index,
  ) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered[index] = true),
      onExit: (_) => setState(() => _isHovered[index] = false),
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovered[index] ? const Color(0xFF00ADB5) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: _isHovered[index] ? const Color(0xFF00ADB5) : (isDark ? Colors.white : const Color(0xFF222831)),
              fontWeight: FontWeight.bold,
              fontSize: 14 * scaleFactor,
            ),
          ),
        ),
      ),
    );
  }
}
