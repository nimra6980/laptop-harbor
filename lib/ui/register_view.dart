import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_harbor_app/ui/home_view.dart';
import 'package:laptop_harbor_app/widgets/circle_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyFooterButtonWidget(
        nameController: _nameController,
        passwordController: _passwordController,
        emailController: _emailController,
      ),
      backgroundColor: Color(0xff1B262C),
      body: SafeArea(
        child: Column(
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
                      "Sign Up",
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 160,
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 16.0),
                      Text(
                        'Username',
                        style:
                            TextStyle(color: Color(0xff8F959E), fontSize: 20),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            20.0), // Adjust the horizontal padding as needed
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: Color.fromARGB(255, 208, 209, 211),
                      style: TextStyle(
                        color: Color.fromARGB(255, 208, 209, 211),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 208, 209, 211),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 208, 209, 211),
                              width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 208, 209, 211),
                              width: 1.0),
                        ),
                        suffixIcon: Icon(
                          Icons
                              .check, // You can change this to any icon you want
                          color: Color(0xff34C358),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 16.0),
                      Text(
                        'Email',
                        style:
                            TextStyle(color: Color(0xff8F959E), fontSize: 20),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            20.0), // Adjust the horizontal padding as needed
                    child: TextFormField(
                      controller: _emailController,
                      cursorColor: Color.fromARGB(255, 208, 209, 211),
                      style: TextStyle(
                        color: Color.fromARGB(255, 208, 209, 211),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 208, 209, 211),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 208, 209, 211),
                              width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 208, 209, 211),
                              width: 1.0),
                        ),
                        suffixIcon: Icon(
                          Icons
                              .email, // You can change this to any icon you want
                          color: Color(0xff34C358),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 16.0),
                      Text(
                        'Password',
                        style:
                            TextStyle(color: Color(0xff8F959E), fontSize: 20),
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
                              color: Color.fromARGB(255, 208, 209, 211),
                              width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 208, 209, 211),
                              width: 1.0),
                        ),
                        suffixIcon: Icon(
                          Icons
                              .lock, // You can change this to any icon you want
                          color: Color(0xff34C358),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 30,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Already Have An Account?",
                      style: TextStyle(color: Color(0xff8F959E)),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyFooterButtonWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;

  MyFooterButtonWidget({
    required this.nameController,
    required this.passwordController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Access the values entered by the user
        String name = nameController.text;
        String email = emailController.text;
        String password = passwordController.text;

        try {
          // Create a new user account with email and password
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Update user profile with the username
          await userCredential.user!.updateProfile(displayName: name);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration Completed.'),
            ),
          );
          // Registration successful, navigate to the home view
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } catch (e) {
          // Registration failed, handle the error
          print('Registration failed: $e');
          // Show an error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed. Please try again.'),
            ),
          );
        }
      },
      child: Container(
        height: 90.0, // Set the height of the fixed footer
        color: Color(0xff9775FA), // Set the color of the fixed footer
        child: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
