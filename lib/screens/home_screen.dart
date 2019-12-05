import 'package:flutter/material.dart';
import 'package:lolja/screens/cart_screen.dart';
import 'package:lolja/tabs/home_tab.dart';
import 'package:lolja/tabs/products_tab.dart';
import 'package:lolja/tiles/cart_button.dart';
import 'package:lolja/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      //não permite que seja possível arrastar as telas
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Container(
          color: Colors.blue,
        ),
        CartScreen(),
      ],
    );
  }
}
