import 'package:flutter/material.dart';
import 'package:uts/styles.dart';
import 'package:uts/widget/custom_textfield.dart';
import 'login_screen.dart'; // Import halaman LoginScreen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;

  // Variables to hold error messages
  String? usernameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  // Function to validate the form
  void _validateForm() {
    setState(() {
      usernameError = null;
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;

      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();

      // Check if any field is empty
      if (username.isEmpty) {
        usernameError = 'Username cannot be empty';
      }
      if (email.isEmpty) {
        emailError = 'Email cannot be empty';
      }
      if (password.isEmpty) {
        passwordError = 'Password cannot be empty';
      }
      if (confirmPassword.isEmpty) {
        confirmPasswordError = 'Confirm password cannot be empty';
      }

      // Check if passwords match
      if (password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          password != confirmPassword) {
        confirmPasswordError = 'Passwords do not match';
      }

      // If no errors, proceed with registration
      if (usernameError == null &&
          emailError == null &&
          passwordError == null &&
          confirmPasswordError == null) {
        // Simulate successful registration and navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyles.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/login.png'),
              const SizedBox(height: 24.0),
              Text(
                'Register Details',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),

              // Username field with error message
              CustomTextfield(
                controller: usernameController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                hint: 'Username',
              ),
              if (usernameError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    usernameError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 16.0),

              // Email field with error message
              CustomTextfield(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hint: 'Email',
              ),
              if (emailError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    emailError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 16.0),

              // Password field with error message
              CustomTextfield(
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                hint: 'Password',
                isObscure: isObscurePassword,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                },
              ),
              if (passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    passwordError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 16.0),

              // Confirm Password field with error message
              CustomTextfield(
                controller: confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hint: 'Confirm Password',
                isObscure: isObscureConfirmPassword,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscureConfirmPassword = !isObscureConfirmPassword;
                  });
                },
              ),
              if (confirmPasswordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    confirmPasswordError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 24.0),

              // Register button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkOlive,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: _validateForm, // Call validation function
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Register',
                    style: TextStyles.title.copyWith(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),
              Text(
                'Already have an account?',
                style: TextStyles.body.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () {
                  // Kembali ke layar login
                  Navigator.pop(context);
                },
                child: Text(
                  'Login',
                  style: TextStyles.body.copyWith(
                    fontSize: 18.0,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
