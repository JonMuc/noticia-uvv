import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/dashboard-page.dart';
import 'package:noticia_app/views/login-page.dart';
import 'package:noticia_app/views/perfil-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {

  DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPage createState() => _DrawerPage();
}

class _DrawerPage extends State<DrawerPage> {
  Usuario? usuario;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async{
    var service = LoginService();
    var result = await service.obterUsuarioLogado();

    setState(() {
      usuario = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 80.0,
                  color: Colors.white,
                ),
                SizedBox(height: 10.0),
                Text(
                  usuario == null ? "" : usuario!.nome,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              navegarDash();
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              navegarPerfil();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () {
              deslogar();
            },
          ),
        ],
      ),
    );
  }

  deslogar() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("usuario");

    Timer(Duration(seconds: 1), (){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
    });
  }

  navegarPerfil() async{
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PerfilPage()),
            (route) => false);
  }

  navegarDash() async{
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
            (route) => false);
  }
}