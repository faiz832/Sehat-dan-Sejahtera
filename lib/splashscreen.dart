import 'package:flutter/material.dart';
import 'package:slicing/beranda.dart';
import 'dart:async';

import 'package:slicing/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BerandaPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Image.asset(
          'images/apple.png', // Pastikan ada file gambar bernama logo.png di folder assets
          width: 100, // Sesuaikan ukuran gambar sesuai kebutuhan
          height: 100,
        ),
      ),
    );
  }
}
