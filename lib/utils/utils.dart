import 'package:flutter/material.dart';

Future<dynamic> pageMove(BuildContext context, dynamic page){
  return Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}


Future<dynamic> pageReplace(BuildContext context, dynamic page){
  return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page));
}