import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/providers/service_provider.dart';
import 'package:running_app/core/states/location_state.dart';
import 'package:running_app/core/states/permission_state.dart';

import '../viewmodels/location_view_model.dart';
import '../viewmodels/permission_view_model.dart';

final locationViewModelProvider =
    StateNotifierProvider<LocationViewModel, LocationState>(
  (ref) => LocationViewModel(ref.read(locationServiceProvider)),
);
final permissionViewModelProvider =
    StateNotifierProvider<PermissionViewmodel, PermissionState>(
  (ref) => PermissionViewmodel(ref.read(permissionServiceProvider),
      ref.read(sharedPreferencesServiceProvider)),
);
