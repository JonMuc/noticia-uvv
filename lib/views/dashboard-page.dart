import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/models/news-model.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/criar-conta-page.dart';
import 'package:noticia_app/views/login-page.dart';
import 'package:noticia_app/views/shared/drawer.dart';
import 'package:noticia_app/views/widget/post-item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {

  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  Usuario? usuario;

  List<News?> listaNews = List<News?>.filled(
      0, null,
      growable: true);

  final List<Map<String, dynamic>> posts = [
    {
      'username': 'john_doe',
      'image': 'assets/sol.jpg', // Link de exemplo de imagem
      'description': 'Lindo pôr do sol na praia!',
      'likes': 120,
      'comments': 15,
    },
    {
      'username': 'anna_smith',
      'image': 'assets/piza.jpg',
      'description': 'A melhor pizza da cidade!',
      'likes': 98,
      'comments': 22,
    },
    {
      'username': 'mike_jones',
      'image': 'assets/montanha.jpg',
      'description': 'Dia incrível nas montanhas.',
      'likes': 200,
      'comments': 40,
    },
  ];

  @override
  void initState() {
    obterNoticia();
    super.initState();
  }

  obterNoticia() async{
    LoginService service = LoginService();
    var result = await service.listarNoticias();

    setState(() {
      listaNews = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notícia UVV'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: DrawerPage(),
      body: ListView.builder(
        itemCount: listaNews.length,
        itemBuilder: (context, index) {
          final post = listaNews[index];
          return PostItem(
            username: post!.nomePortal,
            imageUrl: post.imgUrl,
            url: post.url,
            description: post.title,
            likes: post.likes,
            comments: 0,
            idNoticia: post.id,
          );
        },
      ),
    );
  }

  deslogar() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("usuario");

    Navigator.pop(context); // Fecha o drawer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deslogando...')),
    );

    Timer(Duration(seconds: 1), (){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
    });
  }
}