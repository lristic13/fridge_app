import 'package:firebase_auth/firebase_auth.dart';
import 'package:fridge_app/features/auth/data/data_sources/firebase_auth_data_source.dart';

/// Authentication repository
/// Abstracts the authentication data source for use in controllers
class AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepository({FirebaseAuthDataSource? dataSource})
      : _dataSource = dataSource ?? FirebaseAuthDataSource();

  /// Get current user
  User? get currentUser => _dataSource.currentUser;

  /// Get auth state changes stream
  Stream<User?> get authStateChanges => _dataSource.authStateChanges;

  /// Sign in with email and password
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    return await _dataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Register with email and password
  Future<User> register({
    required String email,
    required String password,
  }) async {
    return await _dataSource.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _dataSource.signOut();
  }
}
