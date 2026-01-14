import 'package:get/get.dart';
import 'package:health/health.dart';

class HomeController extends GetxController {
  var steps = 0.obs;
  var calories = 0.0.obs;

  final health = Health();

  @override
  void onInit() {
    super.onInit();
    fetchHealthData();
  }

  Future<void> fetchHealthData() async {
    try {
      bool isAvailable = await health.isHealthConnectAvailable();

      if (!isAvailable) {
        await health.installHealthConnect();
        return;
      }

      final types = [
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED,
      ];

      final permissions = [
        HealthDataAccess.READ,
        HealthDataAccess.READ,
      ];

      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      bool authorized = await health.requestAuthorization(
        types,
        permissions: permissions,
      );

      if (!authorized) return;

      final data = await health.getHealthDataFromTypes(
        types: types,
        startTime: yesterday,
        endTime: now,
      );

      steps.value = data
          .where((e) => e.type == HealthDataType.STEPS)
          .fold(0, (sum, e) => sum + (e.value as num).toInt());

      calories.value = data
          .where((e) => e.type == HealthDataType.ACTIVE_ENERGY_BURNED)
          .fold(0.0, (sum, e) => sum + (e.value as num));
    } catch (e) {
      print("Health error: $e");
    }
  }
}
