import 'package:comixapp/navDrawer/page/page_aventura.dart';
import 'package:comixapp/navDrawer/page/page_fantasia.dart';
import 'package:comixapp/navDrawer/page/page_infantil.dart';
import 'package:comixapp/telas/telaInicial.dart';
import 'package:flutter/material.dart';
class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(108, 0, 0, 2),
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 48,),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home_outlined,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16,),
            buildMenuItem(
              text: 'Aventura',
              icon: Icons.book_outlined,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16,),
            buildMenuItem(
              text: 'Infantil',
              icon: Icons.book_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16,),
            buildMenuItem(
              text: 'Fantasia',
              icon: Icons.book_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildMenuItem({
  required String text,
    required IconData icon,
    VoidCallback? onClicked,
}){
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color,),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
void selectedItem(BuildContext context, int index){
    Navigator.of(context).pop();
    switch(index){
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                TelaAventura()), (Route<dynamic> route) => false
        );
        break;
      case 1:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                TelaInfantil()), (Route<dynamic> route) => false
        );
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                TelaFantasia()), (Route<dynamic> route) => false
        );
        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                TelaInicial()), (Route<dynamic> route) => false
        );
        break;
    }
}
}
