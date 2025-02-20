import 'package:flutter/material.dart';
import 'package:storee/view/screens/auth/login_screen.dart';
import 'package:storee/view/screens/success_screen.dart';
import 'package:storee/core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:storee/core/constants/auth_error_messages.dart';
import 'package:storee/core/constants/auth_success_messages.dart';

/// SignUpScreen widget that handles user registration
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for form fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // UI state variables
  bool _obscurePassword = true;        // Controls password visibility
  bool _obscureConfirmPassword = true; // Controls confirm password visibility
  bool _agreeToTerms = false;          // Terms and conditions checkbox state
  bool _isLoading = false;             // Loading state for API calls
  String? _errorMessage;               // Stores error messages to display to user

  // Authentication service instance
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    // Initialize auth service with Supabase client
    _authService = AuthService(Supabase.instance.client);
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles the sign-up process
  Future<void> _signUp() async {
    // Validate required fields
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = AuthErrorMessages.emptyEmail;
      });
      return;
    }

    // Ensure password meets minimum length requirement
    if (_passwordController.text.length < 6) {
      setState(() {
        _errorMessage = AuthErrorMessages.weakPassword;
      });
      return;
    }

    // Verify password confirmation matches
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = AuthErrorMessages.passwordMismatch;
      });
      return;
    }

    // Check terms acceptance
    if (!_agreeToTerms) {
      setState(() {
        _errorMessage = "Please agree to the Terms of Service and Privacy Policy";
      });
      return;
    }

    // Set loading state and clear any previous errors
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check if user already exists in the database
      try {
        await Supabase.instance.client
            .from('profiles')
            .select()
            .eq('email', _emailController.text.trim())
            .single();
            
        // User exists, show error
        setState(() {
          _errorMessage = AuthErrorMessages.accountExists;
          _isLoading = false;
        });
        return;
      } on PostgrestException {
        // User doesn't exist, continue with signup
      }

      // Proceed with user registration
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _nameController.text.trim(),
      );

      // Navigate to success screen if registration successful
      if (mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              email: _emailController.text.trim(),
              message: AuthSuccessMessages.emailVerificationSent,
              onButtonPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              buttonText: 'Go to Sign In',
            ),
          ),
        );
      }
    } on AuthException catch (error) {
      // Handle authentication-specific errors
      if (mounted) {
        setState(() {
          if (error.message.contains('already registered') || 
              error.message.contains('already exists')) {
            _errorMessage = AuthErrorMessages.accountExists;
          } else {
            _errorMessage = AuthErrorMessages.accountNotFound;
          }
        });
      }
    } catch (error) {
      // Handle general errors
      if (mounted) {
        setState(() {
          _errorMessage = AuthErrorMessages.accountNotFound;
        });
      }
    } finally {
      // Reset loading state
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Header section
                Text(
                  'Create Account ✨',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please fill in your details to get started',
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
                const SizedBox(height: 32),
                // Form fields
                _buildTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
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
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Terms and conditions checkbox
                _buildTermsCheckbox(),
                const SizedBox(height: 24),
                // Sign up button
                _buildPrimaryButton(
                  onPressed:
                      _isLoading ? null : (_agreeToTerms ? _signUp : null),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 30),
                // Sign in link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sign In',
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

  /// Builds the terms and conditions checkbox with text
  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: Colors.black,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
              children: const [
                TextSpan(
                  text: 'I agree to the ',
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
          disabledBackgroundColor: Colors.grey[300],
        ),
        child: child,
      ),
    );
  }
}