import 'dart:async';
import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/ui/home_view.dart'; // Import your home view here
import 'package:laptop_harbor_app/ui/login_view.dart';
import 'package:laptop_harbor_app/ui/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a splash screen effect
    Timer(
      Duration(seconds: 2),
      () async {
        // Check if the user is already logged in
        if (FirebaseAuth.instance.currentUser != null) {
          // User is logged in, navigate to the home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } else {
          // User is not logged in, navigate to the register page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B262C),
      body: Center(
        child: Image.asset("assets/logo.png"),
      ),
    );
  }
}
