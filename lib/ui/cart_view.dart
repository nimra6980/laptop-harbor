import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_harbor_app/ui/add_review.dart';
import 'package:laptop_harbor_app/ui/address_view.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late String? userId;
  List<String> cartItemIds = []; // Array to store cart item IDs

  @override
  void initState() {
    super.initState();
    // Get the current user ID
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B262C),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .where('user_id', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final List<Widget> cartItems = [];
                double subtotal = 0;

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  snapshot.data!.docs.forEach((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final String productName = data['product_name'];
                    final String productId = data['product_id'];
                    final double productPrice =
                        double.parse(data['product_price']);
                    final String productImage = data['product_image'];
                    final String cartItemId =
                        data['product_id']; // Get cart item ID

                    cartItemIds.add(cartItemId); // Add cart item ID to array

                    cartItems.add(Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Color(0xff222E34),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                productImage,
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(height: 10),
                              Text(
                                productName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffF5F8FB),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Price: \$$productPrice',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff8F959E),
                                ),
                              ),
                              SizedBox(height: 10),
                              CounterWidget(),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ));

                    subtotal += productPrice;
                  });
                } else {
                  cartItems.add(
                    Center(
                      child: Text(
                        'No items in cart',
                        style: TextStyle(
                          color: Color(0xffF5F8FB),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }

                // Add shipping cost
                final double shippingCost = 10;
                final double total = subtotal + shippingCost;

                return Column(
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
                              "Cart",
                              style: TextStyle(
                                color: Color(0xffF5F8FB),
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                      ],
                    ),
                    SizedBox(height: 20),
                    ...cartItems, // Display the cart items
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                                color: Color(0xff8F959E), fontSize: 14),
                          ),
                          Text(
                            "\$$subtotal",
                            style: TextStyle(
                                color: Color(0xffF5F8FB), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping cost",
                            style: TextStyle(
                                color: Color(0xff8F959E), fontSize: 14),
                          ),
                          Text(
                            "\$$shippingCost",
                            style: TextStyle(
                                color: Color(0xffF5F8FB), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                color: Color(0xff8F959E), fontSize: 14),
                          ),
                          Text(
                            "\$$total",
                            style: TextStyle(
                                color: Color(0xffF5F8FB), fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    MyFooterButtonWidget(
                      cartItemIds: cartItemIds,
                      subtotal: subtotal,
                      total: total,
                      userId: userId!,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 1;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 1) {
        _count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          color: Color(0xffDEDEDE),
          onPressed: _decrement,
        ),
        Text('$_count',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xffDEDEDE),
            )),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          color: Color(0xffDEDEDE),
          onPressed: _increment,
        ),
      ],
    );
  }
}

class MyFooterButtonWidget extends StatelessWidget {
  final List<String> cartItemIds;
  final double subtotal;
  final double total;
  final String userId;

  MyFooterButtonWidget({
    required this.cartItemIds,
    required this.subtotal,
    required this.total,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to address screen and pass the necessary data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddressView(
              cartItemIds: cartItemIds,
              subtotal: subtotal,
              total: total,
              userId: userId,
            ),
          ),
        );
      },
      child: Container(
        height: 90.0, // Set the height of the fixed footer
        color: Color(0xff9775FA), // Set the color of the fixed footer
        child: Center(
          child: Text(
            'Checkout',
            style: TextStyle(color: Color(0xffF5F8FB), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
