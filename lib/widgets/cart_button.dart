import 'package:flutter/material.dart';
import 'package:lolja/screens/cart_screen.dart';
import 'package:lolja/utils/utils.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: (){
        pageMove(context, CartScreen());
      },
      backgroundColor: getPrimaryColor(context),
    );
  }
}
