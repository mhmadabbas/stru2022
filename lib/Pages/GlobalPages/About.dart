import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import 'package:flutter_html/flutter_html.dart';

import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';

import 'package:stru2022/mywidget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';

class About extends StatefulWidget {


  About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  Future getabout() async{
    String Url = 'https://studyinrussia.app/api/about?lang=${context.locale.toString()}';

    final response = await http.get(
      Uri.parse(Url),
    );

    if (response.statusCode == 200) {

      final getnewsdetails = convert.jsonDecode(response.body)["data"];
      return getnewsdetails;
    }else{
      return null;
    }

  }

  Future getsocial() async{
    String Url = 'https://studyinrussia.app/api/social';

    final response = await http.get(
      Uri.parse(Url),
    );

    if (response.statusCode == 200) {

      final getsocial = convert.jsonDecode(response.body)["data"];
      print(getsocial);
      return getsocial;
    }else{
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
        endDrawer: MyDrawer(),
        appBar: ApplicationToolbarnosearch(),
        bottomNavigationBar: myBottomAppBarnew(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab?
     Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         SizedBox(height: 25,),
         FloatingActionButton(
             elevation: 0,



             backgroundColor:Theme.of(context).textTheme.headline6!.color,

             // shape: BoxShape.circle,
             onPressed: () {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => PreChatPage()));
             },
             child:
             SvgPicture.asset(
               'assets/svgicon/chatlastsvg.svg',
               // width: 20,
                  color:Theme.of(context).textTheme.bodyText2!.color,
               fit: BoxFit.contain,

             )

           // Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
         )
       ],
     )

            :null,

        body:SingleChildScrollView(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("drawer.About Us".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
              ),

              FutureBuilder(
                future:getabout() ,
                builder: (context,AsyncSnapshot snapshot){

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        return Container(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4,bottom: 4),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:CrossAxisAlignment.center,
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right:10,top: 4,bottom: 4),
                                    child: Html(data: snapshot.data),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );


                      }
                  }
                  return Center(child: CircularProgressIndicator(),);

                },
              ),
              FutureBuilder(
                future:getsocial() ,
                builder: (context,AsyncSnapshot snapshot){

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return Center(child: SizedBox());
                      }
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        return Container(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4,bottom: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:CrossAxisAlignment.stretch,
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20,right:20,),
                                    child: Text("drawer.keep in touch".tr()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20,right:20,),
                                    child: SizedBox(
                                      height: 50,
                                      child: ListView(
                                        scrollDirection:Axis.horizontal,

                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [
                                                GestureDetector(
                                                   child: FaIcon(
                                                    FontAwesomeIcons.facebook,size: 30,color: Theme.of(context).textTheme.headline5!.color,
                                                  ),
                                                  onTap: ()async{
                                                     if(snapshot.data["facebook"] != null){
                                                       if (await canLaunch(snapshot.data["facebook"])) {
                                                         await launch(snapshot.data["facebook"]);
                                                       } else {

                                                       }
                                                     }


                                                  },
                                                ),
                                            //    (snapshot.data["facebook"] != null)?Text(" "+snapshot.data["facebook"]):Text(" "),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [

                                                GestureDetector(
                                                    child: FaIcon(FontAwesomeIcons.twitter,size: 30,color: Theme.of(context).textTheme.headline5!.color,),
                                                    onTap: ()async{
                                                        if(snapshot.data["twitter"] != null && snapshot.data["twitter"] != ""){
                                                          if (await canLaunch(snapshot.data["twitter"])) {
                                                          await launch(snapshot.data["twitter"]);
                                                          } else {
                                                         // throw 'Could not launch ${snapshot.data["twitter"]}';
                                                          }
                                                        }
                                                     },
                                                ),

                                                // (snapshot.data["twitter"] != null)?Text(" "+snapshot.data["twitter"]):Text(" "),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [

                                                GestureDetector(
                                                  child: FaIcon(FontAwesomeIcons.telegram,size: 30,color: Theme.of(context).textTheme.headline5!.color,),
                                                  onTap: ()async{
                                                    if(snapshot.data["telegram"] != null && snapshot.data["telegram"] != ""){
                                                      if (await canLaunch(snapshot.data["telegram"])) {
                                                        await launch(snapshot.data["telegram"]);
                                                      } else {
                                                        // throw 'Could not launch ${snapshot.data["twitter"]}';
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [
                                              GestureDetector(
                                                  child: FaIcon(FontAwesomeIcons.whatsapp,size: 30,color: Theme.of(context).textTheme.headline5!.color,),
                                                  onTap: ()async{
                                                    if(snapshot.data["whatsapp"] != null && snapshot.data["whatsapp"] != ""){
                                                      if (await canLaunch(snapshot.data["whatsapp"])) {
                                                        await launch(snapshot.data["whatsapp"]);
                                                      } else {
                                                        // throw 'Could not launch ${snapshot.data["twitter"]}';
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [

                                                GestureDetector(
                                                  child: FaIcon(FontAwesomeIcons.youtube,size: 30,color: Theme.of(context).textTheme.headline5!.color,),
                                                  onTap: ()async{
                                                    if(snapshot.data["youtube"] != null && snapshot.data["youtube"] != ""){
                                                      if (await canLaunch(snapshot.data["youtube"])) {
                                                        await launch(snapshot.data["youtube"]);
                                                      } else {
                                                        // throw 'Could not launch ${snapshot.data["twitter"]}';
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [

                                                GestureDetector(
                                                  child: FaIcon(FontAwesomeIcons.instagram,size: 30,color: Theme.of(context).textTheme.headline5!.color,),
                                                  onTap: ()async{
                                                    if(snapshot.data["instagram"] != null && snapshot.data["instagram"] != ""){
                                                      if (await canLaunch(snapshot.data["instagram"])) {
                                                        await launch(snapshot.data["instagram"]);
                                                      } else {
                                                        // throw 'Could not launch ${snapshot.data["twitter"]}';
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );


                      }
                  }
                  return Center(child: SizedBox());

                },
              ),

            ],
          ),
        )

    );
  }
}
