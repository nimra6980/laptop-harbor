import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _imageURL = ''; // To store the image URL

  Future<void> _addProduct(Product product) async {
    try {
      await _firestore.collection('products').add({
        'product_brand': product.brand,
        'product_desc': product.description,
        'product_image': _imageURL, // Use stored image URL
        'product_name': product.name,
        'product_price': product.price,
      });
      print('Product added successfully');
      Navigator.pop(context);
    } catch (error) {
      print('Failed to add product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Product Brand'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Product Image URL'),
              onChanged: (value) {
                setState(() {
                  _imageURL = value; // Update image URL
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Product newProduct = Product(
                  brand: _brandController.text,
                  description: _descriptionController.text,
                  image: _imageURL, // Use stored image URL
                  name: _nameController.text,
                  price: double.parse(_priceController.text),
                );
                _addProduct(newProduct);
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
