import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'skills_controller.dart'; // Import SkillsController

class LocaleController extends GetxController {
  var locale = Rx<Locale>(const Locale('en', 'US')); // Default to English
  final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('fr', 'FR')
  ];

  @override
  void onInit() {
    super.onInit();
    final deviceLocale = Get.deviceLocale;
    locale.value = supportedLocales.contains(deviceLocale)
        ? deviceLocale!
        : const Locale('en', 'US');
    print('Locale initialized to: ${locale.value}');
  }

  void switchLocale(String languageCode, String countryCode) {
    final newLocale = Locale(languageCode, countryCode);
    if (supportedLocales.contains(newLocale)) {
      locale.value = newLocale;
      print('Switching locale to: ${locale.value}');
      Get.updateLocale(locale.value);
      Get.find<SkillsController>().refreshTranslations(); // Refresh translations
      update(); // Notify listeners
    } else {
      print('Unsupported locale: $newLocale. Ignoring switch.');
    }
  }
}
