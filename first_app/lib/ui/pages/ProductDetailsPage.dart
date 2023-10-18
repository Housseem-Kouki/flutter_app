

import 'package:first_app/models/Product.dart';
import 'package:first_app/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/${product.image}",
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Price: \$${product.prix.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Action du partage
                  },
                  icon: Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {
                    // Action de modification
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async  {
                    // Action de suppression
                    try {
                      await ApiService.deleteProduct(product.id);
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, "/gallery");
                      // La suppression a réussi
                      // Vous pouvez effectuer des actions supplémentaires, telles que afficher une notification ou retourner à la liste des produits.
                    } catch (e) {
                      // Gérer les erreurs lors de la suppression du produit
                      print('Failed to delete product: $e');
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            // Autres détails du produit
          ],
        ),

      ),
    );
  }
}
