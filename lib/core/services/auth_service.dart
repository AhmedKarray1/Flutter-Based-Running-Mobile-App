import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth authInstance;

  AuthService(this.authInstance);

  Future<User?> signUp(String email, String password) async {
    try {
      final userCredential = await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('signUp error: $e');
    }
    return null;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential = await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('signIn error: $e');
    }
    return null;
  }

  Future<void> signOut() async {
    await authInstance.signOut();
  }

  Stream<User?> authStateChanges() => authInstance.authStateChanges();
}
