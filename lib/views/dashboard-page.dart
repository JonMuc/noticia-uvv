import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/views/criar-conta-page.dart';
import 'package:noticia_app/views/widget/post-item.dart';

class DashboardPage extends StatefulWidget {

  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostItem(
            username: post['username'],
            imageUrl: post['image'],
            description: post['description'],
            likes: post['likes'],
            comments: post['comments'],
          );
        },
      ),
    );
  }

}