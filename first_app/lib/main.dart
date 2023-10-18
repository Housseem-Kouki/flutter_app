import 'package:first_app/ui/pages/CreateScreen.dart';
import 'package:first_app/ui/pages/ScanScreen.dart';
import 'package:first_app/ui/pages/addProduct.page.dart';
import 'package:first_app/ui/pages/camera.page.dart';
import 'package:first_app/ui/pages/ProductDetailsPage.dart';
import 'package:first_app/ui/pages/formAddProduct.dart';
import 'package:first_app/ui/pages/gallery.page.dart';
import 'package:first_app/ui/pages/home.page.dart';
import 'package:first_app/ui/pages/statistique.pge.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home":(context)=>MyHomePage(),
        "/camera":(context)=>CameraPage(),
        "/gallery":(context)=>GalleryPage(),
        "/qrscannerpage":(context)=>ScanScreen(),
        "/qrcreatepage":(context)=>CreateScreen(),
        "/addProduct":(context)=>FormAddProduct(),
        "/statistique1":(context)=>Statistique(),
      //  "/detailProduct":(context)=>ProductDetailsPage(product: product)
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/home",
    );
  }
}








