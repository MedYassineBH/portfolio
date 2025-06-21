import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'controllers/theme_controller.dart';
import 'controllers/locale_controller.dart';
import 'themes/app_themes.dart';
import 'translations/strings.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  Get.put(ThemeController());
  Get.put(LocaleController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
        translations: AppTranslation(),
        locale: Get.find<LocaleController>().locale.value,
        fallbackLocale: const Locale('en', 'US'),
        home: const HomePage(),
      ),
    );
  }
}
