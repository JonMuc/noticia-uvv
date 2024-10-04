import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/shared/drawer.dart';

class PerfilPage extends StatefulWidget {

  PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPage createState() => _PerfilPage();
}

class _PerfilPage extends State<PerfilPage> {
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
            Text(
              'Nome',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              usuario == null ? "" : usuario!.nome,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'E-mail',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              usuario == null ? "" : usuario!.email,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 40.0),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Lógica para editar o perfil
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Editar perfil não implementado.')),
            //       );
            //     },
            //     child: Text('Editar Perfil'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}