import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storee/core/constants/auth_error_messages.dart';
import 'package:storee/core/constants/auth_success_messages.dart';
import 'package:storee/view/screens/auth/fogot_password_screen.dart';
import 'package:storee/view/screens/auth/signup_screen.dart';
import 'package:storee/view/screens/home_screen.dart';
import 'package:storee/core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A screen that handles user authentication through email/password
/// and various social sign-in methods (Google, Facebook, Apple).
/// Provides form validation and error handling for a smooth sign-in experience.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for form fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // UI state variables
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  // Service instances
  late final AuthService _authService;
  late final GoogleSignIn _googleSignIn;

  /// Regular expression for validating email format
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    _authService = AuthService(Supabase.instance.client);
    _initializeGoogleSignIn();
    _setupAuthListener();
  }

  /// Sets up authentication state listener to handle post-login navigation
  /// and success messages
  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn && mounted) {
        _showSuccessMessage(AuthSuccessMessages.signInSuccess);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  /// Displays a success message using a SnackBar
  void _showSuccessMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Updates the error message state
  void _showErrorMessage(String message) {
    setState(() => _errorMessage = message);
  }

  /// Validates email format and emptiness
  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AuthErrorMessages.emptyEmail;
    }
    if (!_emailRegex.hasMatch(email)) {
      return AuthErrorMessages.invalidEmail;
    }
    return null;
  }

  /// Validates password length and emptiness
  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AuthErrorMessages.emptyPassword;
    }
    if (password.length < 6) {
      return AuthErrorMessages.weakPassword;
    }
    return null;
  }

  /// Handles email/password sign-in process
  /// Validates inputs and shows appropriate error messages
  Future<void> _signIn() async {
    // Validate inputs
    final emailError = _validateEmail(_emailController.text.trim());
    if (emailError != null) {
      _showErrorMessage(emailError);
      return;
    }

    final passwordError = _validatePassword(_passwordController.text);
    if (passwordError != null) {
      _showErrorMessage(passwordError);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) {
        _showSuccessMessage(AuthSuccessMessages.signInSuccess);
      }
    } on AuthException catch (e) {
      _showErrorMessage(e.message == 'Invalid login credentials'
          ? AuthErrorMessages.invalidCredentials
          : e.message);
    } catch (e) {
      _showErrorMessage(AuthErrorMessages.networkError);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Handles Google sign-in process
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signInWithGoogle();
      if (mounted) {
        _showSuccessMessage(AuthSuccessMessages.googleSignInSuccess);
      }
    } catch (e) {
      _showErrorMessage(AuthErrorMessages.googleSignInFailed);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Handles Facebook sign-in process
  Future<void> _signInWithFacebook() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signInWithFacebook();
      if (mounted) {
        _showSuccessMessage(AuthSuccessMessages.facebookSignInSuccess);
      }
    } catch (e) {
      _showErrorMessage(AuthErrorMessages.facebookSignInFailed);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Handles Apple sign-in process
  Future<void> _signInWithApple() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signInWithApple();
      if (mounted) {
        _showSuccessMessage(AuthSuccessMessages.appleSignInSuccess);
      }
    } catch (e) {
      _showErrorMessage(AuthErrorMessages.appleSignInFailed);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Initializes Google Sign-In with appropriate client IDs
  /// based on platform (web or mobile)
  void _initializeGoogleSignIn() {
    if (kIsWeb) {
      _googleSignIn = GoogleSignIn(
        clientId: '479865992038-qmjm1nr21e0tf7r525ammkqpfq6a014u.apps.googleusercontent.com',
      );
    } else {
      _googleSignIn = GoogleSignIn(
        clientId: '479865992038-skv1g6s9f019ur45u6j5mu8dolqg6cfu.apps.googleusercontent.com',
        serverClientId: '479865992038-qmjm1nr21e0tf7r525ammkqpfq6a014u.apps.googleusercontent.com',
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                const SizedBox(height: 40),
                Text(
                  'Welcome Back 👋',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please sign in to continue',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),

                // Error message display
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red[800]),
                    ),
                  ),
                ],

                // Login form
                const SizedBox(height: 40),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'Email address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),

                // Forgot password link
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Sign in button
                const SizedBox(height: 24),
                _buildPrimaryButton(
                  onPressed: _isLoading ? null : _signIn,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),

                // Social sign-in section
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialButton(
                      onPressed: _signInWithGoogle,
                      icon: 'assets/icons/google.svg',
                      label: 'Google',
                    ),
                    _buildSocialButton(
                      onPressed: _signInWithFacebook,
                      icon: 'assets/icons/facebook.svg',
                      label: 'Facebook',
                    ),
                    if (!kIsWeb && Platform.isIOS)
                      _buildSocialButton(
                        onPressed: _signInWithApple,
                        icon: 'assets/icons/apple.svg',
                        label: 'Apple',
                      ),
                  ],
                ),

                // Sign up link
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a custom text field with consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(prefixIcon, color: Colors.grey[600]),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  /// Builds a primary button with consistent styling
  Widget _buildPrimaryButton({
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          disabledBackgroundColor: Colors.grey[400],
        ),
        child: child,
      ),
    );
  }

  /// Builds a social sign-in button with consistent styling

  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String icon,
    required String label,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
