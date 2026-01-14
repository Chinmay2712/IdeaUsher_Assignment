import 'package:boozin_fitness/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hi!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              Obx(() => _HealthCard(
                title: "Steps",
                value: controller.steps.value.toDouble(),
                goal: 15000,
                iconPath: isDark
                    ? "assets/images/dark_steps.png"
                    : "assets/images/steps.png",
                isDark: isDark,
              )),

              const SizedBox(height: 20),

              Obx(() => _HealthCard(
                title: "Calories Burned",
                value: controller.calories.value,
                goal: 1000,
                iconPath: isDark
                    ? "assets/images/dark_kcal.png"
                    : "assets/images/kcal.png",
                isDark: isDark,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  final String title;
  final double value;
  final double goal;
  final String iconPath;
  final bool isDark;

  const _HealthCard({
    required this.title,
    required this.value,
    required this.goal,
    required this.iconPath,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (value / goal).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F2F2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "$title: ",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: value.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: 14,
                        backgroundColor:
                        isDark ? Colors.grey.shade800 : Colors.grey.shade400,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("0", style: TextStyle(fontSize: 12)),
                    Text(
                      "Goal: ${goal.toInt()}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          Image.asset(
            iconPath,
            width: 48,
            height: 48,
          ),
        ],
      ),
    );
  }
}

