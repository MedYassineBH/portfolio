import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _showHardSkills = true;
  final List<bool> _isHovered = List<bool>.filled(22, false); // Max of hard + soft skills
  OverlayEntry? _overlayEntry;

  final hardSkills = [
    {'name': 'Python', 'icon': Icons.code, 'descKey': 'python_description'},
    {'name': 'SQL', 'icon': Icons.storage, 'descKey': 'sql_description'},
    {'name': 'C', 'icon': Icons.code, 'descKey': 'c_description'},
    {'name': 'Java', 'icon': Icons.code, 'descKey': 'java_description'},
    {'name': 'PHP', 'icon': Icons.code, 'descKey': 'php_description'},
    {'name': 'HTML5', 'icon': Icons.html, 'descKey': 'html5_description'},
    {'name': 'CSS3', 'icon': Icons.css, 'descKey': 'css3_description'},
    {'name': 'Flutter', 'icon': Icons.flutter_dash, 'descKey': 'flutter_description'},
    {'name': 'Dart', 'icon': Icons.code, 'descKey': 'dart_description'},
    {'name': 'Material Design', 'icon': Icons.design_services, 'descKey': 'material_design_description'},
    {'name': 'Firebase', 'icon': Icons.cloud, 'descKey': 'firebase_description'},
    {'name': 'Supabase', 'icon': Icons.cloud_queue, 'descKey': 'supabase_description'},
    {'name': 'Git', 'icon': Icons.share, 'descKey': 'git_description'},
    {'name': 'GitHub', 'icon': Icons.code, 'descKey': 'github_description'},
    {'name': 'VS Code', 'icon': Icons.developer_mode, 'descKey': 'vscode_description'},
    {'name': 'Figma', 'icon': Icons.design_services, 'descKey': 'figma_description'},
    {'name': 'Linux', 'icon': Icons.terminal, 'descKey': 'linux_description'},
  ];

  final softSkills = [
    {'name': 'effective_teamwork_communication'.tr, 'icon': Icons.chat, 'descKey': 'effective_teamwork_communication_description'},
    {'name': 'problem_solving_analytical_thinking'.tr, 'icon': Icons.lightbulb, 'descKey': 'problem_solving_analytical_thinking_description'},
    {'name': 'autonomy_time_management'.tr, 'icon': Icons.access_time, 'descKey': 'autonomy_time_management_description'},
    {'name': 'curiosity_continuous_learning'.tr, 'icon': Icons.school, 'descKey': 'curiosity_continuous_learning_description'},
    {'name': 'adaptability_new_challenges'.tr, 'icon': Icons.refresh, 'descKey': 'adaptability_new_challenges_description'},
  ];

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showOverlay(BuildContext context, String description, Offset position) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 100,
        top: position.dy + 30,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF222831).withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Text(
              description.tr,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

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
            'skills'.tr,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 28 * scaleFactor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _showHardSkills = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showHardSkills ? const Color(0xFF00ADB5) : null,
                  foregroundColor: _showHardSkills ? Colors.white : null,
                  side: BorderSide(color: _showHardSkills ? Colors.transparent : const Color(0xFF00ADB5)),
                ),
                child: Text('hard_skills_title'.tr, style: TextStyle(fontSize: 14 * scaleFactor)),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => setState(() => _showHardSkills = false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !_showHardSkills ? const Color(0xFF00ADB5) : null,
                  foregroundColor: !_showHardSkills ? Colors.white : null,
                  side: BorderSide(color: !_showHardSkills ? Colors.transparent : const Color(0xFF00ADB5)),
                ),
                child: Text('soft_skills_title'.tr, style: TextStyle(fontSize: 14 * scaleFactor)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _buildSkillsDisplay(context, _showHardSkills ? hardSkills : softSkills, isSmallScreen, scaleFactor),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsDisplay(BuildContext context, List<Map<String, dynamic>> skills, bool isSmallScreen, double scaleFactor) {
    return SizedBox(
      key: ValueKey<bool>(_showHardSkills),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: isSmallScreen ? 8 : 16,
        runSpacing: isSmallScreen ? 8 : 16,
        children: skills.asMap().entries.map((entry) {
          final skillIndex = entry.key;
          final skill = entry.value;
          return _buildSkillCard(context, skill, skillIndex, isSmallScreen, scaleFactor);
        }).toList(),
      ),
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
      onEnter: (event) {
        setState(() => _isHovered[index] = true);
        _showOverlay(context, skill['descKey'], event.position);
      },
      onExit: (_) {
        setState(() => _isHovered[index] = false);
        _hideOverlay();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered[index] ? 1.05 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (_isHovered[index])
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              width: isSmallScreen ? 90 : 110,
              height: isSmallScreen ? 90 : 110,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    skill['icon'] as IconData,
                    size: isSmallScreen ? 22 : 28,
                    color: const Color(0xFF00ADB5),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    skill['name'] as String,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 11 * scaleFactor,
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
