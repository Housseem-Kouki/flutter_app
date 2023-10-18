import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children:  [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.white
                      ]
                  )
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/me.jpg") ,
                  radius: 40,
                ),
              )
          ),
          ListTile(
            title: Text('Home' , style: TextStyle(fontSize: 23),),
            leading: Icon(Icons.home , color: Colors.blue,),
            trailing: Icon(Icons.arrow_right,color: Colors.black,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/home");
            },
          ),
          Divider(height: 2, color: Colors.black,),
          ListTile(
            title: Text('Camera' , style: TextStyle(fontSize: 23),),
            leading: Icon(Icons.camera , color: Colors.blue,),
            trailing: Icon(Icons.arrow_right,color: Colors.black,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/camera");
            },
          ),
          Divider(height: 2, color: Colors.black,),
          ListTile(
            title: Text('Gallery' , style: TextStyle(fontSize: 23),),
            leading: Icon(Icons.photo_album , color: Colors.blue,),
            trailing: Icon(Icons.arrow_right,color: Colors.black,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/gallery");
            },
          ),
          Divider(height: 2, color: Colors.black,),
          ListTile(
            title: Text('QR Scanner ' , style: TextStyle(fontSize: 23),),
            leading: Icon(Icons.qr_code_scanner , color: Colors.blue,),
            trailing: Icon(Icons.arrow_right,color: Colors.black,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/qrscannerpage");
            },
          ),
          Divider(height: 2, color: Colors.black,),
          ListTile(
            title: Text('QR Create ' , style: TextStyle(fontSize: 23),),
            leading: Icon(Icons.qr_code_scanner , color: Colors.blue,),
            trailing: Icon(Icons.arrow_right,color: Colors.black,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/qrcreatepage");
            },
          ),
          Divider(height: 2, color: Colors.black,),
          ListTile(
            title: Text('Statistique 1 ' , style: TextStyle(fontSize: 23),),
            leading: Icon(Icons.qr_code_scanner , color: Colors.blue,),
            trailing: Icon(Icons.arrow_right,color: Colors.black,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/statistique1");
            },
          ),
          Divider(height: 2, color: Colors.black,),
        ],
      ),
    );
  }
}

