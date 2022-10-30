

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import 'package:flutter_html/flutter_html.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/drawer.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import '../../Model/alumni/alumniintro.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss ;

class RegistrationForm extends StatefulWidget {


  RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  List<Datum> dataa = [];

  TextEditingController First = new TextEditingController();
  TextEditingController Last = new TextEditingController();
  TextEditingController Number = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController study = new TextEditingController();
  TextEditingController studyfor = new TextEditingController();
  TextEditingController work = new TextEditingController();
  TextEditingController workfor = new TextEditingController();

  Future getintro() async{
    String Url = 'https://studyinrussia.app/api/alumni?lang=${context.locale.toString()}';

    final response = await http.get(
      Uri.parse(Url),
    );

    if (response.statusCode == 200) {

     // final getAlumniintro = convert.jsonDecode(response.body)["data"];
      Alumniintro alumniintroFromJson(String str) => Alumniintro.fromJson(convert.json.decode(response.body));
      final galumniintroFromJson = alumniintroFromJson(response.body);
     // String alumniintroToJson(Alumniintro data) => convert.json.encode(data.toJson());
      dataa = [];
      dataa = galumniintroFromJson.data;

      return galumniintroFromJson;
    }else{
      return null;
    }

  }

  Future Registration() async {
    var alertStyle = AlertStyle(
      titleStyle:
      TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      descStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      isCloseButton: false,
    );

      var map = new Map<String, dynamic>();



      map['firstName'] =  First.text.toString();
      map['lastName'] = Last.text.toString();
    map['email'] =  Email.text.toString();
    map['mobile'] = Number.text.toString();
    map['StudiedIn'] =  study.text.toString();
    map['StudiedFor'] = studyfor.text.toString();
    map['WorkedIn'] =  work.text.toString();
    map['WorkedFor'] = workfor.text.toString();



      String Url = 'https://studyinrussia.app/api/club';
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
            Alert(
              context: context,
              type: AlertType.success,
           //   title: "RFLUTTER ALERT3",
              desc: "Message sent successfully!.",
              buttons: [
                DialogButton(
                  child: Text(
                    "COOL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                ),
                DialogButton(
                  child: Text(
                    "COOL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                ),

              ],
            ).show();

        }
        return null;

      }else{

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('ContactUs.Check internet connection'.tr()),
        ));
        return null;
      }


 //   }



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
          child: Padding(
            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375),bottom:MediaQuery.of(context).size.width*(15/375) ),
                  child: Text("Alumni.Title".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
                ),

                FutureBuilder(
                  future:getintro() ,
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
                            child: SingleChildScrollView(
                              child: Column(
                              //  mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:CrossAxisAlignment.start,
                               // mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.width*(15/375)),
                                    child: Text( dataa[0].title,style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width*(15/375),bottom: MediaQuery.of(context).size.width*(15/375)),

                                    child: Container(
                                      height: MediaQuery.of(context).size.width*(204/375),
                                      width: MediaQuery.of(context).size.width*(345/375) ,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20),),
                                    //    color: Colors.red,

                                      ),
                                      child: VimeoPlayer(


                                        videoId:dataa[0].link.toString().split('/').last,

                                      ),),
                                  ),

                                  Html(data: dataa[0].content,

                                   //style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color)
                                    style: {
                                    "body": Style(
                                   fontSize: FontSize(15.0),
                                        color:Theme.of(context).textTheme.bodyText1!.color,
                                     // height:MediaQuery.of(context).size.width*(60/375)

                                    ),
                                    },

                                  ),


                                ],
                              ),
                            ),
                          );


                        }
                    }
                    return Center(child: CircularProgressIndicator(),);

                  },
                ),
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375),bottom:MediaQuery.of(context).size.width*(15/375) ),
                  child: Text("Alumni.Registration Form".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
                ),

                TextFormField(
                  controller: First,
                  decoration: InputDecoration(
                      label: Text("Alumni.First name".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto),

                ),
                TextFormField(
                  controller: Last,
                  decoration: InputDecoration(
                      label: Text("Alumni.Last name".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto),

                ),
                SizedBox(
               //   height: MediaQuery.of(context).size.width*(27/375),
                 // width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Flexible(
                        child: TextFormField(

                          controller: Number,
                          decoration: InputDecoration(
                              label: Text("Alumni.Number".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.auto),

                        ),
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        child: TextFormField( 
                          controller: Email,
                          decoration: InputDecoration(
                              label: Text("Alumni.Email".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.auto),

                        ),
                      ),
                    ],
                  ),
                ),

                TextFormField(
                  controller: study,
                  decoration: InputDecoration(
                      label: Text("Alumni.Where did you study ?".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto),

                ),
                TextFormField(
                  controller: studyfor,
                  decoration: InputDecoration(
                      label: Text("Alumni.Who did you study for ?".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto),

                ),
                TextFormField(
                  controller: work,
                  decoration: InputDecoration(
                      label: Text("Alumni.Where do you work ?".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto),

                ),
                TextFormField(
                  controller: workfor,
                  decoration: InputDecoration(
                      label: Text("Alumni.Who do you work for ?".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto),

                ),

                SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),

                      ),
                      primary: globalss.cblue),
                  onPressed: () async {
                    await  Registration();

                  },
                  child: SizedBox(
                      width:
                      MediaQuery.of(context).size.width *(345/375),
                      child: Center(
                          child: Text(
                            "Alumni.Send".tr(),
                            style:
                            TextStyle(color: Colors.white),
                          ))),
                ),
                SizedBox(height: 20,)

              ],
            ),
          ),
        )

    );
  }
}
