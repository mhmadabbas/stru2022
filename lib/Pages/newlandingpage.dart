import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class newlandingpage extends StatefulWidget {
  const newlandingpage({Key? key}) : super(key: key);

  @override
  _newlandingpageState createState() => _newlandingpageState();
}

class _newlandingpageState extends State<newlandingpage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);







  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
      body: Container(
        child: Text("xfv"),
      ),
    );
  }
}
