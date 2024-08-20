import 'package:health/health.dart';

class HealthService {
  Future<void> getHealthData() async {
    // define the types to get
    var types = [
      HealthDataType.STEPS,
      HealthDataType.BLOOD_GLUCOSE
    ];

    // requesting access to the data types before reading them
    bool requested = await Health().requestAuthorization(types);

    var now = DateTime.now();

    // fetch health data from the last 24 hours
    List<HealthDataPoint> healthData =
        await Health().getHealthDataFromTypes(startTime: now.subtract(Duration(days: 1)), endTime: now, types: types);

    // request permissions to write steps and blood glucose
    types = [HealthDataType.STEPS, HealthDataType.BLOOD_GLUCOSE];
    var permissions = [HealthDataAccess.READ_WRITE, HealthDataAccess.READ_WRITE];
    await Health().requestAuthorization(types, permissions: permissions);

    // write steps and blood glucose
    bool success = await Health().writeHealthData(value: 10, type: HealthDataType.STEPS, startTime: now, endTime: now);
    success =
        await Health().writeHealthData(value: 3.1, type: HealthDataType.BLOOD_GLUCOSE, startTime: now, endTime: now);

    // get the number of steps for today
    var midnight = DateTime(now.year, now.month, now.day);
    int? steps = await Health().getTotalStepsInInterval(midnight, now);
  }

}