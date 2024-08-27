import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class PermissionState {
  const PermissionState({
    this.locationPermissionStatus = PermissionStatus.denied,
    this.healthPermissionStatus = PermissionStatus.denied,
  });

  final PermissionStatus locationPermissionStatus;
  final PermissionStatus healthPermissionStatus;

  PermissionState copyWith({
    PermissionStatus? locationPermissionStatus,
    PermissionStatus? healthPermissionStatus,
  }) {
    return PermissionState(
      locationPermissionStatus:
          locationPermissionStatus ?? this.locationPermissionStatus,
      healthPermissionStatus:
          healthPermissionStatus ?? this.healthPermissionStatus,
    );
  }
}
