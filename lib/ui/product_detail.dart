import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor_app/ui/add_review.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  final String brand;
  final String description;
  final String image;
  final String name;
  final double price;

  ProductDetailPage({
    required this.id,
    required this.brand,
    required this.description,
    required this.image,
    required this.name,
    required this.price,
  });
  void addToCart(BuildContext context) async {
    try {
      // Get the current user ID
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      // Check if the user is logged in
      if (userId != null) {
        // Add the product to the cart table in Firestore
        await FirebaseFirestore.instance.collection('cart').add({
          'product_brand': brand,
          'product_desc': description,
          'product_id': id,
          'product_image': image,
          'product_name': name,
          'product_price': price.toString(),
          'user_id': userId,
        });

        // Show a snackbar to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // If the user is not logged in, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please log in to add to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error adding to cart: $e');
      // Show a snackbar to indicate error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding to cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B262C),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_bag_outlined),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Product ID: $id', // Displaying the id here
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        brand,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff8F959E),
                        ),
                      ),
                      Text(
                        '\$$price',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff8F959E),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(color: Color(0xffF5F8FB), fontSize: 17),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddReview(productId: id),
                        ),
                      );
                    },
                    child: Text(
                      "add review",
                      style: TextStyle(color: Color(0xff9775FA), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('reviews')
                  .where('productId', isEqualTo: id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Widget> reviewWidgets = [];

                snapshot.data?.docs.forEach((doc) {
                  Map<String, dynamic>? data =
                      doc.data() as Map<String, dynamic>?;

                  if (data != null &&
                      data.containsKey('name') &&
                      data.containsKey('review') &&
                      data.containsKey('rating')) {
                    final name = data['name'] ?? 'No name';
                    final review = data['review'] ?? 'No review';
                    final rating = data['rating'] ?? 'No rating';

                    // Define a list to hold the star icon widgets
                    List<Widget> starIcons = [];

                    // Add colored stars based on the rating
                    for (int i = 0; i < rating; i++) {
                      starIcons.add(
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 12,
                        ),
                      );
                    }

                    // Add the styled review widget
                    reviewWidgets.add(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      review,
                                      style: TextStyle(
                                        color: Color(0xff8F959E),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children:
                                      starIcons, // Display the list of star icon widgets
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                });

                return Column(
                  children: reviewWidgets.isNotEmpty
                      ? reviewWidgets
                      : [
                          Text(
                            'No reviews available',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // Handle add to
          addToCart(context);
          print('Add to cart tapped');
        },
        child: Container(
          height: 60,
          color: Color(0xff9775FA),
          child: Center(
            child: Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
