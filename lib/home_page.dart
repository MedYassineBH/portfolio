import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'sections/home_section.dart';
import 'sections/skills_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'widgets/navbar.dart';
import 'widgets/footer.dart';
import '../utils/constants.dart';
import '../controllers/gradient_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/locale_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();
  bool _showScrollUp = false;
  bool _isScrollUpHovered = false;
  double _lastOffset = 0;

  final ThemeController _themeController = Get.find<ThemeController>();
  final LocaleController _localeController = Get.find<LocaleController>();

  @override
  void initState() {
    super.initState();
    Get.put(GradientController());
    final gradientController = Get.find<GradientController>();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final velocity = (offset - _lastOffset).abs();
      final isDown = offset > _lastOffset;
      _lastOffset = offset;
      gradientController.updateScroll(velocity, isDown);
      setState(() {
        _showScrollUp = offset > 300;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final fragment = Uri.base.fragment;
      if (fragment.isNotEmpty) {
        _scrollToSection(fragment);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.delete<GradientController>();
    super.dispose();
  }

  void _scrollToSection(String sectionName) {
    GlobalKey? key;
    switch (sectionName) {
      case 'about':
        key = aboutKey;
        break;
      case 'skills':
        key = skillsKey;
        break;
      case 'projects':
        key = projectsKey;
        break;
      case 'contact':
        key = contactKey;
        break;
      case 'home':
        key = homeKey;
        break;
    }
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      if (kIsWeb) {
        if (Uri.base.fragment != sectionName) {
          js.context.callMethod('pushState', [null, '', '#$sectionName']);
        }
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    if (kIsWeb) {
      js.context.callMethod('pushState', [null, '', '']);
    }
  }

  void _toggleTheme() {
    _themeController.toggleTheme();
    final gradientController = Get.find<GradientController>();
    gradientController.updateScroll(0, false);
    setState(() {});
  }

  void _toggleLanguage() {
  final isEnglish = _localeController.locale.value.languageCode == 'en';
  _localeController.switchLocale(
    isEnglish ? 'fr' : 'en',
    isEnglish ? 'FR' : 'US',
  );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final gradientController = Get.find<GradientController>();

    return Scaffold(
      body: Obx(() {
        final isDark = _themeController.themeMode.value == ThemeMode.dark ||
            (_themeController.themeMode.value == ThemeMode.system &&
                MediaQuery.of(context).platformBrightness == Brightness.dark);
        return Stack(
          children: [
            AnimateGradient(
              primaryColors: isDark ? AppGradients.darkPrimary : AppGradients.lightPrimary,
              secondaryColors: isDark ? AppGradients.darkSecondary : AppGradients.lightSecondary,
              controller: gradientController.animationController,
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Navbar(
                    onItemSelected: _scrollToSection,
                    isDarkMode: isDark,
                    toggleTheme: _toggleTheme,
                    toggleLanguage: _toggleLanguage,
                  ),
                  _sectionWrapper(
                    key: homeKey,
                    isSmallScreen: isSmallScreen,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: const HomeSection(),
                    ),
                  ),
                  _sectionWrapper(
                    key: aboutKey,
                    isSmallScreen: isSmallScreen,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      child: const AboutSection(),
                    ),
                  ),
                  _sectionWrapper(
                    key: skillsKey,
                    isSmallScreen: isSmallScreen,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 900),
                      child: const SkillsSection(),
                    ),
                  ),
                  _sectionWrapper(
                    key: projectsKey,
                    isSmallScreen: isSmallScreen,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const ProjectsSection(),
                    ),
                  ),
                  _sectionWrapper(
                    key: contactKey,
                    isSmallScreen: isSmallScreen,
                    child: _ContactSectionWithAdminGesture(),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: const Footer(),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton: _showScrollUp
          ? MouseRegion(
              onEnter: (_) => setState(() => _isScrollUpHovered = true),
              onExit: (_) => setState(() => _isScrollUpHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.identity()
                  ..rotateZ(_isScrollUpHovered && !isSmallScreen ? 0.2 : 0.0)
                  ..scale(_isScrollUpHovered && !isSmallScreen ? 1.2 : 1.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (_isScrollUpHovered && !isSmallScreen)
                      BoxShadow(
                        color: const Color(0xFF00ADB5).withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(2, 2),
                      ),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: _scrollToTop,
                  tooltip: 'Scroll to top'.tr,
                  backgroundColor: const Color(0xFF00ADB5),
                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            )
          : null,
    );
  }

  Widget _sectionWrapper({
    required Key key,
    required Widget child,
    required bool isSmallScreen,
  }) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 32 : 64,
        horizontal: isSmallScreen ? 16 : 24,
      ),
      width: double.infinity,
      child: child,
    );
  }
}

class _ContactSectionWithAdminGesture extends StatefulWidget {
  const _ContactSectionWithAdminGesture();

  @override
  State<_ContactSectionWithAdminGesture> createState() => _ContactSectionWithAdminGestureState();
}

class _ContactSectionWithAdminGestureState extends State<_ContactSectionWithAdminGesture> {
  int _tapCount = 0;
  DateTime? _lastTap;

  void _handleTap() {
    final now = DateTime.now();
    if (_lastTap == null || now.difference(_lastTap!) > const Duration(seconds: 2)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTap = now;

    if (_tapCount >= 3) {
      Get.toNamed('/admin');
      _tapCount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleTap,
      child: FadeInUp(
        duration: const Duration(milliseconds: 1200),
        child: const ContactSection(),
      ),
    );
  }
}
