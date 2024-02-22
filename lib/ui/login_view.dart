import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/ui/home_view.dart';
import 'package:laptop_harbor_app/ui/register_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyFooterButtonWidget(
          nameController: _nameController,
          passwordController: _passwordController,
        ),
        backgroundColor: Color(0xff1B262C),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Welcome",
                style: TextStyle(
                    color: Color(0xffF5F8FB),
                    fontSize: 34,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Please enter your data to continue",
                style: TextStyle(
                    color: Color(0xff8F959E),
                    fontWeight: FontWeight.w400,
                    fontSize: 19),
              ),
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
                  SizedBox(height: 16.0),
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
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xffE96459)),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(),
                        ),
                      );
                    },
                    child: Text(
                      "Don't Have An Account?",
                      style: TextStyle(color: Color(0xff8F959E)),
                    )),
              ],
            ),
          ],
        ));
  }
}

class MyFooterButtonWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;

  MyFooterButtonWidget({
    required this.nameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Access the values entered by the user
        String email = nameController
            .text; // Assuming the username field is used for email
        String password = passwordController.text;

        try {
          // Sign in with email and password
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Login successful, navigate to the home view
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } catch (e) {
          // Login failed, handle the error
          print('Login failed: $e');
          // Show an error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed. Please try again.'),
            ),
          );
        }
      },
      child: Container(
        height: 90.0, // Set the height of the fixed footer
        color: Color(0xff9775FA), // Set the color of the fixed footer
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
