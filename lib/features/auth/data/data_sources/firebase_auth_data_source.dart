import 'package:firebase_auth/firebase_auth.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/utils/app_exception.dart';

/// Firebase authentication data source
/// Handles all Firebase Auth API calls
class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Get auth state changes stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Sign in with email and password
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw AppException(AppStrings.errorGeneric);
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw AppException(_handleAuthException(e), code: e.code);
    } catch (e) {
      throw AppException(AppStrings.errorGeneric);
    }
  }

  /// Register with email and password
  Future<User> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw AppException(AppStrings.errorGeneric);
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw AppException(_handleAuthException(e), code: e.code);
    } catch (e) {
      throw AppException(AppStrings.errorGeneric);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AppException(AppStrings.errorGeneric);
    }
  }

  /// Handle Firebase Auth exceptions and return user-friendly messages
  String _handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'user-not-found':
        return AppStrings.errorUserNotFound;
      case 'wrong-password':
        return AppStrings.errorWrongPassword;
      case 'email-already-in-use':
        return AppStrings.errorEmailAlreadyInUse;
      case 'invalid-email':
        return AppStrings.errorInvalidEmail;
      case 'weak-password':
        return AppStrings.errorWeakPassword;
      case 'too-many-requests':
        return AppStrings.errorTooManyRequests;
      case 'network-request-failed':
        return AppStrings.errorNetwork;
      default:
        return AppStrings.errorGeneric;
    }
  }
}
