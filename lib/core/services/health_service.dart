import 'package:health/health.dart';

class HealthService {
  Future<int?> getHealthData() async {
    // define the types to get
    var types = [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED];

    var now = DateTime.now();

    List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        startTime: now.subtract(const Duration(days: 4)),
        endTime: now,
        types: types);

    var midnight = DateTime(now.year, now.month, now.day);
    

    final steps = Health().getTotalStepsInInterval(midnight, now);
    return steps;
  }
}
