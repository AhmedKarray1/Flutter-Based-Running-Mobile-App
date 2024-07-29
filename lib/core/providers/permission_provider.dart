import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/permission_service.dart';

final permissionServiceProvider = Provider((ref) => PermissionService());

final locationPermissionProvider = FutureProvider<bool>((ref) async {
  final permissionService = ref.read(permissionServiceProvider);
  return permissionService.requestLocationPermission();
});

final locationPermissionStatusProvider = FutureProvider<PermissionStatus>((ref) async {
  final permissionService = ref.read(permissionServiceProvider);
  return permissionService.getLocationPermissionStatus();
});
