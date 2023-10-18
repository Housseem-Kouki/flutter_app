import 'package:first_app/ui/widgets/mydrawer.widget.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Center( child : Text('My App')),),
      body: Text("hi" , style: TextStyle(color: Colors.blueAccent , fontSize: 29),),
    );
  }
}