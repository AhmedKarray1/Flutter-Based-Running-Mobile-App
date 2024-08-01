import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';
import '../services/permission_service.dart';

final locationServiceProvider = Provider((ref) => LocationService());
final permissionServiceProvider = Provider((ref) => PermissionService());
