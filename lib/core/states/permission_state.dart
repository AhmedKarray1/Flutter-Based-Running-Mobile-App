class PermissionState {
  PermissionState({
    this.isLocationPermissionGranted = false,
  });

  final bool isLocationPermissionGranted;

  PermissionState copyWith({
    bool? isLocationPermissionGranted,
  }) {
    return PermissionState(
      isLocationPermissionGranted: isLocationPermissionGranted ?? this.isLocationPermissionGranted,
    );
  }
}
