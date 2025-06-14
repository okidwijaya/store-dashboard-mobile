import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool agreeToTerms = false;

  bool get hasMinLength => passwordController.text.length >= 8;
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(passwordController.text);
  bool get hasUpperLower =>
      RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(passwordController.text);

  bool get isPasswordValid => hasMinLength && hasNumber && hasUpperLower;
  bool get isFormValid => isPasswordValid && agreeToTerms;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xFFFFE0EC), Colors.white],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 34),
              SvgPicture.asset(
                'assets/icon.svg',
                semanticsLabel: 'logo',
                height: 24,
                width: 24, // Optional: set a height for better visibility
              ),
              const SizedBox(height: 24),
              const Text(
                'Sign up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your email and password to sign up.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              const TextField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm your password',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 16),
              _buildRequirement(hasMinLength, 'At least 8 characters'),
              _buildRequirement(hasNumber, 'At least 1 number'),
              _buildRequirement(
                  hasUpperLower, 'Both upper and lower case letters'),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) =>
                        setState(() => agreeToTerms = value ?? false),
                  ),
                  const Expanded(
                    child: Text(
                      'By agreeing to the terms and conditions, you are entering into a legally binding contract with the service provider.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormValid
                      ? const Color(0xFFB6E76C)
                      : Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isFormValid
                    ? () {
                        // Submit action
                      }
                    : null,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Log in'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(bool met, String text) {
    return Row(
      children: [
        Icon(met ? Icons.check_circle : Icons.radio_button_unchecked,
            color: met ? Colors.green : Colors.grey, size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
