import 'dart:io';

import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class FormAddProduct extends StatefulWidget {
  const FormAddProduct({Key? key}) : super(key: key);

  @override
  State<FormAddProduct> createState() => _FormAddProductState();
}


class _FormAddProductState extends State<FormAddProduct> {

  XFile? _image;
  final _imageKey = UniqueKey(); // Ajoutez cette ligne

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageProductController = TextEditingController();
  bool _isCameraButtonEnabled = false;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageName = _nameController.text;
      final imagePath = image.path;
      final extension = imagePath.substring(imagePath.lastIndexOf('.'));
      final imageProductName = '$imageName$extension';
      _imageProductController.text = imagePath;
      setState(() {
        _image = image;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reloadImage(); // Rechargez l'image lorsque l'écran est à nouveau affiché
  }

  Future<void> _reloadImage() async {
    if (_image != null) {
      await precacheImage(FileImage(File(_image!.path)), context);
      setState(() {}); // Force la mise à jour de l'affichage pour afficher la nouvelle image
    }
  }
      @override
  void dispose() {
    _nameController.dispose();
    _imageProductController.dispose();
    super.dispose();
  }
  void _updateCameraButtonStatus() {
    setState(() {
      _isCameraButtonEnabled = _nameController.text.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name product'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  if (value.length < 6) {
                    return 'Name must be at least 6 characters long';
                  }
                  return null;
                },
                controller: _nameController,
                onChanged: (value) {
                  _updateCameraButtonStatus();
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price product'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Invalid price';
                  }
                  return null;
                },
                  controller: _priceController,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image product'),
                      controller: _imageProductController,
                      readOnly: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isCameraButtonEnabled ? _openCamera : null,
                    child: const Icon(Icons.camera),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (_image != null)
                Image.file(
                  File(_image!.path),
                  key: _imageKey, // Ajoutez cette ligne
                  width: 200,
                  height: 200,
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    final String productName = _nameController.text;
                    final double productPrice = double.parse( _priceController.text);
                    final String productImage = _imageProductController.text;
                    final Map<String, dynamic> productData = {
                      'name': productName,
                      'price': productPrice,
                      'image': productImage,
                    };
                    ApiService.createItem(productData).then((response) {
                      if (response.statusCode == 201) {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, "/gallery");
                        // Le produit a été créé avec succès
                        // Faites quelque chose ici, par exemple, affichez un message de succès
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Erreur'),
                                content: Text('Échec de la création du produit.'),
                                actions: [
                                  TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK')
                                  ),
                                ],
                              );
                            },
                        );
                        // Échec de la création du produit
                        // Affichez un message d'erreur ou effectuez une action appropriée
                      }
                    });
                    // Logic to save the product
                  }
                },
                child: Text('Enregistrer'),
              ),
            ],

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/gallery");
          // Logic to go back
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
