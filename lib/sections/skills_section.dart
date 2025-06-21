import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  final List<bool> _isHovered = List<bool>.filled(22, false);

  final hardSkills = [
    {'name': 'Python', 'icon': Icons.code},
    {'name': 'SQL', 'icon': Icons.storage},
    {'name': 'C', 'icon': Icons.code},
    {'name': 'Java', 'icon': Icons.code},
    {'name': 'PHP', 'icon': Icons.code},
    {'name': 'HTML5', 'icon': Icons.html},
    {'name': 'CSS3', 'icon': Icons.css},
    {'name': 'Flutter', 'icon': Icons.flutter_dash},
    {'name': 'Dart', 'icon': Icons.code},
    {'name': 'Material Design', 'icon': Icons.design_services},
    {'name': 'Firebase', 'icon': Icons.cloud},
    {'name': 'Supabase', 'icon': Icons.cloud_queue},
    {'name': 'Git', 'icon': Icons.share},
    {'name': 'GitHub', 'icon': Icons.code},
    {'name': 'VS Code', 'icon': Icons.developer_mode},
    {'name': 'Figma', 'icon': Icons.design_services},
    {'name': 'Linux', 'icon': Icons.terminal},
  ];

  final softSkills = [
    {'name': 'effective_teamwork_communication'.tr, 'icon': Icons.chat},
    {'name': 'problem_solving_analytical_thinking'.tr, 'icon': Icons.lightbulb},
    {'name': 'autonomy_time_management'.tr, 'icon': Icons.access_time},
    {'name': 'curiosity_continuous_learning'.tr, 'icon': Icons.school},
    {'name': 'adaptability_new_challenges'.tr, 'icon': Icons.refresh},
  ];

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
        children: [
          Text(
            'skills'.tr,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 28 * scaleFactor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSkillsColumn(
                      context: context,
                      title: 'hard_skills_title'.tr,
                      skills: hardSkills,
                      startIndex: 0,
                      isSmallScreen: isSmallScreen,
                      scaleFactor: scaleFactor,
                    ),
                    const SizedBox(height: 24),
                    _buildSkillsColumn(
                      context: context,
                      title: 'soft_skills_title'.tr,
                      skills: softSkills,
                      startIndex: hardSkills.length,
                      isSmallScreen: isSmallScreen,
                      scaleFactor: scaleFactor,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildSkillsColumn(
                        context: context,
                        title: 'hard_skills_title'.tr,
                        skills: hardSkills,
                        startIndex: 0,
                        isSmallScreen: isSmallScreen,
                        scaleFactor: scaleFactor,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildSkillsColumn(
                        context: context,
                        title: 'soft_skills_title'.tr,
                        skills: softSkills,
                        startIndex: hardSkills.length,
                        isSmallScreen: isSmallScreen,
                        scaleFactor: scaleFactor,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSkillsColumn({
    required BuildContext context,
    required String title,
    required List<Map<String, dynamic>> skills,
    required int startIndex,
    required bool isSmallScreen,
    required double scaleFactor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 20 * scaleFactor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: isSmallScreen ? 8 : 16,
          runSpacing: isSmallScreen ? 8 : 16,
          children: skills.asMap().entries.map((entry) {
            final skillIndex = startIndex + entry.key;
            final skill = entry.value;
            return _buildSkillCard(
              context,
              skill,
              skillIndex,
              isSmallScreen,
              scaleFactor,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillCard(
    BuildContext context,
    Map<String, dynamic> skill,
    int index,
    bool isSmallScreen,
    double scaleFactor,
  ) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered[index] = true),
      onExit: (_) => setState(() => _isHovered[index] = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scale(_isHovered[index] && !isSmallScreen ? 1.05 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (_isHovered[index] && !isSmallScreen)
              BoxShadow(
                color: const Color(0xFF00ADB5).withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: FadeInUp(
          duration: Duration(milliseconds: 500 + index * 100),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: isSmallScreen ? 100 : 120,
              height: isSmallScreen ? 100 : 120,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    skill['icon'] as IconData,
                    size: isSmallScreen ? 24 : 30,
                    color: const Color(0xFF00ADB5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    skill['name'] as String,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12 * scaleFactor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
