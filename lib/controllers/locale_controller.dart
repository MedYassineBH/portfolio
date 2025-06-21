import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  var locale = Rx<Locale>(const Locale('en', 'US')); // Initialize as non-null

  @override
  void onInit() {
    super.onInit();
    locale.value = Get.deviceLocale ?? const Locale('en', 'US');
  }

  void switchLocale() {
    locale.value = locale.value.languageCode == 'en'
        ? const Locale('fr', 'FR')
        : const Locale('en', 'US');
    Get.updateLocale(locale.value);
    update();
  }
}
