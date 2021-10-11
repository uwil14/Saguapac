import 'package:cloud_firestore/cloud_firestore.dart';

class deposit {
  final double x;
  final double y;
  final int tamano;
  final String uniqueID;
  final String estado;

  deposit(
      {required this.x,
      required this.y,
      required this.tamano,
      required this.uniqueID,
      required this.estado});

  factory deposit.fromJson(Map<dynamic, dynamic> json) {
    return deposit(
      uniqueID: json['uniqueID'],
      x: json['x'],
      y: json['y'],
      tamano: json['tamano'],
      estado: json['estado'],
    );
  }
}

class Registro {
  Registro(this.uniqueID, this.x, this.y, this.tamano, this.estado, this.date);

  final String uniqueID;
  final double x;
  final double y;
  final int tamano;
  final String estado;
  final Timestamp date;
}
