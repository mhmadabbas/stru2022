import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/drawer.dart';

import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';

class subcorseinfo extends StatefulWidget {

  Map<String, dynamic> mapsub;
  subcorseinfo({Key? key,required this.mapsub}) : super(key: key);

  @override
  _subcorseinfoState createState() => _subcorseinfoState();
}

class _subcorseinfoState extends State<subcorseinfo> {



  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
        endDrawer:MyDrawer(),
        appBar:ApplicationToolbarnosearch(),



        bottomNavigationBar:myBottomAppBarnew(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25,
            ),
            FloatingActionButton(
                elevation: 0,
                backgroundColor:
                Theme.of(context).textTheme.headline6!.color,

                // shape: BoxShape.circle,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PreChatPage()));
                },
                child: SvgPicture.asset(
                  'assets/svgicon/chatlastsvg.svg',
                  // width: 20,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  fit: BoxFit.contain,
                )

              // Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
            )
          ],
        )
            : null,

        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //  Text(widget.mapsub["id"].toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)
                    ),
                    Container(

                        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/5, maxWidth: MediaQuery.of(context).size.width*(70/100)),
                        child:
                        FittedBox(child: Text("Sub Course : ".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),maxLines: 1,))),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Text("Sub Course : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),),

                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),

                  child: Text(widget.mapsub["name"].toString(),),),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("University : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold)),
                    ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                  child: Text(widget.mapsub["university"].toString()),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("Degree : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold)),Text(widget.mapsub["degree"].toString()),],),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("City : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold)),Text(widget.mapsub["city"].toString()),],),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("Language : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold)),Text(widget.mapsub["language"].toString()),],),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("Level : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold)),Text(widget.mapsub["level"].toString()),],),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("Fees : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold)),Text(widget.mapsub["fees"].toString()+" \$"),],),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("Details : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold)),],),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(data:widget.mapsub["content"].toString()),
                ),





                // Text("Name : "+widget.mapsub["name"].toString()),
                //
                // Html(data:widget.mapsub["content"].toString()),
                // Text("degree : "+widget.mapsub["degree"].toString()),
                // Text("university : "+widget.mapsub["university"].toString()),
                // Text("city : "+widget.mapsub["city"].toString()),
            // final int id;
            // final String name;
            // final String content;
            // final Degree degree;
            // final Course university;
            // final Course course;
            // final String language;
            // final int level;
            // final int fees;
            // final int featured;
            //   bool inCurrentUserFavorite;
                // FutureBuilder(
                //   future:getsubcorseinfo() ,
                //   builder: (context,AsyncSnapshot snapshot){
                //
                //     switch (snapshot.connectionState) {
                //       case ConnectionState.waiting:
                //         {
                //           return Center(child: CircularProgressIndicator(),);
                //         }
                //       case ConnectionState.done:
                //         if (snapshot.hasData) {
                //           return Container(
                //             color: Theme.of(context).primaryColor,
                //             child: Padding(
                //               padding: const EdgeInsets.only(top: 4,bottom: 4),
                //               child: SingleChildScrollView(
                //                 child: Column(
                //                   mainAxisSize: MainAxisSize.min,
                //                   crossAxisAlignment:CrossAxisAlignment.center,
                //                   mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.only(left: 10,right:10,top: 4,bottom: 4),
                //                       child: Html(data: snapshot.data),
                //                     ),
                //
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           );
                //
                //
                //         }
                //     }
                //     return Center(child: CircularProgressIndicator(),);
                //
                //   },
                // ),

              ],
            ),
          ),
        )

    );
  }
}
