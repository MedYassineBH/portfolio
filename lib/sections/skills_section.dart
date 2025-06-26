import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _showHardSkills = true;
  final List<bool> _isHovered = List<bool>.filled(22, false); // Max of hard + soft skills
  late List<Map<String, dynamic>> _translatedHardSkills;
  late List<Map<String, dynamic>> _translatedSoftSkills;
  bool _hasError = false;

  final List<Map<String, dynamic>> _rawHardSkills = [
    {'key': 'python', 'icon': Icons.code, 'descKey': 'python_description'},
    {'key': 'sql', 'icon': Icons.storage, 'descKey': 'sql_description'},
    {'key': 'c', 'icon': Icons.code, 'descKey': 'c_description'},
    {'key': 'java', 'icon': Icons.code, 'descKey': 'java_description'},
    {'key': 'php', 'icon': Icons.code, 'descKey': 'php_description'},
    {'key': 'html5', 'icon': Icons.html, 'descKey': 'html5_description'},
    {'key': 'css3', 'icon': Icons.css, 'descKey': 'css3_description'},
    {'key': 'flutter', 'icon': Icons.flutter_dash, 'descKey': 'flutter_description'},
    {'key': 'dart', 'icon': Icons.code, 'descKey': 'dart_description'},
    {'key': 'material_design', 'icon': Icons.design_services, 'descKey': 'material_design_description'},
    {'key': 'firebase', 'icon': Icons.cloud, 'descKey': 'firebase_description'},
    {'key': 'supabase', 'icon': Icons.cloud_queue, 'descKey': 'supabase_description'},
    {'key': 'git', 'icon': Icons.share, 'descKey': 'git_description'},
    {'key': 'github', 'icon': Icons.code, 'descKey': 'github_description'},
    {'key': 'vscode', 'icon': Icons.developer_mode, 'descKey': 'vscode_description'},
    {'key': 'figma', 'icon': Icons.design_services, 'descKey': 'figma_description'},
    {'key': 'linux', 'icon': Icons.terminal, 'descKey': 'linux_description'},
  ];

  final List<Map<String, dynamic>> _rawSoftSkills = [
    {'key': 'effective_teamwork_communication', 'icon': Icons.chat, 'descKey': 'effective_teamwork_communication_description'},
    {'key': 'problem_solving_analytical_thinking', 'icon': Icons.lightbulb, 'descKey': 'problem_solving_analytical_thinking_description'},
    {'key': 'autonomy_time_management', 'icon': Icons.access_time, 'descKey': 'autonomy_time_management_description'},
    {'key': 'curiosity_continuous_learning', 'icon': Icons.school, 'descKey': 'curiosity_continuous_learning_description'},
    {'key': 'adaptability_new_challenges', 'icon': Icons.refresh, 'descKey': 'adaptability_new_challenges_description'},
  ];

  @override
  void initState() {
    super.initState();
    print('SkillsSection initializing...');
    _translatedHardSkills = [];
    _translatedSoftSkills = [];
    _translateSkills();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Dependencies changed, re-translating skills...');
    _translateSkills();
  }

  void _translateSkills() {
    print('Translating skills...');
    try {
      _translatedHardSkills.clear();
      _translatedSoftSkills.clear();
      _translatedHardSkills.addAll(_rawHardSkills.map((skill) {
        final name = _translateDebug(skill['key'] as String, skill['key'] as String);
        return {
          'name': name.isNotEmpty ? name : skill['key'],
          'icon': skill['icon'],
          'descKey': skill['descKey'],
        };
      }).toList());
      _translatedSoftSkills.addAll(_rawSoftSkills.map((skill) {
        final name = _translateDebug(skill['key'] as String, skill['key'] as String);
        return {
          'name': name.isNotEmpty ? name : skill['key'],
          'icon': skill['icon'],
          'descKey': skill['descKey'],
        };
      }).toList());
      print('Translation successful. Hard skills: ${_translatedHardSkills.length}, Soft skills: ${_translatedSoftSkills.length}');
    } catch (e) {
      print('Translation error in SkillsSection: $e');
      _translatedHardSkills.clear();
      _translatedSoftSkills.clear();
      _translatedHardSkills.addAll(_rawHardSkills.map((skill) => {
        'name': '[Error: ${skill['key']}]',
        'icon': skill['icon'],
        'descKey': skill['descKey'],
      }).toList());
      _translatedSoftSkills.addAll(_rawSoftSkills.map((skill) => {
        'name': '[Error: ${skill['key']}]',
        'icon': skill['icon'],
        'descKey': skill['descKey'],
      }).toList());
      setState(() => _hasError = true);
    }
  }

  String _translateDebug(String key, String fallback) {
    print('Attempting to translate key: $key');
    try {
      final translation = key.tr;
      print('Translation for $key: $translation');
      return translation.isNotEmpty ? translation : fallback;
    } catch (e) {
      print('Translation failed for $key: $e');
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      print('Rendering error fallback due to _hasError in SkillsSection');
      return Center(child: Text('An error occurred in SkillsSection. Please try again later.', style: TextStyle(fontSize: 18)));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        double cardSize, wrapSpacing, wrapRunSpacing, sectionHeight;

        if (screenWidth < 600) {
          cardSize = 85;
          wrapSpacing = 8;
          wrapRunSpacing = 8;
          sectionHeight = 300;
        } else if (screenWidth < 1200) {
          cardSize = 100;
          wrapSpacing = 12;
          wrapRunSpacing = 12;
          sectionHeight = 400;
        } else {
          cardSize = 120;
          wrapSpacing = 16;
          wrapRunSpacing = 16;
          sectionHeight = 500;
        }

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: screenWidth < 600 ? 32 : 64,
            horizontal: screenWidth < 600 ? 16 : 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _translateDebug('skills', 'Skills'),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: screenWidth < 600 ? 24 : 28,
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
                    child: Text(_translateDebug('hard_skills_title', 'Hard Skills'), style: TextStyle(fontSize: screenWidth < 600 ? 12 : 14)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => setState(() => _showHardSkills = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_showHardSkills ? const Color(0xFF00ADB5) : null,
                      foregroundColor: !_showHardSkills ? Colors.white : null,
                      side: BorderSide(color: !_showHardSkills ? Colors.transparent : const Color(0xFF00ADB5)),
                    ),
                    child: Text(_translateDebug('soft_skills_title', 'Soft Skills'), style: TextStyle(fontSize: screenWidth < 600 ? 12 : 14)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                key: ValueKey<bool>(_showHardSkills),
                width: double.infinity,
                height: sectionHeight,
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: wrapSpacing,
                    runSpacing: wrapRunSpacing,
                    children: (_showHardSkills ? _translatedHardSkills : _translatedSoftSkills).asMap().entries.map((entry) {
                      final skillIndex = entry.key;
                      final skill = entry.value;
                      return _buildSkillCard(context, skill, skillIndex, screenWidth, cardSize);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillCard(BuildContext context, Map<String, dynamic> skill, int index, double screenWidth, double cardSize) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered[index] = true),
      onExit: (_) => setState(() => _isHovered[index] = false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: cardSize,
            height: cardSize,
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
                  padding: EdgeInsets.all(screenWidth < 600 ? 6 : 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        skill['icon'] as IconData,
                        size: screenWidth < 600 ? 18 : 26,
                        color: const Color(0xFF00ADB5),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        skill['name'] as String,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: screenWidth < 600 ? 8 : 10,
                            ),
                        textAlign: TextAlign.center,
                        softWrap: true, // Allow text to wrap
                        overflow: TextOverflow.visible, // Prevent truncation
                        // Remove maxLines to allow full display
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isHovered[index] && mounted)
            Positioned.fill(
              child: AnimatedTooltip(
                description: _translateDebug(skill['descKey'], 'No description available'),
                maxLines: 10, // Increased to 10 for longer descriptions
              ),
            ),
        ],
      ),
    );
  }
}

class AnimatedTooltip extends StatelessWidget {
  final String description;
  final int maxLines;

  const AnimatedTooltip({super.key, required this.description, this.maxLines = 10});

  @override
  Widget build(BuildContext context) {
    print('Building AnimatedTooltip with description: $description');
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: BounceIn(
        duration: const Duration(milliseconds: 500),
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF00ADB5), const Color(0xFF222831)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ConstrainedBox( // Allow height to adjust based on content
            constraints: const BoxConstraints(
              minHeight: 50, // Minimum height to ensure visibility
            ),
            child: SingleChildScrollView(
              child: Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                softWrap: true, // Ensure text wraps
                overflow: TextOverflow.visible, // Prevent truncation
                maxLines: maxLines, // Allow up to 10 lines
              ),
            ),
          ),
        ),
      ),
    );
  }
}
