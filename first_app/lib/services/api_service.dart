import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:first_app/models/Product.dart';
class ApiService {
  static final String baseUrl = "http://192.168.1.44:8001/"; // Remplacez par l'URL de votre API
  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('http://192.168.137.1:8001/deleteProduct/$id'));
    if (response.statusCode == 200) {
      // La suppression a réussi
    } else {
      throw Exception('Failed to delete product');
    }
  }
  static Future<List<Product>> getAllProduct() async {
    final response = await http.get(Uri.parse('http://192.168.137.1:8001/getAllProduct'));
    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);

      return productJson.map((json) => Product.fromJson(json)).toList();

    } else {
      throw Exception('Failed to fetch products');
    }
  }


  static Future<http.Response> createItem(Map<String, dynamic> productData) async {
    final String url = "http://192.168.137.1:8001/addProduct";


    var request = http.MultipartRequest('POST', Uri.parse(url));
    File imageFile = File(productData['image']);
    request.fields['name'] = productData['name'];
    request.fields['prix'] = productData['price'].toString();
    print('print 1');
    request.files.add(await http.MultipartFile.fromPath("image", imageFile.path));
    print('print 2');
    request.headers.addAll({
      "Content-type": "multipart/form-data"
    });
    var res = await request.send();





    print('image PATH : '+ imageFile.path);
    try {
     // final response = await request.send();

      if (res.statusCode == 200) {
        print("success");
        // Succès de la création du produit
        return http.Response('Product created', 201);
      } else {
        print("Failed to create product from service api");
        // Échec de la création du produit
        return http.Response('Failed to create product', res.statusCode);
      }
    } catch (e) {
      // Erreur lors de l'appel à l'API
      throw Exception('Failed to create product: $e');
    }
  }



}