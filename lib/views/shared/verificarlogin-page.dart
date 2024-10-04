import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/dashboard-page.dart';
import 'package:noticia_app/views/login-page.dart';
import 'package:provider/provider.dart';

const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

class VerificarLoginPage extends StatefulWidget {
  final bool? restart;
  VerificarLoginPage({this.restart});

  @override
  _VerificarLoginPage createState() => _VerificarLoginPage();
}

class _VerificarLoginPage extends State<VerificarLoginPage> {
  var usuarioModel = false;


  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    print(999999999);
    LoginService service = Provider.of<LoginService>(context, listen: false);
    var usuarioLogadoJson = await service.validarUsuario();
    print(usuarioLogadoJson);

    if (usuarioLogadoJson) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
              (route) => false);
    }else{
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
