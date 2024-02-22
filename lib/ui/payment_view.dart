import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor_app/ui/add_review.dart';
import 'package:laptop_harbor_app/ui/confirmation_view.dart';

class PaymentView extends StatefulWidget {
  final List<String> cartItemIds;
  final double subtotal;
  final double total;
  final String userId;
  final String name;
  final String number;
  final String email;
  final String country;
  final String city;
  final String address;

  PaymentView({
    required this.cartItemIds,
    required this.subtotal,
    required this.total,
    required this.userId,
    required this.name,
    required this.number,
    required this.email,
    required this.country,
    required this.city,
    required this.address,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  TextEditingController _cardownerController = TextEditingController();
  TextEditingController _cardnumberController = TextEditingController();
  TextEditingController _expController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  late DateTime todayDate;
  late DateTime receivedDate;

  @override
  void initState() {
    super.initState();
    // Initialize today's date
    todayDate = DateTime.now();
    // Initialize received date to be two days after today's date
    receivedDate = todayDate.add(Duration(days: 2));
  }

  void deleteCartData(String userId) async {
    try {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('user_id', isEqualTo: userId)
          .get();

      for (DocumentSnapshot doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }

      print('Cart data deleted successfully for user ID: $userId');
    } catch (error) {
      print('Error deleting cart data: $error');
    }
  }

  void saveOrderToFirebase() async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': widget.userId,
        'cartItemIds': widget.cartItemIds,
        'subtotal': widget.subtotal,
        'total': widget.total,
        'name': widget.name,
        'number': widget.number,
        'email': widget.email,
        'country': widget.country,
        'city': widget.city,
        'address': widget.address,
        'cardOwner': _cardownerController.text,
        'cardNumber': _cardnumberController.text,
        'cvv': _cvvController.text,
        'exp': _expController.text,
        'todayDate': todayDate,
        'receivedDate': receivedDate,
      });
      deleteCartData(widget.userId);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConfirmationView()));

      // Order saved successfully
      print('Order saved successfully!');
    } catch (error) {
      // Handle error
      print('Error saving order: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B262C),
      bottomNavigationBar: MyFooterButtonWidget(
        onTap: saveOrderToFirebase,
      ),
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
                    "Payment",
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 150, // Adjust height as needed
                  child: Image.asset(
                    'assets/Card1.png', // Path to your image asset
                    fit: BoxFit.cover,
                  ),
                ),
                // Add more widgets here as needed
                Container(
                  height: 150, // Adjust height as needed
                  child: Image.asset(
                    'assets/Card2.png', // Path to your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 7.0),
              Text(
                "Card Owner",
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xff222E34),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _cardownerController,
              cursorColor: Color(0xff8F959E),
              style: TextStyle(color: Color(0xff8F959E)),
              decoration: InputDecoration(
                hintText: "Type card owner",
                hintStyle: TextStyle(color: Color(0xff8F959E)),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 7.0),
              Text(
                "Card Number",
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xff222E34),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _cardnumberController,
              cursorColor: Color(0xff8F959E),
              style: TextStyle(color: Color(0xff8F959E)),
              decoration: InputDecoration(
                hintText: "Type card number",
                hintStyle: TextStyle(color: Color(0xff8F959E)),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "EXP",
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(width: 2.0),
              Text(
                "CVV",
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff222E34),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _expController,
                    cursorColor: Color(0xff8F959E),
                    style: TextStyle(color: Color(0xff8F959E)),
                    decoration: InputDecoration(
                      hintText: "Type EXP",
                      hintStyle: TextStyle(color: Color(0xff8F959E)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff222E34),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _cvvController,
                    cursorColor: Color(0xff8F959E),
                    style: TextStyle(color: Color(0xff8F959E)),
                    decoration: InputDecoration(
                      hintText: "Type CVV",
                      hintStyle: TextStyle(color: Color(0xff8F959E)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              Text(
                "Today's Date: ${todayDate.toString().substring(0, 10)}",
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Received Date: ${receivedDate.toString().substring(0, 10)}",
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontWeight: FontWeight.w400,
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
  final VoidCallback onTap;

  MyFooterButtonWidget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90.0, // Set the height of the fixed footer
        color: Color(0xff9775FA), // Set the color of the fixed footer
        child: Center(
          child: Text(
            'Confirm Order',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
