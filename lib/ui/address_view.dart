import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/ui/add_review.dart';
import 'package:laptop_harbor_app/ui/payment_view.dart';

class AddressView extends StatefulWidget {
  final List<String> cartItemIds;
  final double subtotal;
  final double total;
  final String userId;

  const AddressView({
    required this.cartItemIds,
    required this.subtotal,
    required this.total,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyFooterButtonWidget(
        nameController: _nameController,
        numberController: _numberController,
        emailController: _emailController,
        countryController: _countryController,
        cityController: _cityController,
        addressController: _addressController,
        userId: widget.userId,
        total: widget.total,
        subtotal: widget.subtotal,
        cartItemIds: widget.cartItemIds,
        // Pass userId from widget
      ),
      backgroundColor: Color(0xff1B262C),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 5.0,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Color(0xffF5F8FB),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Address",
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 7.0),
                Text(
                  "Name",
                  style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
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
                controller: _nameController,
                cursorColor: Color(0xff8F959E),
                style: TextStyle(color: Color(0xff8F959E)),
                decoration: InputDecoration(
                  hintText: "Type your name",
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
                  "Phone Number",
                  style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
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
                controller: _numberController,
                cursorColor: Color(0xff8F959E),
                style: TextStyle(color: Color(0xff8F959E)),
                decoration: InputDecoration(
                  hintText: "Type your number",
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
                  "Email",
                  style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
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
                controller: _emailController,
                cursorColor: Color(0xff8F959E),
                style: TextStyle(color: Color(0xff8F959E)),
                decoration: InputDecoration(
                  hintText: "Type your email",
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
                  "Country",
                  style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
                ),
                SizedBox(width: 2.0),
                Text(
                  "City",
                  style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
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
                      controller: _countryController,
                      cursorColor: Color(0xff8F959E),
                      style: TextStyle(color: Color(0xff8F959E)),
                      decoration: InputDecoration(
                        hintText: "Type your country",
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
                      controller: _cityController,
                      cursorColor: Color(0xff8F959E),
                      style: TextStyle(color: Color(0xff8F959E)),
                      decoration: InputDecoration(
                        hintText: "Type your city",
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 7.0),
                Text(
                  "Address",
                  style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Container(
              height: 145.0,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff222E34),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _addressController,
                cursorColor: Color(0xff8F959E),
                style: TextStyle(color: Color(0xff8F959E)),
                decoration: InputDecoration(
                  hintText: "Type your address",
                  hintStyle: TextStyle(color: Color(0xff8F959E)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyFooterButtonWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController emailController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController addressController;
  final String userId;
  final List<String> cartItemIds; // Add this property
  final double total; // Add this property
  final double subtotal; // Add this property

  MyFooterButtonWidget({
    required this.nameController,
    required this.numberController,
    required this.emailController,
    required this.countryController,
    required this.cityController,
    required this.addressController,
    required this.userId,
    required this.cartItemIds,
    required this.total,
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String name = nameController.text;
        String number = numberController.text;
        String email = emailController.text;
        String country = countryController.text;
        String city = cityController.text;
        String address = addressController.text;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentView(
              userId: userId,
              cartItemIds: cartItemIds, // Use the provided cartItemIds
              subtotal: subtotal, // Use the provided subtotal
              total: total, // Use the provided total
              name: name,
              number: number,
              email: email,
              country: country,
              city: city,
              address: address,
            ),
          ),
        );
      },
      child: Container(
        height: 90.0,
        color: Color(0xff9775FA),
        child: Center(
          child: Text(
            'Save Address',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
