import 'dart:io';

import 'package:first_app/models/Product.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/ui/pages/ProductDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}
class _GalleryPageState extends State<GalleryPage> {
  late Future<List<Product>> _productListFuture;

  @override
  void initState() {
    super.initState();
    _productListFuture = ApiService.getAllProduct();
  }

  void navigateToProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final productList = snapshot.data!;
            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return GestureDetector(
                  onTap: () {
                    navigateToProductDetails(product);
                  }
                  ,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/${product.image}",
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Price: \$${product.prix.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );

              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/addProduct");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
