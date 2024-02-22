import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/ui/add_review.dart';
import 'package:laptop_harbor_app/ui/home_view.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B262C),
      bottomNavigationBar: MyFooterButtonWidget(),
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
// Adjust as needed for spacing
            ],
          ),
          SizedBox(
            height: 200.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/confirm2.png",
                fit: BoxFit.cover,
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Order confirmed",
                  style: TextStyle(
                    color: Color(0xffF5F8FB),
                    fontSize: 44,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyFooterButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Access the values entered by the user

        // You can perform any actions with the entered data here

        // For now, let's just print them

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      },
      child: Container(
        height: 90.0, // Set the height of the fixed footer
        color: Color(0xff9775FA), // Set the color of the fixed footer
        child: Center(
          child: Text(
            'Continue Shopping',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
