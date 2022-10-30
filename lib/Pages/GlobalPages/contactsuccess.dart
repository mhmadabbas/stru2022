import 'dart:async';


import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/Pages/home.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';
import 'package:stru2022/mywidget/myFloatingActionButton.dart';


import '../../Vars/globalss.dart' as globalss;
import '../../mywidget/botombarnew.dart';
import '../Siginin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../kommunicate/prechat.dart';
import 'ContactUs.dart';

class contactsuccess extends StatefulWidget {

  contactsuccess({Key? key}) : super(key: key);

  @override
  _contactsuccessState createState() => _contactsuccessState();
}

class _contactsuccessState extends State<contactsuccess> {

  TextEditingController subject = new TextEditingController();
  TextEditingController message = new TextEditingController();



  Future sendcontact() async {



    if(subject.text.isEmpty||message.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('ContactUs.All fields required'.tr()),
      ));
      return;
    }



    else{
      var map = new Map<String, dynamic>();
      map['subject'] =  subject.text.toString();
      map['message'] = message.text.toString();




      String Url = 'https://studyinrussia.app/api/contact';
      var response = await http.post(
          Uri.parse(Url),
          headers: {"Authorization": "bearer "+globalss.tokenfromserver},
          body: map
      );
      if(response.statusCode == 200){
        //  String message = convert.json.decode(response.body)['message'].toString();
        String code = convert.json.decode(response.body)['code'].toString();
        if(code == "400"){

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("ContactUs.some error happend".tr()),
          ));
        }
        if(code == "200"){
          String message = convert.json.decode(response.body)['message'].toString();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));

        }
        return null;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('ContactUs.Check internet connection'.tr()),
        ));
        return null;
      }


    }



  }
  Future getsocial() async{
    String Url = 'https://studyinrussia.app/api/social';

    final response = await http.get(
      Uri.parse(Url),
    );

    if (response.statusCode == 200) {

      final getsocial = convert.jsonDecode(response.body)["data"];
      //  print(getsocial);
      return getsocial;
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
        body:Container(
          height:double.infinity ,
          width:double.infinity ,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(height:  MediaQuery.of(context).size.width *(50/375),),

                      Image.asset("assets/22images/msuccess.png" ,width: MediaQuery.of(context).size.width *(100/375),height:MediaQuery.of(context).size.width *(100/375) ),
                      SizedBox(height:  MediaQuery.of(context).size.width *(30/375),),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(child: Text("Message sent successfully".tr()+"!",style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)))),


                      SizedBox(height:  MediaQuery.of(context).size.width *(10/375),),
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
                                  //  color: Theme.of(context).primaryColor,
                                  color: Colors.transparent,
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
                                            child: Text("drawer.keep in touch".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color ),),
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
                      SizedBox(height: 30,),



                    ],

                  ),

                ),
              ),
              Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,

                  child: Padding(
                    padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width *(15/375),right: MediaQuery.of(context).size.width *(15/375)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color:globalss.cblue ,
                                    width: 1,
                                    style: BorderStyle.solid
                                ),
                              ),

                              primary: Theme.of(context).primaryColor,

                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => HomeLand()));
                            },
                            child:  SizedBox(
                                child: FittedBox(child: Text("Go back Home".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color,),))),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),

                                primary: Color(0xFF002BFF)

                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => contactus()));


                            },
                            child:  Text("Send more".tr(),style: TextStyle(color:Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
              )
            ],
          ),
        )



    );
  }
}
