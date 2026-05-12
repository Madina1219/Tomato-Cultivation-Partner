import 'package:firebase_auth/firebase_auth.dart';

/// Handles user identity. We use anonymous sign-in so the user has a stable
/// Firebase UID without needing to create an account. This UID becomes the
/// document key under /users/ in Firestore, and our security rules enforce
/// that only the signed-in user can access their own subtree.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// The currently signed-in user, or null if not signed in yet.
  User? get currentUser => _auth.currentUser;

  /// A stream that fires whenever the auth state changes (sign-in, sign-out).
  /// Useful for reactive UI that needs to know who the current user is.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Signs the user in anonymously if they aren't already signed in.
  /// Returns the resulting User object.
  Future<User?> signInAnonymouslyIfNeeded() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser;
    }
    final result = await _auth.signInAnonymously();
    return result.user;
  }

  /// Signs the user out. Useful for the "reset garden" flow.
  Future<void> signOut() => _auth.signOut();
}