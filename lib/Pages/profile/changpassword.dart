import 'dart:async';
import 'package:easy_localization/easy_localization.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/drawer.dart';


import '../../Vars/globalss.dart' as globalss;
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';



class ChangPassword extends StatefulWidget {

  ChangPassword({Key? key}) : super(key: key);

  @override
  _ChangPasswordState createState() => _ChangPasswordState();
}

class _ChangPasswordState extends State<ChangPassword> {

  TextEditingController password = new TextEditingController();
  TextEditingController new_password = new TextEditingController();
  TextEditingController new_password_confirm = new TextEditingController();


  Future changepassword() async {

    if(new_password.text.isEmpty||new_password_confirm.text.isEmpty||password.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('profile.All fields required'.tr()),
      ));
      return;
    }

    if(new_password.text != new_password_confirm.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('profile.new password and confirm dont match'.tr()),
      ));
      return;
    }
    else if(password.text == new_password.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('profile.new password match current password'.tr()),
      ));
      return;
    }
    else{
      var map = new Map<String, dynamic>();
      map['password'] =  password.text.toString();
      map['new_password'] = new_password.text.toString();
      map['new_password_confirm'] =  new_password_confirm.text.toString();



      String Url = 'https://studyinrussia.app/api/profile/edit/password';
      var response = await http.post(
          Uri.parse(Url),
          headers: {"Authorization": "bearer "+globalss.tokenfromserver},
          body: map
      );
      if(response.statusCode == 200){
        String message = convert.json.decode(response.body)['message'].toString();
        String code = convert.json.decode(response.body)['code'].toString();
        if(code == "400"){

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("profile:enter correct password for your account".tr()),
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
          content: Text('Check internet connection'),
        ));
        return null;
      }


    }

    return null;

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
        body: Padding(
        //  padding: const EdgeInsets.all(20.0),
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375) ),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375) ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)
                        ),
                        Text("profile.change password".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                      ],
                    )
                ),


Expanded(
  child:   Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Flexible(
    flex: 1,
    child: SizedBox(),
    ),

                     Flexible(
                flex: 8,
                child:   SingleChildScrollView(
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextFormField(



                        controller: password,



                        decoration: InputDecoration(



                            // hintText: 'password',



                            labelText: 'profile.Current password'.tr(),







                            floatingLabelBehavior: FloatingLabelBehavior.always,



                            // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),



                            // border:



                            // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),



                        ),



                        validator:(value) {



                            if (value == null || value.isEmpty) {



                              return 'Please enter some text';



                            }



                            return null;



                        },



                      ),
                      TextFormField(



                        controller: new_password,



                        // initialValue:"dfd",



                        decoration: InputDecoration(



                            //    hintText: 'new_password',



                            labelText: 'profile.new password'.tr(),







                            floatingLabelBehavior: FloatingLabelBehavior.always,



                            // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),



                            // border:



                            // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),



                        ),



                        validator:(value) {



                            if (value == null || value.isEmpty) {



                              return 'Please enter some text';



                            }



                            return null;



                        },



                      ),
                      TextFormField(



                        controller: new_password_confirm,



                        decoration: InputDecoration(



                            //  hintText: 'new_password_confirm',



                            labelText: 'profile.confirm new password'.tr(),







                            floatingLabelBehavior: FloatingLabelBehavior.always,



                            // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),



                            // border:



                            // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),



                        ),



                        validator:(value) {



                            if (value == null || value.isEmpty) {



                              return 'Please enter some text';



                            }



                            return null;



                        },



                      ),
                    ],

                  ),
                ),
              ),
      Flexible(
        flex: 1,
        child: SizedBox(),
      ),

      Padding(
          padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width *(15/375) ,right:MediaQuery.of(context).size.width *(15/375),bottom:MediaQuery.of(context).size.width *(15/375)  ),
          child: Container(
            width: MediaQuery.of(context).size.width*(345/375),
            height:MediaQuery.of(context).size.width*(38/375),
            child: ElevatedButton.icon(onPressed: () async{await changepassword();},
            label:  Text("profile.Save Changes".tr()),
            icon: Icon(Icons.save),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2429F9),//change background color of button
              // onPrimary: Colors.yellow,//change text color of button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation:0,

            ),


            ),
          ),
      ),

    ],

  ),
),



              ],
            ),
          ),
        )
    );
  }
}
