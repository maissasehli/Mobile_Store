import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Service class that handles all authentication operations
/// Supports email/password, Google, Facebook, and Apple sign-in methods
/// Uses Supabase as the backend authentication provider
class AuthService {
  final SupabaseClient _supabaseClient;
  late final GoogleSignIn _googleSignIn;
  bool _isInitialized = false;

  // OAuth client IDs for Google authentication
  static const String webClientId =
    '479865992038-qmjm1nr21e0tf7r525ammkqpfq6a014u.apps.googleusercontent.com';
  static const String iosClientId =
    '479865992038-skv1g6s9f019ur45u6j5mu8dolqg6cfu.apps.googleusercontent.com';

  /// Constructor that initializes the service with a Supabase client
  /// and sets up Google Sign-In
  AuthService(this._supabaseClient) {
    _initializeGoogleSignIn();
  }

  /// Initializes Google Sign-In with appropriate client IDs and scopes
  /// Different configuration for web and mobile platforms
  void _initializeGoogleSignIn() {
    if (_isInitialized) return;
    _isInitialized = true;

    if (kIsWeb) {
      // Web-specific Google Sign-In configuration
      _googleSignIn = GoogleSignIn(
        clientId: webClientId,
        scopes: ['email', 'profile'],
      );
    } else {
      // Mobile-specific Google Sign-In configuration
      _googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
        scopes: ['email', 'profile'],
      );
    }
  }

  /// Getter for the currently authenticated user
  User? get currentUser => _supabaseClient.auth.currentUser;

  /// Signs up a new user with email and password
  /// [email] - User's email address
  /// [password] - User's password
  /// [fullName] - User's full name stored in user metadata
  /// Throws an exception if signup fails
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
      
      if (response.user == null) {
        throw Exception(
          'Failed to sign up: ${response.session != null ? 'Email confirmation required' : 'Unknown error'}'
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Signs in an existing user with email and password
  /// [email] - User's email address
  /// [password] - User's password
  /// Throws an exception if signin fails
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user == null) {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Handles Google Sign-In flow
  /// 1. Authenticates with Google
  /// 2. Gets Google tokens
  /// 3. Signs in to Supabase with Google credentials
  /// Handles both web and mobile platforms
  /// Throws an exception if any step fails
  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser;
      
      if (kIsWeb) {
        googleUser = await _googleSignIn.signIn();
      } else {
        googleUser = await _googleSignIn.signIn();
      }

      if (googleUser == null) {
        throw Exception('Sign in cancelled by user');
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        throw Exception('Could not get ID token');
      }

      final response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw Exception('Failed to sign in with Google');
      }
    } catch (e) {
      // Clean up Google sign-in state if authentication fails
      await _googleSignIn.signOut().catchError((error) {
        return null;
      });
      throw Exception('Google sign in failed: $e');
    }
  }

  /// Handles Facebook Sign-In flow
  /// 1. Authenticates with Facebook
  /// 2. Gets Facebook access token
  /// 3. Signs in to Supabase with Facebook credentials
  /// Throws an exception if any step fails
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status != LoginStatus.success) {
        throw Exception('Facebook login failed or was cancelled');
      }

      final AccessToken? accessToken = loginResult.accessToken;
      
      if (accessToken == null) {
        throw Exception('Failed to get Facebook access token');
      }

      // Get the token string representation
      final String tokenString = accessToken.toString();

      // Sign in with Supabase using the Facebook token
      final response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.facebook,
        idToken: tokenString,
        accessToken: tokenString,
      );

      if (response.user == null) {
        throw Exception('Failed to sign in with Facebook');
      }
    } catch (e) {
      // Clean up Facebook sign-in state if authentication fails
      await FacebookAuth.instance.logOut().catchError((error) {
        debugPrint('Facebook logout error: $error');
        return null;
      });
      throw Exception('Facebook sign in failed: $e');
    }
  }

  /// Handles Apple Sign-In flow
  /// 1. Authenticates with Apple
  /// 2. Gets Apple credentials
  /// 3. Signs in to Supabase with Apple credentials
  /// Throws an exception if any step fails
  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken == null) {
        throw Exception('Failed to get Apple identity token');
      }

      final response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: credential.identityToken!,
        accessToken: credential.authorizationCode,
      );

      if (response.user == null) {
        throw Exception('Failed to sign in with Apple');
      }
    } catch (e) {
      throw Exception('Apple sign in failed: $e');
    }
  }

  /// Signs out the user from all authentication providers
  /// Handles cleanup for Google, Facebook, and Supabase sessions
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await _supabaseClient.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}