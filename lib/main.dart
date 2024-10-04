import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noticia_app/firebase_options.dart';
import 'package:noticia_app/services/login-service.dart';
import 'package:noticia_app/views/login-page.dart';
import 'package:noticia_app/views/shared/verificarlogin-page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginService>.value(value: LoginService()),
      ],
      child: NoticiaApp(),
    );
  }
}

class NoticiaApp extends StatefulWidget {

  @override
  _NoticiaApp createState() => _NoticiaApp();
}

class _NoticiaApp extends State<NoticiaApp> {
  Locale _locale = Locale('pt', 'BR');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'noticia',
      debugShowCheckedModeBanner: false,
      home: VerificarLoginPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [ Locale('pt', 'BR'), Locale('en', 'US')],
    );
  }
}