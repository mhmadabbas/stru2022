import 'package:flutter/material.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class vimo extends StatefulWidget {
  const vimo({Key? key}) : super(key: key);

  @override
  _vimoState createState() => _vimoState();
}

class _vimoState extends State<vimo> {
  String videoId = '628559630';
  String videoId2 = '646793833';
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
      endDrawer:MyDrawer(),
      appBar:PreferredSize(

        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          centerTitle: true,

          flexibleSpace: Container(

            decoration:
            BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 4,
                  color: Colors.black26,
                  offset: Offset(0, 0),
                  blurRadius: 5,
                )
              ],
              image: DecorationImage(
                image: AssetImage('assets/image/appbar.jpg'),
                fit: BoxFit.fill,


              ),
            ),
          ),
          backgroundColor: Colors.transparent,

          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[

              Flexible(
                child: IconButton (
                  icon: Icon(Icons.search),
                  onPressed: () {

                  },
                ),
              ),
              // SizedBox(width: 15.0,),


            ],
          ),
          title: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [

                  Text("STUDY IN RUSSIA",)

                ],
              )
            ],
          ),






        ),
      ),
      bottomNavigationBar:myBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab? new FloatingActionButton(
        backgroundColor:Theme.of(context).primaryColor,
        shape:  BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        onPressed: () => print('hello world'),
        child:Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
      ):null,
      body: Center(
        child: Column(
          children: [
            Container(
             height: 250,
              child: VimeoPlayer(
                videoId: videoId2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
