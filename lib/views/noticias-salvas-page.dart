import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/models/news-model.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/login-page.dart';
import 'package:noticia_app/views/shared/drawer.dart';
import 'package:noticia_app/views/widget/post-item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticiasSalvasPage extends StatefulWidget {

  NoticiasSalvasPage({Key? key}) : super(key: key);

  @override
  _NoticiasSalvasPage createState() => _NoticiasSalvasPage();
}

class _NoticiasSalvasPage extends State<NoticiasSalvasPage> {
  Usuario? usuario;
  bool isEsporteSelected = false;
  bool isTecnologiaSelected = false;
  bool isHumorSelected = false;
  bool isPoliticaSelected = false;

  List<News?> listaNews = List<News?>.filled(
      0, null,
      growable: true);

  List<News?> listaNewsBase = List<News?>.filled(
      0, null,
      growable: true);

  final List<String> values = ['assets/logo_g1.png', 'assets/logo_cnn.png', 'assets/logo_record.png'];

  @override
  void initState() {
    obterNoticia();
    super.initState();
  }

  obterNoticia() async{
    LoginService service = LoginService();
    var result = await service.listarNoticiasSalvas();

    setState(() {
      listaNews = result;
      listaNewsBase = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Notícias salvas'),
            GestureDetector(
              onTap: showFilterModal,
              child: Icon(Icons.search_rounded, size: 30,),
            )
          ],
        ),
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
            liked: post.liked,
            likes: post.likes,
            comments: post.comments!,
            idNoticia: post.id,
            pathLogo: getRandomValue(),
            salvo: post.salvo,
          );
        },
      ),
    );
  }

  aplicarFiltro(){
    setState(() {
      listaNews = listaNewsBase.where((x) => (x!.tag! == "tecnologia" && isTecnologiaSelected) ||
          (x!.tag! == "politica" && isPoliticaSelected) ||
          (x!.tag! == "esporte" && isEsporteSelected) ||
          (_controller.text.isNotEmpty && x!.title.toLowerCase().contains(_controller.text.toLowerCase())) ||
          (x!.tag! == "humor" && isHumorSelected)).toList();

      if(!isPoliticaSelected && !isEsporteSelected && !isTecnologiaSelected && !isHumorSelected && _controller.text.isEmpty)
        listaNews = listaNewsBase;

    });
  }

  final TextEditingController _controller = TextEditingController();
  String _text = '';

  void showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Selecione os filtros',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CheckboxListTile(
                    title: Text('Esporte'),
                    value: isEsporteSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isEsporteSelected = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Tecnologia'),
                    value: isTecnologiaSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isTecnologiaSelected = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Humor'),
                    value: isHumorSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isHumorSelected = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Política'),
                    value: isPoliticaSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isPoliticaSelected = value!;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: "Pesquise...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50), // Define o raio das bordas arredondadas
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _text = value;
                          });
                        },
                      ),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      aplicarFiltro();
                      Navigator.pop(context);
                    },
                    child: Text('Aplicar Filtros'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String getRandomValue() {
    final random = Random();
    int randomIndex = random.nextInt(values.length);
    return values[randomIndex];
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