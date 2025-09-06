import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'locale_controller.dart'; // Import LocaleController

class SkillsController extends GetxController {
  final RxList<Map<String, dynamic>> translatedSoftSkills = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> translatedHardSkills = <Map<String, dynamic>>[].obs;

  final Map<String, List<Map<String, dynamic>>> rawHardSkills = {
    'Languages': [
      {'key': 'python', 'icon': 'assets/icons/python.png', 'descKey': 'python_description'},
      {'key': 'c', 'icon': 'assets/icons/c.png', 'descKey': 'c_description'},
      {'key': 'java', 'icon': 'assets/icons/java.png', 'descKey': 'java_description'},
      {'key': 'php', 'icon': 'assets/icons/php.png', 'descKey': 'php_description'},
      {'key': 'dart', 'icon': 'assets/icons/dart.png', 'descKey': 'dart_description'},
    ],
    'Frameworks': [
      {'key': 'html5', 'icon': 'assets/icons/html.png', 'descKey': 'html5_description'},
      {'key': 'css3', 'icon': 'assets/icons/css-3.png', 'descKey': 'css3_description'},
      {'key': 'flutter', 'icon': 'assets/icons/flutter.png', 'descKey': 'flutter_description'},
      {'key': 'material_design', 'icon': 'assets/icons/materialdesign.png', 'descKey': 'material_design_description'},
    ],
    'Databases': [
      {'key': 'sql', 'icon': 'assets/icons/sql.png', 'descKey': 'sql_description'},
      {'key': 'firebase', 'icon': 'assets/icons/firebase.png', 'descKey': 'firebase_description'},
      {'key': 'supabase', 'icon': 'assets/icons/supabase.png', 'descKey': 'supabase_description'},
    ],
    'Tools': [
      {'key': 'git', 'icon': 'assets/icons/git.png', 'descKey': 'git_description'},
      {'key': 'github', 'icon': 'assets/icons/github.png', 'descKey': 'github_description'},
      {'key': 'vscode', 'icon': 'assets/icons/vscode.png', 'descKey': 'vscode_description'},
      {'key': 'figma', 'icon': 'assets/icons/figma.png', 'descKey': 'figma_description'},
    ],
    'OS': [
      {'key': 'linux', 'icon': 'assets/icons/linux.png', 'descKey': 'linux_description'},
    ],
  };

  final List<Map<String, dynamic>> _rawSoftSkills = [
    {'key': 'effective_teamwork_communication', 'icon': Icons.chat, 'descKey': 'effective_teamwork_communication_description'},
    {'key': 'problem_solving_analytical_thinking', 'icon': Icons.lightbulb, 'descKey': 'problem_solving_analytical_thinking_description'},
    {'key': 'autonomy_time_management', 'icon': Icons.access_time, 'descKey': 'autonomy_time_management_description'},
    {'key': 'curiosity_continuous_learning', 'icon': Icons.school, 'descKey': 'curiosity_continuous_learning_description'},
    {'key': 'adaptability_new_challenges', 'icon': Icons.refresh, 'descKey': 'adaptability_new_challenges_description'},
  ];

  late final LocaleController _localeController = Get.find<LocaleController>();

  @override
  void onInit() {
    super.onInit();
    ever(_localeController.locale, (_) => _translateSkills()); // React to LocaleController's locale
    print('SkillsController initialized with locale: ${_localeController.locale.value}');
  }

  @override
  void onReady() {
    super.onReady();
    _translateSkills(); // Initial translation after dependencies are ready
  }

  void refreshTranslations() {
    _translateSkills(); // Force re-translation
  }

  void _translateSkills() {
    print('Translating skills... Current locale: ${_localeController.locale.value}');
    try {
      translatedHardSkills.value = rawHardSkills.values.expand((category) => category).map((skill) {
        final name = _translateDebug(skill['key'] as String, skill['key'] as String);
        print('Translating hard skill: key=${skill['key']}, translated name=$name, final name=${name.isNotEmpty ? name : skill['key']}');
        return {'key': skill['key'], 'icon': skill['icon'], 'descKey': skill['descKey'], 'name': name.isNotEmpty ? name : skill['key']};
      }).toList();
      translatedSoftSkills.value = _rawSoftSkills.map((skill) {
        final name = _translateDebug(skill['key'] as String, skill['key'] as String);
        print('Translating soft skill: key=${skill['key']}, translated name=$name, final name=${name.isNotEmpty ? name : skill['key']}');
        return {'key': skill['key'], 'icon': skill['icon'], 'descKey': skill['descKey'], 'name': name.isNotEmpty ? name : skill['key']};
      }).toList();
      print('Translation successful. Hard skills: ${translatedHardSkills.length}, Soft skills: ${translatedSoftSkills.length}, Sample soft skill: ${translatedSoftSkills[0]['name']}');
    } catch (e) {
      print('Translation error in SkillsController: $e');
      translatedHardSkills.value = rawHardSkills.values.expand((category) => category).map((skill) => {
        'key': skill['key'],
        'icon': skill['icon'],
        'descKey': skill['descKey'],
        'name': '[Error: ${skill['key']}]'
      }).toList();
      translatedSoftSkills.value = _rawSoftSkills.map((skill) => {
        'key': skill['key'],
        'icon': skill['icon'],
        'descKey': skill['descKey'],
        'name': '[Error: ${skill['key']}]'
      }).toList();
    }
  }

  String _translateDebug(String key, String fallback) {
    print('Attempting to translate key: $key, current locale: ${_localeController.locale.value}');
    try {
      final translation = key.tr;
      print('Translation for $key: $translation (Locale: ${_localeController.locale.value})');
      return translation.isNotEmpty ? translation : fallback;
    } catch (e) {
      print('Translation failed for $key: $e (Locale: ${_localeController.locale.value})');
      return fallback;
    }
  }
}