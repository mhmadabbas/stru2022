import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stru2022/forthemes/sp.dart';

import 'config.dart';
class Mytheme with ChangeNotifier{
  static bool _isdark = false;
  Mytheme(){
    if(st==true){
      _isdark =true;
    }else{
      _isdark=false;
    }
}
  ThemeMode currenttheme(){
    return _isdark? ThemeMode.dark : ThemeMode.light;
  }
  void SwitchTheme()async{
    _isdark = !_isdark;
    setthemetosave(_isdark);
    notifyListeners();
  }
}


// ss()async {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//
// }