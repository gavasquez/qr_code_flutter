import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectdMenuOpt;

    return BottomNavigationBar(
        /* Establecemos el valor al metodo del provider */
        onTap: (int i) => uiProvider.selectdMenuOpt = i,
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
