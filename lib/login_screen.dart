import 'package:flutter/material.dart';
import 'package:uts/splash_screen.dart'; // Import halaman SplashScreen
import 'package:uts/styles.dart';
import 'package:uts/widget/custom_textfield.dart';
import 'register_screen.dart';
import 'package:uts/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  // Variables to hold error messages
  String? emailError;
  String? passwordError;

  // Function to validate login form
  void _validateLogin() {
    setState(() {
      emailError = null; // Reset errors
      passwordError = null;

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        emailError = 'Email cannot be empty';
      }

      if (password.isEmpty) {
        passwordError = 'Password cannot be empty';
      }

      // Jika tidak ada error, navigasi ke Dashboard dan kirim data email serta password
      if (emailError == null && passwordError == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              email: email,
              password: password,
            ),
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
          'Login',
          style: TextStyles.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigasi kembali ke SplashScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ),
            );
          },
        ),
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
                'Login Details',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),

              // Username field with error
              CustomTextfield(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hint: 'Email or Username',
              ),
              if (emailError != null) // Show error text if username is empty
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    emailError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 16.0),

              // Password field with error
              CustomTextfield(
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hint: 'Password',
                isObscure: isObscure,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              if (passwordError != null) // Show error text if password is empty
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    passwordError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 8.0),
              Text('Forgot Password?', style: TextStyles.body),
              const SizedBox(height: 24.0),

              // Login button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkOlive,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                onPressed: _validateLogin, // Call validation on button press
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Login',
                    style: TextStyles.title
                        .copyWith(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),
              Text(
                'Don\'t have an Account?',
                style: TextStyles.body.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke RegisterScreen saat tombol Sign Up ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  'Sign Up',
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
