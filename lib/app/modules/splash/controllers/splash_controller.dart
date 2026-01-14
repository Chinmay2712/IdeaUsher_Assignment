import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  var pinOffset = 0.0.obs;
  var logoOpacity = 0.0.obs;
  var showText = false.obs;

  @override
  void onInit() {
    super.onInit();
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    pinOffset.value = 57;

    await Future.delayed(const Duration(milliseconds: 900));

    logoOpacity.value = 1;

    await Future.delayed(const Duration(milliseconds: 600));

    showText.value = true;

    await Future.delayed(const Duration(milliseconds: 1200));

    Get.offAllNamed(Routes.HOME);
  }
}
