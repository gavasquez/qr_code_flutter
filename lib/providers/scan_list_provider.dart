import 'package:flutter/material.dart';
import 'package:qr_code/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  // creamos una Lista de Scan
  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    // creamos la instancia
    final nuevoScan = new ScanModel(valor: valor);
    // insertamos el resgitro en la base de datos
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // asignar el id de la base de datos al modelo
    nuevoScan.id = id;
    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      // notificamos a cualquier widget que el valor cambia
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  cargaScanPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans!];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteScanAll();
    this.scans = [];
    notifyListeners();
  }

  borrarScansByID(int id) async {
    // eliminamos el scan
    await DBProvider.db.deleteScan(id);
  }
}
