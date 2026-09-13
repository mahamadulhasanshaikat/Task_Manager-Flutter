import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/models/api_response.dart';
import 'package:task_manager/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/utils/widgets/screen_bg.dart';
import 'package:task_manager/views/login/login_page.dart';

class RegiPage extends StatefulWidget {
  const RegiPage({super.key});

  @override
  State<RegiPage> createState() => _RegiPageState();
}

class _RegiPageState extends State<RegiPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _onTapRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final ApiResponse response = await ApiCaller.postRequest(
      url: TMUrls.reqiUrl,
      body: {
        "email": _emailController.text.trim(),
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "mobile": _mobileController.text.trim(),
        "password": _passwordController.text,
      },
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (response.isSuccess && response.responseData['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Please login.'),
          backgroundColor: Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      final errorMessage =
          response.responseData is Map && response.responseData['data'] != null
          ? response.responseData['data'].toString()
          : 'Registration failed. Try again!';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _onTapLogin() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, size: 20, color: const Color(0xFF94A3B8)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0F172A), width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: ScreenBG(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 24.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Join With Us",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Create your account to start managing tasks",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                      decoration: _inputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icons.mail_outline_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value.trim());
                        if (!emailValid) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // First Name Field
                    TextFormField(
                      controller: _firstNameController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                      decoration: _inputDecoration(
                        hintText: 'First Name',
                        prefixIcon: Icons.person_outline_rounded,
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Please enter first name'
                          : null,
                    ),
                    const SizedBox(height: 14),

                    // Last Name Field
                    TextFormField(
                      controller: _lastNameController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                      decoration: _inputDecoration(
                        hintText: 'Last Name',
                        prefixIcon: Icons.person_outline_rounded,
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Please enter last name'
                          : null,
                    ),
                    const SizedBox(height: 14),

                    // Mobile Field
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                      decoration: _inputDecoration(
                        hintText: 'Mobile Number',
                        prefixIcon: Icons.phone_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter mobile number';
                        }
                        if (value.trim().length < 11) {
                          return 'Enter valid 11-digit mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _onTapRegistration(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                      decoration: _inputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: const Color(0xFF94A3B8),
                          ),
                          onPressed: () {
                            setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            );
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Registration Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isLoading ? null : _onTapRegistration,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Create Account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Footer Section
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTapLogin,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
