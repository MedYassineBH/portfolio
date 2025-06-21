import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

class TestTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {'about': 'About', 'test': 'Test Page'},
        'fr_FR': {'about': 'À propos', 'test': 'Page de test'},
      };
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD13zPrZ-UJ3Ac5pCb9C75H4iV9L33nuKw",
      authDomain: "portfolio-963dc.firebaseapp.com",
      projectId: "portfolio-963dc",
      storageBucket: "portfolio-963dc.appspot.com",
      messagingSenderId: "275496235896",
      appId: "1:275496235896:web:dc5da1643f3965162e4e8d",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Test App',
      translations: TestTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test'.tr)),
      body: Center(child: Text('about'.tr)),
    );
  }
}