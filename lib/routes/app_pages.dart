import 'package:get/get.dart';
import 'package:portfolio1/sections/about_section.dart';
import 'package:portfolio1/sections/contact_section.dart';
import 'package:portfolio1/sections/projects_section.dart';
import '../sections/home_section.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/', page: () => HomeSection()),
    GetPage(name: '/projects', page: () => ProjectsSection()),
    GetPage(name: '/about', page: () => AboutSection()),
    GetPage(name: '/contact', page: () => ContactSection()),
  ];
}
