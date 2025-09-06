import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'controllers/theme_controller.dart';
import 'controllers/locale_controller.dart';
import 'controllers/skills_controller.dart';

import 'themes/app_themes.dart';
import 'translations/strings.dart';
import 'home_page.dart';
import '../sections/admin_login_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  // Register controllers after Firebase initialization
  final themeController = Get.put(ThemeController());
  final localeController = Get.put(LocaleController());
  final skillsController = Get.put(SkillsController()); // Add SkillsController registration
  // Ensure initial locale is applied
  Get.updateLocale(localeController.locale.value);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: Get.find<ThemeController>().themeMode.value,
      translations: AppTranslation(),
      locale: Get.find<LocaleController>().locale.value,
      fallbackLocale: const Locale('en', 'US'),
      home: GetBuilder<ThemeController>(
        builder: (themeController) => HomePage(),
      ),
      getPages: [
        GetPage(name: '/admin', page: () => const AdminLoginScreen()),
      ],
    );
  }
}
