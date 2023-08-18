import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/providers/scan_list_provider.dart';
import 'package:qr_code/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        /* String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR); */
        final barcodeScanres = 'geo:-11.988036,-76.906163';
        //final barcodeScanres = 'http://flutter.dev';
        if (barcodeScanres == '-1') {
          return;
        }
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        // crear el nuevo Scan
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanres);
        launchURL(context, nuevoScan);
        //scanListProvider.nuevoScan('geo:-11.988036,-76.906163');
      },
    );
  }
}
