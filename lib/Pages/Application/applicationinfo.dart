import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';
import 'package:stru2022/mywidget/myFloatingActionButton.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;
class applicationinfo extends StatefulWidget {

  Map<String, dynamic> mapapp;
  applicationinfo({Key? key,required this.mapapp}) : super(key: key);

  @override
  _applicationinfoState createState() => _applicationinfoState();
}

class _applicationinfoState extends State<applicationinfo> {




  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
        endDrawer:MyDrawer(),
        appBar:ApplicationToolbarnosearch(),



        bottomNavigationBar: myBottomAppBarnew(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25,

            ),
            SizedBox(height: MediaQuery.of(context).size.width*(8/375),),
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
                  color:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Colors.grey:Colors.white,
                  //Theme.of(context).textTheme.bodyText2!.color,
                  fit: BoxFit.contain,
                )

              // Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
            )
          ],
        )
            : null,

        body:SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375),top: MediaQuery.of(context).size.width*(15/375),bottom: MediaQuery.of(context).size.width*(15/375)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //label
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
                        FittedBox(child: Text("ownapplication.Application Details".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),maxLines: 1,))),

                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),

             Container(
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(
                     Radius.circular(5),

                   ),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.5),
                     spreadRadius: 1,
                     blurRadius: 1,
                     //offset: Offset(0, 3), // changes position of shadow
                   ),
                 ],
                 color: Theme.of(context).primaryColor,

               ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(children: [Text("Sub Course : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),],),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),

                     child: Text(widget.mapapp["name"].toString(),),),
                 ],
               ),
             ),

SizedBox(height: MediaQuery.of(context).size.width *(10/375)),
                //2
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColor,

                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Text("University : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),],),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                        child: Text(widget.mapapp["university"].toString()),),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),
                //3
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColor,

                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Text("Degree : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),Text(widget.mapapp["degree"].toString()),],),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),
                //4
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColor,

                  ),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Text("City : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),Text(widget.mapapp["city"].toString()),],),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),
//5
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColor,

                  ),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Text("Language : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),Text(widget.mapapp["language"].toString()),],),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),
                //6
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColor,

                  ),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Text("Level : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),Text(widget.mapapp["level"].toString()),],),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),
                //7
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColor,

                  ),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Text("Fees : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),Text(widget.mapapp["fees"].toString()+" \$"),],),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),
                //8
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColor,

                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Text("Details : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),],),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Html(data:widget.mapapp["content"].toString()),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width *(10/375)),














                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text("documents : ".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold)),Text(widget.mapapp["documents"].length.toString())],),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height /3,

                  child: ListView.separated(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width *(10/375),bottom:MediaQuery.of(context).size.width *(10/375) ),
                    itemBuilder: (context, i) {
                      final dataaa = widget.mapapp["documents"][i];
                      //colorbool = dataaa.subCourse.inCurrentUserFavorite;
                      //
                      // var coloor =
                      // (colorbool) ? Colors.blueAccent : Colors.grey;
                      return Padding(
                        padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width *(15/375), left: MediaQuery.of(context).size.width *(15/375)),
                        child: Container(
                          //height: 140,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                          // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


Stack(
  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

    CachedNetworkImage(
      height: MediaQuery.of(context).size.width *(200/375),
      width: MediaQuery.of(context).size.width *(200/375),
      fit: BoxFit.fitHeight,
      imageUrl:
      //globalss.UrlImagedocuments + dataaa.path.toString(),
      globalss.UrlImagedocuments+"/uploads/applications/" + dataaa.path.split('/').last,
      imageBuilder: (context, imageProvider) =>
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),

// borderRadius:BorderRadius.circular(40) ,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0,
                      3), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
      placeholder: (context, url) => Center(
          child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          Icon(Icons.error),
    ),
    Positioned.fill(child:  Text(

      (dataaa.type==1)?'ApplytoCourse.High School Transcript *'.tr():
      (dataaa.type==2)?'ApplytoCourse.Recommendation Letters'.tr():
      (dataaa.type==3)?'ApplytoCourse.Passport Copy *'.tr():
      (dataaa.type==4)?'ApplytoCourse.Personal Statement'.tr():
      (dataaa.type==5)?'ApplytoCourse.English Proficiency Test'.tr():
      (dataaa.type==6)?'ApplytoCourse.Extra Documents'.tr():
      "null",

      style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: FontWeight.bold,fontSize: 12),
      overflow: TextOverflow.ellipsis,
    ),)
  ],
),


                              ],

                            ),
                          ),
                        ),
                      );

                    },
                    separatorBuilder: (context, i) => Divider(),

                    itemCount: widget.mapapp["documents"].length,

                  ),
                ),
                SizedBox(height: 20,)


              ],
            ),
          ),
        )

    );
  }
}
