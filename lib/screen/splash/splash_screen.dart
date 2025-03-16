import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../animations/loader_animation.dart';
import '../../data/common/common.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController loaderController;
  late Animation<double> loaderAnimation;

  @override
  void initState() {
    loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    loaderAnimation = Tween(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(parent: loaderController, curve: Curves.easeIn));
    loaderController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: loaderAnimation,
              builder: (context, child) {
                return AnimatedBuilder(
                  animation: loaderAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle:
                          loaderController.status == AnimationStatus.forward
                              ? (math.pi * 2) * loaderController.value
                              : -(math.pi * 2) * loaderController.value,

                      child: CustomPaint(
                        foregroundPainter: LoaderAnimation(
                          progress: loaderController.value,
                        ),
                        size: Size(300, 300),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            child: Center(
              child: Text(AppLocalizations.of(context)!.loadingData),
            ),
          ),
        ],
      ),
    );
  }
}
