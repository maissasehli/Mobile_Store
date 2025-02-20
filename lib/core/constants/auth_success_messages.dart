/// Provides centralized success messages for authentication-related operations
/// throughout the application. This ensures consistency in user feedback
/// and makes maintenance easier.
class AuthSuccessMessages {
  // Private constructor to prevent instantiation
  const AuthSuccessMessages._();

  /// Authentication Success Messages
  static const String signInSuccess = 'Successfully signed in';
  static const String signUpSuccess = 'Account successfully created';
  static const String signOutSuccess = 'Successfully signed out';
  
  /// Social Authentication Success
  static const String googleSignInSuccess = 'Successfully signed in with Google';
  static const String facebookSignInSuccess = 'Successfully signed in with Facebook';
  static const String appleSignInSuccess = 'Successfully signed in with Apple';
  
  /// Password Management
  static const String passwordResetEmailSent = 'Password reset instructions sent to your email';
  static const String passwordChangeSuccess = 'Password successfully changed';
  static const String passwordResetSuccess = 'Password successfully reset';
  
  /// Profile Updates
  static const String profileUpdateSuccess = 'Profile successfully updated';
  static const String emailVerificationSent = 'Verification email sent';
  static const String emailVerificationSuccess = 'Email successfully verified';
  
  /// Account Management
  static const String accountDeletionSuccess = 'Account successfully deleted';
  static const String accountRecoverySuccess = 'Account successfully recovered';
  
  /// General Success
  static const String operationSuccess = 'Operation completed successfully';
  static const String dataSaved = 'Data saved successfully';
}