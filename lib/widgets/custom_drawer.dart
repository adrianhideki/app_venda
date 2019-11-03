import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:lolja/screens/login_screen.dart';
import 'package:lolja/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageController;

  CustomDrawer(this._pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        )
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0, //alinha os componentes
                      left: 0.0,
                      child: Text(
                        "lolja \nRoupas",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0, //alinhado a baixo e esquerda
                      left: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Olá,",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Entre ou cadastre-se >",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.0,
                color: Colors.grey[700],
              ),
              DrawerTile(Icons.home, "Início", _pageController, 0),
              DrawerTile(Icons.list, "Produtos", _pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", _pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", _pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
