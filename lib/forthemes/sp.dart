import 'package:shared_preferences/shared_preferences.dart';

setthemetosave(bool dd) async {
SharedPreferences _preferences = await SharedPreferences.getInstance();
_preferences.setBool("savedtheme",dd);
}



