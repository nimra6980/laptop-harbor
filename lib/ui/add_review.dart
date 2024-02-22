import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddReview extends StatefulWidget {
  final String productId;

  const AddReview({Key? key, required this.productId}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  List<bool> _starStates = List.generate(5, (index) => false);
  double _rating = 0.0;

  void _toggleStar(int index) {
    setState(() {
      _starStates = List.generate(5, (i) => i <= index);
      _rating = index + 1.toDouble();
    });
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B262C),
      bottomNavigationBar: MyFooterButtonWidget(
        nameController: _nameController,
        reviewController: _reviewController,
        productId: widget.productId,
        rating: _rating,
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
                    "Reviews",
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
                fillColor: Color(0xff8F959E),
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
                "How was your experience?",
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
              controller: _reviewController,
              cursorColor: Color(0xff8F959E),
              style: TextStyle(color: Color(0xff8F959E)),
              decoration: InputDecoration(
                hintText: "Describe your experience?",
                fillColor: Color(0xff8F959E),
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
                "Ratings",
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
              SizedBox(width: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: () => _toggleStar(index),
                    child: Icon(
                      _starStates[index] ? Icons.star : Icons.star_border,
                      color: _starStates[index] ? Colors.amber : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final VoidCallback onPressed;

  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}

class MyFooterButtonWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController reviewController;
  final String productId;
  final double rating;

  MyFooterButtonWidget({
    required this.nameController,
    required this.reviewController,
    required this.productId,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String name = nameController.text;
        String review = reviewController.text;

        // Save the review data to Firestore
        try {
          await FirebaseFirestore.instance.collection('reviews').add({
            'name': name,
            'review': review,
            'productId': productId,
            'rating': rating,
          });
          print('Review added successfully');
        } catch (e) {
          print('Error adding review: $e');
        }

        // Navigate to the ReviewView page
      },
      child: Container(
        height: 90.0,
        color: Color(0xff9775FA),
        child: Center(
          child: Text(
            'Submit Review',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
