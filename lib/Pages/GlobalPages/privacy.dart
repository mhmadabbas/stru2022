import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import 'package:flutter_html/flutter_html.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';

import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';

class Privacy extends StatefulWidget {


  Privacy({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {

  Future getprivacy() async{
    String Url = 'https://studyinrussia.app/api/privacy?lang=${context.locale.toString()}';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("drawer.Terms & Conditions".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
              ),
              FutureBuilder(
                future:getprivacy() ,
                builder: (context,AsyncSnapshot snapshot){

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: Padding(

                              padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 8),

                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:CrossAxisAlignment.center,
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                                children: [
                                  Html(data: snapshot.data),


                                ],
                              ),
                            ),
                          ),
                        );


                      }
                  }
                  return Center(child: CircularProgressIndicator(),);

                },
              )
            ],
          ),
        )

    );
  }
}
