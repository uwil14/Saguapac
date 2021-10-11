import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {

  double _x = 0;

  double get x {
    return _x;
  }

  set x(double valor) {
    _x = valor;
    notifyListeners();
  }


  double _y = 0;

  double get y {
    return _y;
  }

  set y(double valor) {
    _y = valor;
    notifyListeners();
  }



  int _tamano =0;

  int get tamano {
    return _tamano;
  }

  set tamano(int valor) {
    _tamano = valor;
    notifyListeners();
  }




  String _estado = " ";

  String get estado {
    return _estado;
  }

  set estado(String valor) {
    _estado = valor;
    notifyListeners();
  }


  String _id = " ";

  String get id {
    return _id;
  }

  set id(String valor) {
    _id = valor;
    notifyListeners();
  }








}
