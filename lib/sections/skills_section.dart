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

  // Categorize hard skills
  final Map<String, List<Map<String, dynamic>>> _rawHardSkills = {
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

  @override
  void initState() {
    super.initState();
    print('SkillsSection initializing...');
    // Pre-populate with raw data to ensure structure
    _translatedHardSkills = _rawHardSkills.values.expand((category) => category).map((skill) => Map<String, dynamic>.from(skill)).toList();
    _translatedSoftSkills = List<Map<String, dynamic>>.from(_rawSoftSkills);
    _translateSkills();
    if (mounted) setState(() {});
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
      for (var i = 0; i < _translatedHardSkills.length; i++) {
        final skill = _translatedHardSkills[i];
        final name = _translateDebug(skill['key'] as String, skill['key'] as String);
        print('Translating hard skill: key=${skill['key']}, original name=${skill['name']}, new name=$name');
        _translatedHardSkills[i]['name'] = name.isNotEmpty ? name : skill['key'];
      }
      for (var i = 0; i < _translatedSoftSkills.length; i++) {
        final skill = _translatedSoftSkills[i];
        final name = _translateDebug(skill['key'] as String, skill['key'] as String);
        print('Translating soft skill: key=${skill['key']}, original name=${skill['name']}, new name=$name');
        _translatedSoftSkills[i]['name'] = name.isNotEmpty ? name : skill['key'];
      }
      print('Translation successful. Hard skills: ${_translatedHardSkills.length}, Soft skills: ${_translatedSoftSkills.length}');
      if (mounted) setState(() {});
    } catch (e) {
      print('Translation error in SkillsSection: $e');
      for (var i = 0; i < _translatedHardSkills.length; i++) {
        _translatedHardSkills[i]['name'] = '[Error: ${_translatedHardSkills[i]['key']}]';
      }
      for (var i = 0; i < _translatedSoftSkills.length; i++) {
        _translatedSoftSkills[i]['name'] = '[Error: ${_translatedSoftSkills[i]['key']}]';
      }
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
    print('Building SkillsSection. Hard skills: ${_translatedHardSkills.length}, Sample: ${_translatedHardSkills.isNotEmpty ? _translatedHardSkills[0] : "Empty"}');
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

        final themeColor = Theme.of(context).colorScheme.onSurface; // Adaptive color based on theme

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_showHardSkills)
                        ..._rawHardSkills.entries.map((entry) {
                          final category = entry.key;
                          final skills = entry.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  category,
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth < 600 ? 16 : 20,
                                      ),
                                ),
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: wrapSpacing,
                                runSpacing: wrapRunSpacing,
                                children: skills.asMap().entries.map((skillEntry) {
                                  final skill = skills[skillEntry.key];
                                  final skillKey = skill['key'];
                                  final translatedSkill = _translatedHardSkills.firstWhere(
                                    (s) => s['key'] == skillKey,
                                    orElse: () => skill,
                                  );
                                  final skillIndex = _translatedHardSkills.indexWhere((s) => s['key'] == skillKey);
                                  if (skillIndex == -1) {
                                    print('Warning: No match found for skillKey: $skillKey in _translatedHardSkills. Available keys: ${_translatedHardSkills.map((s) => s['key']).toList()}');
                                  }
                                  return _buildSkillCard(context, translatedSkill, skillIndex >= 0 ? skillIndex : skillEntry.key, screenWidth, cardSize, themeColor);
                                }).toList(),
                              ),
                            ],
                          );
                        }),
                      if (!_showHardSkills)
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: wrapSpacing,
                          runSpacing: wrapRunSpacing,
                          children: _translatedSoftSkills.asMap().entries.map((entry) {
                            final skillIndex = entry.key + _translatedHardSkills.length;
                            final skill = entry.value;
                            return _buildSkillCard(context, skill, skillIndex, screenWidth, cardSize, themeColor);
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillCard(BuildContext context, Map<String, dynamic> skill, int index, double screenWidth, double cardSize, Color themeColor) {
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
                      skill['icon'] is String
                          ? ColorFiltered(
                              colorFilter: ColorFilter.mode(themeColor, BlendMode.srcIn), // Tint based on theme
                              child: Image.asset(
                                skill['icon'] as String,
                                width: screenWidth < 600 ? 18 : 26,
                                height: screenWidth < 600 ? 18 : 26,
                                fit: BoxFit.contain,
                                colorBlendMode: BlendMode.srcIn,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error, color: Colors.red);
                                },
                              ),
                            )
                          : Icon(
                              skill['icon'] as IconData,
                              size: screenWidth < 600 ? 18 : 26,
                              color: themeColor, // Adaptive color for Material Icons
                            ),
                      const SizedBox(height: 4),
                      Text(
                        skill['name'] as String,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: screenWidth < 600 ? 8 : 10,
                            ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
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
                maxLines: 10,
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            child: SingleChildScrollView(
              child: Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.visible,
                maxLines: maxLines,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
