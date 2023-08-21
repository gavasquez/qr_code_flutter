import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_code/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // propiedad para cambiar el tipo de mapa
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial =
        CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50);

    // marcadores
    Set<Marker> markers = new Set<Marker>();
    // crear marcadores
    markers.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
              icon: Icon(Icons.location_on_outlined),
              onPressed: () async {
                // volver a la posicion del marcador
                final GoogleMapController controller = await _controller.future;
                await controller.animateCamera(CameraUpdate.newCameraPosition(
                    // Es de tipo CameraPosition, el target es donde va la latiitud y la longitud
                    CameraPosition(
                        target: scan.getLatLng(), zoom: 17.5, tilt: 50)));
              })
        ],
      ),
      body: GoogleMap(
        // tipo de mapa
        mapType: mapType,
        // Marcadores
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // floatingActionButton para cambiar el tipo de mapa
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),

        // al dar click cambiar el tipo mapa
         onPressed: () {
          if(mapType == MapType.normal){
            mapType =MapType.satellite;
          }else{
            mapType = MapType.normal;
          }
          // para re dibugar el StatefulWidget
          setState(() {});
         },
      ),
    );
  }
}
