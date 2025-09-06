import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navbar.dart';
import 'footer.dart';
import '../controllers/theme_controller.dart';
import '../controllers/locale_controller.dart';

class PageScaffold extends StatefulWidget {
  final String titleKey;
  final Widget child;

  const PageScaffold({
    super.key,
    required this.titleKey,
    required this.child,
  });

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollUp = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showScrollUp = _scrollController.offset > 300;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();

    return Scaffold(
      body: Column(
        children: [
          Navbar(
            onItemSelected: (index) {},
            isDarkMode: themeController.themeMode.value == ThemeMode.dark,
            toggleTheme: themeController.toggleTheme,
            toggleLanguage: () => localeController.switchLocale('en', 'US'),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: widget.child,
            ),
          ),
          const Footer(),
        ],
      ),
      floatingActionButton: _showScrollUp
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              tooltip: 'Scroll to top',
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
