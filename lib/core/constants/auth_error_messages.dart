/// Provides centralized error messages for authentication-related operations
/// throughout the application. This ensures consistency in error messaging
/// and makes maintenance easier.
class AuthErrorMessages {
  // Private constructor to prevent instantiation
  const AuthErrorMessages._();

  /// Validation Errors
  static const String invalidEmail = 'Please enter a valid email address';
  static const String emptyEmail = 'Email address is required';
  static const String emptyPassword = 'Password is required';
  static const String weakPassword = 'Password must be at least 6 characters long';
  static const String passwordMismatch = 'Passwords do not match';
  
  /// Authentication Errors
  static const String invalidCredentials = 'Invalid email or password';
  static const String accountExists = 'An account with this email already exists';
  static const String accountNotFound = 'No account found with this email';
  
  /// Network Errors
  static const String networkError = 'Network error. Please check your connection';
  static const String serverError = 'Server error. Please try again later';
  
  /// Social Authentication Errors
  static const String googleSignInFailed = 'Google sign in failed. Please try again';
  static const String facebookSignInFailed = 'Facebook sign in failed. Please try again';
  static const String appleSignInFailed = 'Apple sign in failed. Please try again';
  
  /// Password Reset Errors
  static const String passwordResetFailed = 'Password reset failed. Please try again';
  static const String invalidResetLink = 'Invalid or expired password reset link';
  
  /// Session Errors
  static const String sessionExpired = 'Your session has expired. Please sign in again';
  static const String unauthorizedAccess = 'Unauthorized access. Please sign in';
  
  /// General Errors
  static const String unknownError = 'An unexpected error occurred. Please try again';
  static const String operationCancelled = 'Operation cancelled';
}