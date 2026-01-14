import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SizedBox(
          height: 220,
          width: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Obx(() => AnimatedOpacity(
                opacity: controller.logoOpacity.value,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                child: Image.asset(
                  isDark
                      ? "assets/images/dark_logo.png"
                      : "assets/images/logo.png",
                  width: 220,
                ),
              )),

              Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOutCubic,
                left: 112 + controller.pinOffset.value,
                top: 72,
                child: Image.asset(
                  "assets/images/pin.png",
                  width: 84,
                ),
              )),

              Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                //curve: Curves.easeOut,
                top: 170,
                child: AnimatedOpacity(
                  opacity: controller.showText.value ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: const Text(
                    "Fitness",
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
