import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const BoozinApp());
}

class BoozinApp extends StatelessWidget {
  const BoozinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Boozin Fitness",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
    );
  }
}
