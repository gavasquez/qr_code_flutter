import 'package:flutter/material.dart';

class CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final currentIndex = 1;

    return BottomNavigationBar(
        /* currentIndex para poner cual es el elemento seleccionado */
        currentIndex: currentIndex,
        elevation: 0,
        /* Se debe poner como minimo dos items */
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Direcciones')
        ]);
  }
}
