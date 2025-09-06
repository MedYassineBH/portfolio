import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Updated import for Rx
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio1/controllers/skills_controller.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with TickerProviderStateMixin {
  bool _showHardSkills = false;
  late List<bool> _isHovered;
  bool _isVisible = false;
  late List<AnimationController> _controllers;

  late final SkillsController skillsController = Get.find<SkillsController>()..onReady();

  @override
  void initState() {
    super.initState();
    print('SkillsSection initializing...');
    _initializeAnimations();
    _isHovered = List<bool>.filled(
      skillsController.translatedHardSkills.length + skillsController.translatedSoftSkills.length,
      false,
    );
  }

  void _initializeAnimations() {
    final totalSkills = skillsController.translatedHardSkills.length + skillsController.translatedSoftSkills.length;
    print('Initializing animations for $totalSkills skills');
    _controllers = List.generate(totalSkills, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      )..addStatusListener((status) {
        print('Controller $index status: $status');
      });
    });
  }

  @override
  void didUpdateWidget(covariant SkillsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newTotalSkills = skillsController.translatedHardSkills.length + skillsController.translatedSoftSkills.length;
    if (newTotalSkills != _controllers.length) {
      print('Skill count changed from ${_controllers.length} to $newTotalSkills, reinitializing animations');
      for (var controller in _controllers) {
        controller.dispose();
      }
      _initializeAnimations();
      _isHovered = List<bool>.filled(newTotalSkills, false);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startAnimationSequence() {
    final totalSkills = _showHardSkills
        ? skillsController.translatedHardSkills.length
        : skillsController.translatedSoftSkills.length;
    print('Starting animation sequence for $totalSkills skills (showing ${_showHardSkills ? "Hard" : "Soft"} skills)');
    // Reset all controllers before starting new sequence
    for (var controller in _controllers) {
      controller.reset();
    }
    for (int i = 0; i < totalSkills; i++) {
      if (i < _controllers.length) {
        Future.delayed(Duration(milliseconds: i * 200), () {
          if (mounted) {
            print('Forwarding controller $i for ${_showHardSkills ? "Hard" : "Soft"} skill');
            _controllers[i].forward();
          }
        });
      } else {
        print('Warning: Index $i exceeds _controllers length ${_controllers.length}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (skillsController.translatedSoftSkills.isEmpty || skillsController.translatedHardSkills.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    print('Building SkillsSection. Hard skills: ${skillsController.translatedHardSkills.length}, Soft skills: ${skillsController.translatedSoftSkills.length}, _showHardSkills: $_showHardSkills');
    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0 && !_isVisible) {
          print('Section became visible, triggering animation');
          setState(() {
            _isVisible = true;
            _startAnimationSequence();
          });
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          double cardWidth, wrapSpacing, wrapRunSpacing, paddingVertical, paddingHorizontal, titleFontSize, categoryFontSize, buttonFontSize, iconSize;

          double minDimension = screenWidth < screenHeight ? screenWidth : screenHeight;
          double baseWidth = 440;

          if (screenWidth >= 1200) {
            cardWidth = 120;
            wrapSpacing = 16;
            wrapRunSpacing = 16;
            paddingVertical = 64;
            paddingHorizontal = 32;
            titleFontSize = 28;
            categoryFontSize = 20;
            buttonFontSize = 14;
            iconSize = 26;
          } else if (screenWidth >= 600) {
            final scale = (screenWidth - 600) / (1200 - 600);
            cardWidth = (80 + (40 * scale)).roundToDouble().clamp(80, 120);
            wrapSpacing = (8 + (8 * scale)).roundToDouble().clamp(8, 16);
            wrapRunSpacing = (6 + (10 * scale)).roundToDouble().clamp(6, 16);
            paddingVertical = (30 + (34 * scale)).roundToDouble().clamp(30, 64);
            paddingHorizontal = (15 + (17 * scale)).roundToDouble().clamp(15, 32);
            titleFontSize = (20 + (8 * scale)).roundToDouble().clamp(20, 28);
            categoryFontSize = (14 + (6 * scale)).roundToDouble().clamp(14, 20);
            buttonFontSize = (9 + (5 * scale)).roundToDouble().clamp(9, 14);
            iconSize = (18 + (8 * scale)).roundToDouble().clamp(18, 26);
          } else {
            final scale = minDimension / baseWidth;
            cardWidth = (80 * scale).roundToDouble().clamp(80, 120);
            wrapSpacing = (4 * scale).roundToDouble().clamp(4, 12);
            wrapRunSpacing = (1 * scale).roundToDouble().clamp(1, 10);
            paddingVertical = (15 * scale).roundToDouble();
            paddingHorizontal = (8 * scale).roundToDouble();
            titleFontSize = (16 * scale).roundToDouble().clamp(12, 20);
            categoryFontSize = (12 * scale).roundToDouble().clamp(10, 16);
            buttonFontSize = (10 * scale).roundToDouble().clamp(8, 12);
            iconSize = (20 * scale).roundToDouble().clamp(18, 24);
          }

          print('Debug: screenWidth = $screenWidth, screenHeight = $screenHeight, scale = ${minDimension / baseWidth}');
          final themeColor = Theme.of(context).colorScheme.onSurface;

          return Container(
            padding: EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _translateDebug('skills', 'Skills'),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: titleFontSize,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 700),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Switching to Hard Skills');
                          setState(() {
                            _showHardSkills = true;
                            _startAnimationSequence();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _showHardSkills ? const Color(0xFF00ADB5) : Colors.transparent,
                          foregroundColor: _showHardSkills ? Colors.white : themeColor,
                          side: BorderSide(color: _showHardSkills ? Colors.transparent : const Color(0xFF00ADB5), width: 2),
                          padding: EdgeInsets.symmetric(
                            vertical: paddingVertical * 0.1,
                            horizontal: paddingHorizontal * 0.3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(_translateDebug('hard_skills', 'Hard Skills'), style: TextStyle(fontSize: buttonFontSize)),
                      ),
                    ),
                    SizedBox(width: wrapSpacing),
                    AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 700),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Switching to Soft Skills');
                          setState(() {
                            _showHardSkills = false;
                            _startAnimationSequence();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !_showHardSkills ? const Color(0xFF00ADB5) : Colors.transparent,
                          foregroundColor: !_showHardSkills ? Colors.white : themeColor,
                          side: BorderSide(color: !_showHardSkills ? Colors.transparent : const Color(0xFF00ADB5), width: 2),
                          padding: EdgeInsets.symmetric(
                            vertical: paddingVertical * 0.1,
                            horizontal: paddingHorizontal * 0.3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(_translateDebug('soft_skills', 'Soft Skills'), style: TextStyle(fontSize: buttonFontSize)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (_showHardSkills)
                  ...skillsController.rawHardSkills.entries.map((entry) {
                    final category = entry.key;
                    final skills = entry.value;
                    int categoryIndex = skillsController.rawHardSkills.keys.toList().indexOf(category);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          opacity: _isVisible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500 + (categoryIndex * 300)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: wrapRunSpacing),
                            child: Text(
                              category,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: categoryFontSize,
                                  ),
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
                            final translatedSkill = skillsController.translatedHardSkills.firstWhere(
                              (s) => s['key'] == skillKey,
                              orElse: () => skill,
                            );
                            final skillIndex = skillsController.translatedHardSkills.indexWhere((s) => s['key'] == skillKey);
                            if (skillIndex == -1 || skillIndex >= _controllers.length) {
                              print('Warning: Invalid skillIndex $skillIndex for skillKey: $skillKey. _controllers length: ${_controllers.length}');
                              return SizedBox.shrink();
                            }
                            return FadeTransition(
                              opacity: _controllers[skillIndex],
                              child: _buildSkillCard(context, translatedSkill, skillIndex, screenWidth, cardWidth, themeColor, iconSize),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }),
                if (!_showHardSkills)
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: wrapSpacing,
                    runSpacing: screenWidth < 600 ? wrapRunSpacing * 1.1 : wrapRunSpacing,
                    children: List.generate(skillsController.translatedSoftSkills.length, (index) {
                      final skill = skillsController.translatedSoftSkills[index];
                      final skillIndex = index;
                      if (skillIndex >= _controllers.length) {
                        print('Warning: Soft skill index $skillIndex out of range. _controllers length: ${_controllers.length}');
                        return SizedBox.shrink();
                      }
                      print('Rendering soft skill: ${skill['name']} at index $index');
                      return FadeTransition(
                        opacity: _controllers[skillIndex],
                        child: _buildSkillCard(context, skill, skillIndex, screenWidth, cardWidth, themeColor, iconSize),
                      );
                    }),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, Map<String, dynamic> skill, int index, double screenWidth, double cardWidth, Color themeColor, double iconSize) {
    double minDimension = screenWidth;
    double baseWidth = 440;
    final scale = minDimension / baseWidth;
    if (index >= _isHovered.length) {
      print('Warning: Skill index $index out of range for _isHovered. Length: ${_isHovered.length}. Skipping card.');
      return SizedBox.shrink();
    }
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered[index] = true),
      onExit: (_) => setState(() => _isHovered[index] = false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: cardWidth,
            height: cardWidth,
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
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: EdgeInsets.all(screenWidth < 600 ? 4 : 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    skill['icon'] is String
                        ? ColorFiltered(
                            colorFilter: ColorFilter.mode(themeColor, BlendMode.srcIn),
                            child: Image.asset(
                              skill['icon'] as String,
                              width: iconSize,
                              height: iconSize,
                              fit: BoxFit.contain,
                              colorBlendMode: BlendMode.srcIn,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error, color: Colors.red);
                              },
                            ),
                          )
                        : Icon(
                            skill['icon'] as IconData,
                            size: iconSize,
                            color: themeColor,
                          ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        skill['name'] as String,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: screenWidth < 600 ? (6 * scale).roundToDouble().clamp(6, 8) : 10,
                            ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: null,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isHovered[index] && mounted)
            Positioned.fill(
              child: AnimatedTooltip(
                description: _translateDebug(skill['descKey'] as String, 'No description available'),
                maxLines: null,
              ),
            ),
        ],
      ),
    );
  }

  String _translateDebug(String key, String fallback) {
    print('Attempting to translate key: $key, current locale: ${Get.locale}');
    try {
      final translation = key.tr;
      print('Translation for $key: $translation (Locale: ${Get.locale})');
      return translation.isNotEmpty ? translation : fallback;
    } catch (e) {
      print('Translation failed for $key: $e (Locale: ${Get.locale})');
      return fallback;
    }
  }
}

class AnimatedTooltip extends StatelessWidget {
  final String description;
  final int? maxLines;

  const AnimatedTooltip({super.key, required this.description, this.maxLines});

  @override
  Widget build(BuildContext context) {
    print('Building AnimatedTooltip with description: $description');
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(8),
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
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Text(
          description,
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.visible,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
