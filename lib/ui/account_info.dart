import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:laptop_harbor_app/widgets/circle_button.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    String? username = user?.displayName ?? 'N/A';
    String? email = user?.email ?? 'N/A';
    DateTime? joinDate = user?.metadata.creationTime;

    String formattedJoinDate =
        joinDate != null ? DateFormat.yMMMMd().format(joinDate) : 'N/A';

    return Scaffold(
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
                    "Account Information",
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
          Container(
            padding: EdgeInsets.all(20),
            width: 350,
            decoration: BoxDecoration(
              color: Color(0xff29363D),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Color(0xff9775FA),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Username: $username",
                      style: TextStyle(fontSize: 18, color: Color(0xffF5F8FB)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Color(0xff9775FA),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Email: $email",
                      style: TextStyle(fontSize: 18, color: Color(0xffF5F8FB)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Color(0xff9775FA),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Join Date: $formattedJoinDate",
                      style: TextStyle(fontSize: 18, color: Color(0xffF5F8FB)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
