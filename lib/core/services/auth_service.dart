import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth authInstance;
  final FirebaseFirestore firebaseFirestore;

  AuthService(this.authInstance, this.firebaseFirestore);

  Future<User?> signUp(
      String username, String email, String password, int age) async {
    try {
      await authInstance.signOut();
      final userCredential = await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': username,
        'email': email,
        'age': age,
      });

      final AuthCredential authCredential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await authInstance.currentUser?.reload();

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
    } catch (e) {
      print('General error: $e');
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
