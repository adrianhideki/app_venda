import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  @override
  String documentId = "";

  OrderTile(this.documentId);

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .document(documentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              int status = snapshot.data["status"] ?? 1;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Código do pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    _buildProductsText(snapshot.data),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Status:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparação", 1, status),
                      _buildRow(1, 40),
                      _buildCircle("2", "Transporte", 2, status),
                      _buildRow(1, 40),
                      _buildCircle("3", "Entregue", 3, status),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildRow(double height, double width) {
  return Container(
    height: height,
    width: width,
    color: Colors.grey[300],
  );
}

Widget _buildCircle(String title, String subtitle, int status, int thisStatus) {
  Color backgroundColor;
  Widget child;

  if (thisStatus < status) {
    backgroundColor = Colors.grey[500];
    child = Text(
      title,
      style: TextStyle(color: Colors.white),
    );
  } else if (thisStatus == status && thisStatus < 3) {
    backgroundColor = Colors.blue[500];
    child = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ],
    );
  } else {
    backgroundColor = Colors.green;
    child = Icon(
      Icons.check,
      color: Colors.white,
    );
  }

  return Column(
    children: <Widget>[
      CircleAvatar(
        radius: 20.0,
        backgroundColor: backgroundColor,
        child: child,
      ),
      Text(
        subtitle,
        style: TextStyle(color: Colors.black45),
      ),
    ],
  );
}

String _buildProductsText(DocumentSnapshot documentSnapshot) {
  String text = "Descrição: \n";

  for (LinkedHashMap doc in documentSnapshot.data["products"]) {
    text +=
        "${doc["quantity"]} x ${doc["product"]["title"] ?? ""} (R\$ ${doc["product"]["price"].toStringAsFixed(2)})\n";
  }

  text +=
      "Total: R\$ ${documentSnapshot.data["totalPrice"].toStringAsFixed(2)}";
  return text;
}
