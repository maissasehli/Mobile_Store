import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:storee/view/screens/success_screen.dart';
import 'package:storee/core/constants/auth_error_messages.dart';
import 'package:storee/core/constants/auth_success_messages.dart';

/// A screen that handles the password reset flow.
/// Allows users to request a password reset link via email.
/// Shows appropriate success/error messages and handles various edge cases.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Controllers and state variables
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEmailSent = false;
  bool _isLoading = false;
  String? _errorMessage;

  /// Handles the password reset request process.
  /// Validates the email, checks if it exists in the database,
  /// and sends a reset link if valid.
  Future<void> _resetPassword() async {
    if (!mounted) return;

    // Form validation
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check if email exists in database
      final response = await Supabase.instance.client
          .from('profiles')
          .select('email')
          .eq('email', email)
          .single();

      if (!mounted) return;

      // Handle non-existent email
      if (response.isEmpty) {
        setState(() {
          _errorMessage = AuthErrorMessages.accountNotFound;
          _isLoading = false;
        });
        return;
      }

      // Send password reset email
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.flutter://reset-callback/',
      );

      if (!mounted) return;

      setState(() {
        _isEmailSent = true;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      // Handle different types of errors
      String errorMessage;
      if (error is PostgrestException) {
        errorMessage = AuthErrorMessages.accountNotFound;
      } else if (error is AuthException) {
        switch (error.message) {
          case 'Email rate limit exceeded':
            errorMessage = AuthErrorMessages.operationCancelled;
            break;
          case 'Invalid email':
            errorMessage = AuthErrorMessages.invalidEmail;
            break;
          default:
            errorMessage = AuthErrorMessages.passwordResetFailed;
        }
      } else {
        errorMessage = AuthErrorMessages.unknownError;
      }

      setState(() {
        _errorMessage = errorMessage;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show success screen if email is sent
    if (_isEmailSent) {
      return SuccessScreen(
        email: _emailController.text,
        message: AuthSuccessMessages.passwordResetEmailSent,
        buttonText: 'Back to Sign In',
        onButtonPressed: () => Navigator.of(context).pop(),
      );
    }

    // Show password reset request form
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  // Title section
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Instructions text
                  Text(
                    'Enter your registered email address to receive password reset instructions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Email input field
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      letterSpacing: 0.1,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                        letterSpacing: 0.1,
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.black87, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red[400]!, width: 1),
                      ),
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                        color: Colors.grey[600],
                        size: 22,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AuthErrorMessages.emptyEmail;
                      }
                      if (!EmailValidator.validate(value)) {
                        return AuthErrorMessages.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  // Error message display
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3F2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red[600],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Send Reset Instructions',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}