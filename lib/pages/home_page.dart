import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/pages/direcciones_page.dart';
import 'package:qr_code/pages/mapas_page.dart';
import 'package:qr_code/providers/db_provider.dart';
import 'package:qr_code/providers/ui_provider.dart';
import 'package:qr_code/widgets/custom_navigator_bar.dart';
import 'package:qr_code/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        /* Para poner iconos en el appBar se pone en las acciones */
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever))
        ],
      ),
      /* Se van a mostrar los pages de forma condicional */
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButton(),
      /* Alinear el floatingActionButton */
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    // TODO: temporal leer la base de datos
    /* final tempScan = new ScanModel(valor: 'http://google.com'); */
    /* DBProvider.db.nuevoScan(tempScan); */
    /* DBProvider.db.deleteScanAll().then((value) => print(value));  */
    // cambiar para mostrar la pagina respectiva
    final curretntIndex = uiProvider.selectdMenuOpt;
    switch (curretntIndex) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
