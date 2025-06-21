import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:async';

class GradientController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  var scrollVelocity = 0.0.obs;
  final Random _random = Random();
  Timer? _idleTimer;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), // Smooth scroll transitions
    )..addListener(() => update());
    _startIdleAnimation();
  }

  void _startIdleAnimation() {
    _idleTimer?.cancel();
    _idleTimer = Timer.periodic(Duration(seconds: 5 + _random.nextInt(6)), (_) {
      if (scrollVelocity.value < 0.5) {
        // Idle: Random direction, smooth transition
        final direction = _random.nextBool() ? 1.0 : -1.0;
        final targetValue = (animationController.value + direction * 0.1) % 1.0;
        animationController.animateTo(
          targetValue,
          duration: Duration(seconds: 5 + _random.nextInt(6)),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void updateScroll(double velocity, bool isDown) {
    scrollVelocity.value = velocity;
    if (velocity > 0.5) {
      // Scroll: Follow direction smoothly
      _idleTimer?.cancel(); // Pause idle animation
      final delta = (velocity / 1000) * (isDown ? 0.005 : -0.005);
      final newValue = (animationController.value + delta) % 1.0;
      animationController.value = newValue;
      _startIdleAnimation(); // Restart idle after scroll
    }
  }

  @override
  void onClose() {
    _idleTimer?.cancel();
    animationController.dispose();
    super.onClose();
  }
}
