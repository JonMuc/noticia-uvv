import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noticia_app/models/news-model.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/shared/drawer.dart';
import 'package:noticia_app/views/widget/post-item.dart';
import 'package:provider/provider.dart';

class VisualizarPerfilPage extends StatefulWidget {
  int? idUsuario;

  VisualizarPerfilPage({Key? key, this.idUsuario}) : super(key: key);

  @override
  _VisualizarPerfilPage createState() => _VisualizarPerfilPage();
}

class _VisualizarPerfilPage extends State<VisualizarPerfilPage> {
  Usuario? usuario;
  bool? usuarioSeguindo;
  List<News?> listaNews = List<News?>.filled(
      0, null,
      growable: true);


  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async{
    LoginService service = Provider.of<LoginService>(context, listen: false);
    var result = await service.obterUsuarioVisualizar();

    setState(() {
      usuario = result;
      usuarioSeguindo = result.follow;
    });

    List<News?> listaNewsPreenche = List<News?>.filled(
        0, null,
        growable: true);

    if(usuario!.likedNews! != null && usuario!.likedNews!.length > 0){
      var count = 1;
      usuario!.likedNews!.forEach((x) async {
        count++;
        final result = await service.obterNoticia(x.idNoticia);
        listaNewsPreenche.add(result);

        if(count >= usuario!.likedNews!.length){
          Timer(Duration(milliseconds: 300), (){
            atualizarLista(listaNewsPreenche);
          });
          // setState(() {
          //   listaNews.addAll(listaNewsPreenche);
          // });
          // print(878778998798);
          // print(jsonEncode(listaNews));
        }
      });
    }
  }

  atualizarLista(List<News?> listaNewsPreenche){
    setState(() {
      listaNews.addAll(listaNewsPreenche);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Icon(
                Icons.account_circle,
                size: 100.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Nome:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0, width: 10,),
                    Text(
                      usuario == null ? "" : usuario!.nome!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    clicarSeguir();
                  },
                  style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  child: Text(
                    usuarioSeguindo! ? 'Desseguir' : 'Seguir',
                    style: TextStyle(color: Colors.white), // Cor do texto
                  ),
                ),
              ],
            ),
            listaNews != null && listaNews.length > 0 ? Expanded(child: ListView.builder(
              itemCount: listaNews.length,
              itemBuilder: (context, index) {
                final post = listaNews[index];
                return PostItem(
                  username: post!.nomePortal,
                  imageUrl: post.imgUrl,
                  url: post.url,
                  description: post.title,
                  liked: null,
                  likes: post.likes,
                  comments: null,
                  idNoticia: post.id,
                  pathLogo: getRandomValue(),
                  salvo: null,
                );
              },
            ),) : Container()
          ],
        ),
      ),
    );
  }

  final List<String> values = ['assets/logo_g1.png', 'assets/logo_cnn.png', 'assets/logo_record.png'];
  String getRandomValue() {
    final random = Random();
    int randomIndex = random.nextInt(values.length);
    return values[randomIndex];
  }

  clicarSeguir(){
    LoginService service = Provider.of<LoginService>(context, listen: false);
    if(usuarioSeguindo!){
      service.desseguirUsuario();
      setState(() {
        usuarioSeguindo = !usuarioSeguindo!;
      });
    }else{
      service.seguirUsuario();
      setState(() {
        usuarioSeguindo = !usuarioSeguindo!;
      });
    }
  }
}