import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor_app/ui/add_review.dart';
import 'package:laptop_harbor_app/ui/home_view.dart';

class WishlistView extends StatefulWidget {
  final VoidCallback refreshHomePage;
  const WishlistView({Key? key, required this.refreshHomePage})
      : super(key: key);

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    _user = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  @override
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
                  widget.refreshHomePage();
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Wishlist",
                    style: TextStyle(
                      color: Color(0xffF5F8FB),
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              CircleIconButton(
                icon: Icons.shopping_bag_outlined,
                iconColor: Color(0xffF5F8FB),
                circleColor: Color(0xff222E34),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('wishlist')
                  .where('user_id', isEqualTo: _user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No items in wishlist',
                      style: TextStyle(color: Color(0xffF5F8FB)),
                    ),
                  );
                }

                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return WishlistItem(
                      productName: data['product_name'] ?? 'Product Name',
                      productDescription:
                          data['product_desc'] ?? 'Product Description',
                      productBrand: data['product_brand'] ?? 'Product Brand',
                      productPrice: (data['product_price'] ?? 0.0).toDouble(),

                      productId: doc.id,
                      imageUrl:
                          data['product_image'] ?? 'assets/default_image.png',
                      removeFromWishlist: () =>
                          _removeFromWishlist(doc.reference),
                      refreshHomePage: widget
                          .refreshHomePage, // Pass the callback function here
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Container(
            color: Color(0xff1B262C),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                  color: Color(0xff8F959E),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Wishlist",
                    style: TextStyle(color: Color(0xff9775FA), fontSize: 14),
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xff8F959E),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xff8F959E),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeFromWishlist(DocumentReference productRef) async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnapshot = await productRef.get();
    if (docSnapshot.exists) {
      await productRef.delete();
    } else {
      print('Document does not exist');
    }
  }
}

class WishlistItem extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String productBrand;
  final double productPrice;
  final String imageUrl;
  final String productId;
  final Function removeFromWishlist;
  final VoidCallback refreshHomePage;

  const WishlistItem({
    required this.productName,
    required this.productDescription,
    required this.productBrand,
    required this.productPrice,
    required this.imageUrl,
    required this.productId,
    required this.removeFromWishlist,
    required this.refreshHomePage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100, // Set image height
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      removeFromWishlist();
                      // Call the callback function to refresh the home page
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            productName,
            style: TextStyle(
              color: Color(0xffF5F8FB),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productBrand,
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '\$${productPrice.toString()}',
                style: TextStyle(
                  color: Color(0xffF5F8FB),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
