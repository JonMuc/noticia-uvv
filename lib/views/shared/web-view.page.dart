// import 'dart:html';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_web/webview_flutter_web.dart';
//
// class WebViewExample extends StatelessWidget {
//
//
//   @override
//   void initState() {
//     print(123123213);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WebView'),
//       ),
//       body: WebViewWidget(controller: _controller,),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Exemplo de WebView'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => WebViewExample(url: 'https://g1.com.br'),
//               ),
//             );
//           },
//           child: Text('Abrir WebView em nova tela'),
//         ),
//       ),
//     );
//   }
// }
