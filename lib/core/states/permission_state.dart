import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class PermissionState {
  const PermissionState({
    this.permissionStatus = PermissionStatus.denied,
  });

  final PermissionStatus permissionStatus;

  PermissionState copyWith({
    PermissionStatus? permissionStatus,
  }) {
    return PermissionState(
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }
}
