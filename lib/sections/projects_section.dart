import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final scaleFactor = isSmallScreen ? 0.8 : 1.0;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 32 : 64,
        horizontal: isSmallScreen ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'projects'.tr,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 28 * scaleFactor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: isSmallScreen ? 16 : 32,
              runSpacing: isSmallScreen ? 16 : 32,
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: ProjectCard(
                    image: 'assets/images/project1.png',
                    title: 'project1_title'.tr,
                    description: 'project1_description'.tr,
                    url: 'https://github.com/your-github-username/dimacalm',
                    isSmallScreen: isSmallScreen,
                  ),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: ProjectCard(
                    image: 'assets/images/project2.jpeg',
                    title: 'project2_title'.tr,
                    description: 'project2_description'.tr,
                    url: 'https://github.com/your-github-username/mindfluent',
                    isSmallScreen: isSmallScreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
