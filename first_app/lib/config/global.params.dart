

import 'package:flutter/material.dart';

class GlobalParams{
  static List<Map<String, dynamic>> menus=[
  {
    "title":"Counter","icon": Icon(Icons.home) , "route":"/home"
  },
    {
      "title":"Camera","icon": Icon(Icons.camera) , "route":"/camera"
    },
    {
      "title":"Gallery","icon": Icon(Icons.photo_album) , "route":"/gallery"
    },
    {
      "title":"QR Scanner","icon": Icon(Icons.qr_code) , "route":"/qrscanner"
    }
  ];
}