import 'dart:convert';
// cuando solo necesitamos exponer una clase de una importación show LatLng
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  int? id;
  String? tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    required this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  LatLng getLatLng() {
    // sustraemos solo los números osea quitamos el geo: por eso se pone 4 que quite las primeras posciones
    final latLng = this.valor.substring(4).split(',');
    // convertimos a un número la latitud
    final lat = double.parse(latLng[0]);
    // convetimos a un número la longitud
    final lng = double.parse(latLng[1]);
    // retornamos el objeto de LatLng ynos pide la lantitug y la longitud
    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
