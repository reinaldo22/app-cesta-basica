import 'package:cesta/model/usuario.dart';
import 'package:cesta/pages/loginPage/login_page.dart';
import 'package:cesta/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.login),
      accountEmail: Text(user.email),
    );
  }

  Future<Usuario> user = Usuario.get();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: ListView(
        children: <Widget>[
          FutureBuilder<Usuario>(
            future: user,
            builder: (context, snapshot) {
              Usuario user = snapshot.data;
              return user != null ? header(user): Container();
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Favoritos"),
            subtitle: Text("mais informações..."),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Item 1");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Ajuda"),
            subtitle: Text("mais informações..."),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Item 1");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _onClickLogout(context),
          ),
        ],
      ),
    ));
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    rotas(context, LoginPage(), replace: true);
  }
}
