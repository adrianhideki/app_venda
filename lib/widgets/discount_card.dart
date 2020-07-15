import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lolja/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite seu cupom"),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("coupons")
                    .document(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.data != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Desconto de ${docSnap.data["percent"]}% aplicado!"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Cupom inválido!"),
                      backgroundColor: Colors.redAccent,
                    ));
                    CartModel.of(context).setCoupon(null, 0);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
