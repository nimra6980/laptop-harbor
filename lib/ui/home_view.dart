import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptop_harbor_app/ui/account_info.dart';
import 'package:laptop_harbor_app/ui/add_product.dart';
import 'package:laptop_harbor_app/ui/cart_view.dart';
import 'package:laptop_harbor_app/ui/hp_view.dart';
import 'package:laptop_harbor_app/ui/login_view.dart';
import 'package:laptop_harbor_app/ui/password_update.dart';
import 'package:laptop_harbor_app/ui/product_detail.dart';
import 'package:laptop_harbor_app/ui/product_page.dart';
import 'package:laptop_harbor_app/ui/register_view.dart';
import 'package:laptop_harbor_app/ui/wishlist_view.dart';
import 'package:laptop_harbor_app/widgets/brand_container.dart';
import 'package:laptop_harbor_app/widgets/circle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String brand;
  final String description;
  final String image;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.brand,
    required this.description,
    required this.image,
    required this.name,
    required this.price,
  });
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late User? _user;
  bool _isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> productsInWishlist = [];
  TextEditingController _searchController = TextEditingController();
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _searchQuery = '';
  }

  Future<void> _fetchUserInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _user = FirebaseAuth.instance.currentUser;
      // Fetch user's wishlist products
      final wishlistSnapshot = await _firestore
          .collection('wishlist')
          .where('user_id', isEqualTo: _user!.uid)
          .get();
      // Extract product IDs from the wishlist and cast to List<String>
      productsInWishlist = (wishlistSnapshot.docs
          .map((doc) => doc['product_id'] as String)).toList();
      setState(() {});
    } catch (e) {
      print('Error fetching user info: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _refreshHomePage() {
    setState(() {});
  }

  void _toggleWishlist(Product product) async {
    setState(() {
      if (productsInWishlist.contains(product.id)) {
        // If the product is already in the wishlist, remove it
        productsInWishlist.remove(product.id);
        // Here you can write the code to remove the product from the wishlist table in your Firestore database
        _firestore.collection('wishlist').doc(product.id).delete();
      } else {
        // If the product is not in the wishlist, add it
        productsInWishlist.add(product.id);
        // Here you can write the code to add the product to the wishlist table in your Firestore database
        _firestore.collection('wishlist').doc(product.id).set({
          'product_id': product.id,
          'user_id': _user!.uid,
          'product_name': product.name,
          'product_price': product.price,
          'product_brand': product.brand,
          'product_desc': product.description,
          'product_image': product.image,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff1B262C),
      drawer: Drawer(
        child: Container(
          color: Color(0xff1B262C), // Setting background color for the drawer
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add your items/widgets here inside the Column
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  SizedBox(width: 240.0),
                  CircleIconButton(
                    icon: Icons.menu_open_rounded,
                    iconColor: Color(0xffF5F8FB),
                    circleColor: Color(0xff222E34),
                    onPressed: () {
                      _scaffoldKey.currentState?.closeDrawer();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        "${_user!.displayName ?? 'User'}",
                        style:
                            TextStyle(color: Color(0xffF5F8FB), fontSize: 24),
                      ),
                      Row(
                        children: [
                          Text(
                            "Verified Profile",
                            style: TextStyle(
                                color: Color(0xff8F959E), fontSize: 14),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: Color(0xff34C759), fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the value as per your requirement
                    child: Container(
                      width: 70.0,
                      height: 30.0,
                      color: Color(0xff222E34),
                      // Specify your desired background color
                      child: Center(
                        child: Text(
                          "3 Orders",
                          style: TextStyle(color: Color(0xff8F959E)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // Add more items as needed
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0,
                  ),
                  Icon(
                    Icons.info_outline,
                    color: Color(0xffF5F8FB),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountInfo()),
                        );
                      },
                      child: Text(
                        "Account Information",
                        style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0,
                  ),
                  Icon(
                    Icons.lock_open_rounded,
                    color: Color(0xffF5F8FB),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordUpdate()),
                        );
                      },
                      child: Text(
                        "Password",
                        style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0,
                  ),
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xffF5F8FB),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Order",
                        style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0,
                  ),
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xffF5F8FB),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductListPage()),
                        );
                      },
                      child: Text(
                        "My Cards",
                        style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0,
                  ),
                  Icon(
                    Icons.favorite_border_rounded,
                    color: Color(0xffF5F8FB),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WishlistView(
                              refreshHomePage: _refreshHomePage,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Wishlist",
                        style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0,
                  ),
                  Icon(
                    Icons.settings,
                    color: Color(0xffF5F8FB),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ))
                ],
              ),
              SizedBox(
                height: 160.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0,
                  ),
                  Icon(
                    Icons.logout_rounded,
                    color: Color(0xffFF5757),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () => _logout(context),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: Color(0xffFF5757),
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Widgets in the body
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Widgets in the row
              CircleIconButton(
                icon: Icons.menu_rounded,
                iconColor: Color(0xffF5F8FB),
                circleColor: Color(0xff222E34),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              CircleIconButton(
                icon: Icons.shopping_bag_outlined,
                iconColor: Color(0xffF5F8FB),
                circleColor: Color(0xff222E34),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 15.0),
          _isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: _user != null
                      ? Text(
                          "Hello ${_user!.displayName ?? 'User'}",
                          style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Text(
                          "Hello User",
                          style: TextStyle(
                            color: Color(0xffF5F8FB),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),

          SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              "Welcome to Laptop Harbor.",
              style: TextStyle(color: Color(0xff8F959E), fontSize: 15),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xff222E34),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      cursorColor: Color(0xff8F959E),
                      style: TextStyle(color: Color(0xff8F959E)),
                      decoration: InputDecoration(
                        hintText: "Search...",
                        fillColor: Color(0xff8F959E),
                        hintStyle: TextStyle(color: Color(0xff8F959E)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleIconButton(
                  icon: Icons.search_rounded,
                  iconColor: Color(0xffF5F8FB),
                  circleColor: Color(0xff9775FA),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                ),
                SizedBox(width: 5.0),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose Brand",
                  style: TextStyle(color: Color(0xffF5F8FB), fontSize: 17),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(color: Color(0xff8F959E), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                BrandContainer(
                  icon: Icons.apple_sharp,
                  text: 'Apple',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListPage()),
                    );
                  },
                ),
                SizedBox(width: 10),
                BrandContainer(
                  icon: Icons.laptop_chromebook,
                  text: 'HP',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HpView()),
                    );
                  },
                ),
                SizedBox(width: 10),
                BrandContainer(
                  icon: Icons.window_rounded,
                  text: 'Microsoft',
                  onTap: () {},
                ),
                SizedBox(width: 10),
                BrandContainer(
                  icon: Icons.laptop_mac_sharp,
                  text: 'Samsung',
                  onTap: () {},
                ),
                SizedBox(width: 10),
                BrandContainer(
                  icon: Icons.flash_on,
                  text: 'Razer',
                  onTap: () {},
                ),
                SizedBox(width: 10),
                BrandContainer(
                  icon: Icons.phonelink,
                  text: 'Lenovo',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProductPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Arrival",
                  style: TextStyle(color: Color(0xffF5F8FB), fontSize: 17),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(color: Color(0xff8F959E), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _searchQuery.isEmpty
                  ? _firestore.collection('products').snapshots()
                  : _firestore
                      .collection('products')
                      .where('product_name', isEqualTo: _searchQuery)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Product> products = [];
                snapshot.data?.docs.forEach((doc) {
                  Map<String, dynamic>? data =
                      doc.data() as Map<String, dynamic>?;

                  if (data != null) {
                    products.add(Product(
                      id: doc.id,
                      brand: data['product_brand'] ?? '',
                      description: data['product_desc'] ?? '',
                      image: data['product_image'] ?? '',
                      name: data['product_name'] ?? '',
                      price: (data['product_price'] as num?)?.toDouble() ?? 0.0,
                    ));
                  }
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
                    bool isInWishlist = productsInWishlist.contains(product.id);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100, // Set image height
                            width: double
                                .infinity, // Set image width to fill available space
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                          id: product.id,
                                          brand: product.brand,
                                          description: product.description,
                                          image: product.image,
                                          name: product.name,
                                          price: product.price,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        product.image,
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
                                      isInWishlist
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: isInWishlist
                                          ? Colors.white
                                          : Color(0xff8F959E),
                                    ),
                                    onPressed: () {
                                      // Call the _toggleWishlist method to add or remove the product from the wishlist
                                      _toggleWishlist(product);
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Color(0xff1B262C),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Home",
                    style: TextStyle(color: Color(0xff9775FA), fontSize: 14),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WishlistView(
                            refreshHomePage: _refreshHomePage,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite_outline_rounded),
                    color: Color(0xff8F959E),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartView()),
                      );
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
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
          ),
        ],
      ),
    );
  }
}
