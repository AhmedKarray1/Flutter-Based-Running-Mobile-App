import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../states/auth_state.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthViewModel(this.authService) : super(const AuthState()) {
    authService.authStateChanges().listen((user) {
      state = state.copyWith(user: user);
    });
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await authService.signUp(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await authService.signIn(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    state = state.copyWith(user: null);
  }
}
