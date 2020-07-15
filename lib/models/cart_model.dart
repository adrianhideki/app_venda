import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lolja/datas/cart_product.dart';
import 'package:lolja/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];
  bool isLoading = false;
  String couponCode;
  double discountPercentage = 0;

  CartModel(this.user){
    if (user.isLoggedIn() && products == null){
      print("a");
      loadCartItens();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void setCoupon(String coupon, int percent){
    this.couponCode = coupon;
    this.discountPercentage = double.parse(percent.toString());
  }

  void loadCartItens() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();
    products =
        query.documents.map((doc) => (CartProduct.fromDocument(doc))).toList();
    notifyListeners();
  }

  double getProductsPrice(){
    double price = 0.0;

    for(CartProduct c in products){
      if(c.productData != null){
        price += c.quantity  * c.productData.price;
      }
    }

    return price;
  }

  double getDiscount(){
    double prices = getProductsPrice() ?? 0.0;
    double discount = discountPercentage ?? 0.0;
    return (prices) * ((discount) / 100.0);
  }

  double getShipPrice(){
    return 15.0;
  }

  void updatePrices(){
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();
    double total = (productsPrice + shipPrice) - discount;

    DocumentReference refOrder = await Firestore.instance.collection("orders").add(
      {
        "clientId" : user.firebaseUser.uid,
        "products" : products.map((cartProduct) => cartProduct.toMap()).toList(),
        "shipPrice" : shipPrice,
        "productsPrice" : productsPrice,
        "discount" : discount,
        "totalPrice" : total,
        "status" : 1
      }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("orders").document(refOrder.documentID).setData({
      "orderId": refOrder.documentID
    });

    QuerySnapshot query = await Firestore.instance.collection("users")
        .document(user.firebaseUser.uid).collection("cart").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    products.clear();
    couponCode = null;
    discountPercentage = 0;
    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }
}
