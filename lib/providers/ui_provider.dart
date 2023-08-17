import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectdMenuOpt = 1;

  int get selectdMenuOpt {
    return this._selectdMenuOpt;
  }

  set selectdMenuOpt(int i){
    this._selectdMenuOpt = i;
    // notificamos el cambio
    notifyListeners();
  }
}
