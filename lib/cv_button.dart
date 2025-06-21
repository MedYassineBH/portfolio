import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CVButton extends StatelessWidget {
  const CVButton({super.key});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final scaleFactor = isSmallScreen ? 0.8 : 1.0;
    final cvUrl = Get.locale!.languageCode == 'fr'
        ? 'https://drive.google.com/file/d/1QBpMZ5olbdBRloAd3MeAgnrzoMyS82wX/view?usp=drive_link'
        : 'https://drive.google.com/file/d/1wGo95pDd5CzRFt8y8Alm-uPZT0jPTo2v/view?usp=drive_link';
    return ElevatedButton(
      onPressed: () => _launchURL(cvUrl),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00ADB5),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 6 : 8,
        ),
      ),
      child: Text(
        'cv_button'.tr,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14 * scaleFactor,
        ),
      ),
    );
  }
}
