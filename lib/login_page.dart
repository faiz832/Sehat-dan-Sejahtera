import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slicing/bloc/login/login_cubit.dart';
import 'register_page.dart';
import '../repositories/auth_repo.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider(
            create: (context) => LoginCubit(AuthRepo(FirebaseAuth.instance)),
            child: Builder(
              builder: (context) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 80),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Hello Again!",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.02,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Welcome back to Sehat Sejahtera",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 50),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final email = _emailController.text;
                                    final password = _passwordController.text;
                                    context
                                        .read<LoginCubit>()
                                        .logIn(email, password);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF407BFF),
                                    // Background color
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 132.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              BlocConsumer<LoginCubit, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginSuccess) {
                                    print("Login successful");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  } else if (state is LoginFailure) {
                                    print("Login failed: ${state.error}");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Login failed: ${state.error}")),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginLoading) {
                                    return CircularProgressIndicator();
                                  }
                                  return Container();
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      "Or Login with",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Color(0x6A707CA6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialLoginButton("images/google.png",
                                      () {
                                    // Handle Google login
                                  }),
                                  SizedBox(width: 16),
                                  _buildSocialLoginButton("images/facebook.png",
                                      () {
                                    // Handle Facebook login
                                  }),
                                  SizedBox(width: 16),
                                  _buildSocialLoginButton("images/apple.png",
                                      () {
                                    // Handle Apple login
                                  }),
                                ],
                              ),
                              SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()),
                                      );
                                    },
                                    child: Text(
                                      "Register Now",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Color(0xFF407BFF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }

        // Display loading indicator while waiting for Firebase to initialize
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSocialLoginButton(String assetName, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 85,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFE8ECF4),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color(0xFFE8ECF4),
          ),
        ),
        child: Center(
          child: Image.asset(assetName, width: 40, height: 40),
        ),
      ),
    );
  }
}
