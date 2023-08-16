import 'package:flutter/material.dart';
import 'package:qr_code/pages/home_page.dart';
import 'package:qr_code/pages/mapa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code',
      /* Ruta inicial */
      initialRoute: 'home',
      /* Definimos las rutas */
      routes: {'home': (_) => HomePage(), 'mapa': (_) => MapaPage()},
      /* Configurar el tema de la aplicacion */
      theme: ThemeData(
          /* Cambiar el color primary de la aplicación */
          primarySwatch: Colors.deepPurple,
          /* Cambiar el color de floatingActionButtonTheme */
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple)),
    );
  }
}
