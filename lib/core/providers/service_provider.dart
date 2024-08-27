import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/services/shared_preferences.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../services/permission_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final locationServiceProvider = Provider((ref) => LocationService());
final permissionServiceProvider = Provider((ref) => PermissionService());
final sharedPreferencesServiceProvider = Provider((ref) => SharedPreferencesService());
final authServiceProviders = Provider((ref) => AuthService( _auth));
