import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController _pageController;
  final int page;

  DrawerTile(this.icon, this.text, this._pageController, this.page);

  Color _getColor(BuildContext context){
    if (_pageController.page.round() == this.page){
      return Theme.of(context).primaryColor;
    } else {
      return Colors.grey[500];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          _pageController.jumpToPage(page);
        },
        child: Container(
          height: 65.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: _getColor(context),
              ),
              SizedBox(
                width: 32.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: _getColor(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
