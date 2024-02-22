import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor_app/ui/add_review.dart';
import 'package:laptop_harbor_app/ui/cart_view.dart';

class Product {
  final String brand;
  final String description;
  final String image;
  final String name;
  final double price;

  Product({
    required this.brand,
    required this.description,
    required this.image,
    required this.name,
    required this.price,
  });
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B262C),
      body: Column(
        children: [
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  child: Icon(
                    Icons.apple_rounded,
                    color: Color(0xffF5F8FB),
                    size: 34,
                  ),
                ),
              ),
              CircleIconButton(
                icon: Icons.shopping_bag_outlined,
                iconColor: Color(0xffF5F8FB),
                circleColor: Color(0xff222E34),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartView(),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('products')
                      .where('product_brand', isEqualTo: 'apple')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      return Text(
                        "${documents.length} items",
                        style: TextStyle(
                          color: Color(0xffF5F8FB),
                          fontSize: 17,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            // Wrap the StreamBuilder with Expanded
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('products')
                  .where('product_brand', isEqualTo: 'apple') // Filter by brand
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                List<Product> products = [];
                snapshot.data?.docs.forEach((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  products.add(Product(
                    brand: data['product_brand'],
                    description: data['product_desc'],
                    image: data['product_image'],
                    name: data['product_name'],
                    price: data['product_price'].toDouble(),
                  ));
                });

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.75, // Adjust as needed
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    Product product = products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150, // Set image height
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      product.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_outline,
                                      color: Color(0xff8F959E),
                                    ),
                                    onPressed: () {
                                      // Add your onPressed logic here
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10), // Adjust spacing as needed
                          Text(
                            product.name,
                            style: TextStyle(
                              color: Color(0xffF5F8FB),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              color: Color(0xffF5F8FB),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
