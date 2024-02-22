import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_harbor_app/widgets/circle_button.dart';

class PasswordUpdate extends StatelessWidget {
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyFooterButtonWidget(
        passwordController: _passwordController,
      ),
      backgroundColor: Color(0xff1B262C),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 5.0,
              ),
              CircleIconButton(
                icon: Icons.arrow_back,
                iconColor: Color(0xffF5F8FB),
                circleColor: Color(0xff222E34),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Update Password",
                    style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 50), // Adjust as needed for spacing
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 16.0),
              Text(
                ' New Password',
                style: TextStyle(color: Color(0xff8F959E), fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              cursorColor: Color.fromARGB(255, 208, 209, 211),
              style: TextStyle(
                  color: Color.fromARGB(255, 208, 209, 211),
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 208, 209, 211), width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 208, 209, 211), width: 1.0),
                ),
                suffixIcon: Icon(
                  Icons.lock, // You can change this to any icon you want
                  color: Color(0xff34C358),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyFooterButtonWidget extends StatelessWidget {
  final TextEditingController passwordController;

  MyFooterButtonWidget({
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Get the new password from the text field
        String newPassword = passwordController.text;

        // Update the password using Firebase Auth
        try {
          // Get the current user using authStateChanges
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await user.updatePassword(newPassword);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password updated successfully.'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No user signed in.'),
              ),
            );
          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update password: $error'),
            ),
          );
        }
      },
      child: Container(
        height: 90.0, // Set the height of the fixed footer
        color: Color(0xff9775FA), // Set the color of the fixed footer
        child: Center(
          child: Text(
            'Update Password',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
