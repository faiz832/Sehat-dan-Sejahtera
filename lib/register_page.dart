import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slicing/bloc/register/register_cubit.dart';
import '../repositories/auth_repo.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider(
            create: (context) => RegisterCubit(AuthRepo(FirebaseAuth.instance)),
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
                                "Register",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.02,
                                  color: Colors.black,
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
                                keyboardType: TextInputType.emailAddress,
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

                                    // Simple validation for email and password
                                    if (email.isEmpty || password.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Email and password cannot be empty")),
                                      );
                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Enter a valid email address")),
                                      );
                                    } else {
                                      context.read<RegisterCubit>().register(email, password);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF407BFF), // Background color
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 132.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              BlocConsumer<RegisterCubit, RegisterState>(
                                listener: (context, state) {
                                  if (state is RegisterSuccess) {
                                    print("Registration successful");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginPage()),
                                    );
                                  } else if (state is RegisterFailure) {
                                    print("Registration failed: ${state.error}");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Registration failed: ${state.error}")),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is RegisterLoading) {
                                    return CircularProgressIndicator();
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(height: 16),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                },
                                child: Text(
                                  "Already have an account? Login",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Color(0xFF407BFF),
                                  ),
                                ),
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
}
