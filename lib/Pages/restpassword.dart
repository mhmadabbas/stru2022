import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';

import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'auth/login.dart';




class restpass extends StatefulWidget {

  restpass({Key? key}) : super(key: key);

  @override
  _restpassState createState() => _restpassState();
}

class _restpassState extends State<restpass> {



  TextEditingController email = new TextEditingController();


  Future resetpass() async {

    bool vall = true;
    if(email.text.isEmpty){
    //  Alert(context: context,    image:Image.asset("assets/nm/WARNING.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "please enter email.".tr()).show();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(

              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(Icons.check)
                ],
              ),
              content: Text(
                "please enter email.".tr(),
                style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),

              ),
              actions: <Widget>[

                SizedBox(
                  height: MediaQuery.of(context).size.width*(30/375),
                  child: Row(
                    children: [
                      Flexible(
                        flex:2,
                        child: ElevatedButton(onPressed: ()async {
                          Navigator.pop(context);

                        },
                          child:  SizedBox(
                            // width:
                            // MediaQuery.of(context).size.width *(144/375),
                              child: Center(child: Text("ok".tr()))),

                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2429F9),//change background color of button
                            // onPrimary: Colors.yellow,//change text color of button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,

                          ),


                        ),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width*(10/375) ,),
                      Flexible(
                        flex:2,
                        child: ElevatedButton(onPressed: () {
                          Navigator.pop(context);


                        },
                          child:  SizedBox(
                            // width:
                            // MediaQuery.of(context).size.width *(144/375),
                              child: Center(child: Text("ownapplication.Cancel".tr(),style: TextStyle(color: Colors.black),))),

                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFDFDFDF),//change background color of button
                            // onPrimary: Colors.yellow,//change text color of button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,

                          ),


                        ),
                      ),
                    ],
                  ),
                )


              ],
            );
          });
      vall = false;
    }else{
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text);
      if(!emailValid){
      //  Alert(context: context,     image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid Email Address.".tr()).show();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(

                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Icon(Icons.check)
                  ],
                ),
                content: Text(
                  "Invalid Email Address.".tr(),
                  style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),

                ),
                actions: <Widget>[

                  SizedBox(
                    height: MediaQuery.of(context).size.width*(30/375),
                    child: Row(
                      children: [
                        Flexible(
                          flex:2,
                          child: ElevatedButton(onPressed: ()async {
                            Navigator.pop(context);

                          },
                            child:  SizedBox(
                              // width:
                              // MediaQuery.of(context).size.width *(144/375),
                                child: Center(child: Text("ok".tr()))),

                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF2429F9),//change background color of button
                              // onPrimary: Colors.yellow,//change text color of button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,

                            ),


                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*(10/375) ,),
                        Flexible(
                          flex:2,
                          child: ElevatedButton(onPressed: () {
                            Navigator.pop(context);


                          },
                            child:  SizedBox(
                              // width:
                              // MediaQuery.of(context).size.width *(144/375),
                                child: Center(child: Text("ownapplication.Cancel".tr(),style: TextStyle(color: Colors.black),))),

                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFDFDFDF),//change background color of button
                              // onPrimary: Colors.yellow,//change text color of button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,

                            ),


                          ),
                        ),
                      ],
                    ),
                  )


                ],
              );
            });

        vall = false;
      }
    }

    if(vall){
      var map = new Map<String, dynamic>();
      map['email'] =  email.text.toString();



      final response = await http.post(
          Uri.parse('https://studyinrussia.app/api/_reset'),
          body: map
      );

      if (response.statusCode == 200) {

        if(convert.json.decode(response.body)["code"]==200){
        //  Alert(context: context, image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "check your email to rest password.".tr()).show();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(

                  shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                  title: Row(
                    children: [
                      Icon(Icons.check)
                    ],
                  ),
                  content: Text(
                    "A password reset link was sent  Click the link in the email to create a new password".tr(),
                    style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),

                  ),
                  actions: <Widget>[

                    SizedBox(
                      height: MediaQuery.of(context).size.width*(30/375),
                      child: Row(
                        children: [
                          Flexible(
                            flex:2,
                            child: ElevatedButton(onPressed: ()async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));

                            },
                              child:  SizedBox(
                                // width:
                                // MediaQuery.of(context).size.width *(144/375),
                                  child: Center(child: Text("Login".tr()))),

                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF2429F9),//change background color of button
                                // onPrimary: Colors.yellow,//change text color of button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,

                              ),


                            ),
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width*(10/375) ,),
                          Flexible(
                            flex:2,
                            child: ElevatedButton(onPressed: () {
                              Navigator.pop(context);


                            },
                              child:  SizedBox(
                                // width:
                                // MediaQuery.of(context).size.width *(144/375),
                                  child: Center(child: Text("Resend link".tr(),style: TextStyle(color: Colors.black),))),

                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFDFDFDF),//change background color of button
                                // onPrimary: Colors.yellow,//change text color of button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,

                              ),


                            ),
                          ),
                        ],
                      ),
                    )


                  ],
                );
              });
        }else{
         // Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid credentials.".tr()).show();

        }



      }else{
       // Alert(context: context, image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid Email Address.".tr()).show();
      }


      return jsonDecode(response.body);
    }

  }




  @override
  Widget build(BuildContext context) {

    return

      Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 8, top: 5),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width *(35/375),


                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width *(31/375),

                              width: MediaQuery.of(context).size.width *(102/375),
                              child: Image.asset(
                                'assets/22images/logo22.png',
                                color:Theme.of(context).textTheme.headline1!.color,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
// SizedBox(height: MediaQuery.of(context).size.height/6,),
                    Flexible(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            "rest password".tr(),
                              style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w900,
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                            ),
                                        TextFormField(
                                          controller: email,
                                          //enableInteractiveSelection: true,
                                          decoration: InputDecoration(
                                              label:Text("Email".tr()) ,
                                              floatingLabelBehavior: FloatingLabelBehavior.auto
                                            // labelText: 'Email'.tr(),
                                            //
                                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                                            //
                                            // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                                            // border:
                                            // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
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

                    // SizedBox(height: MediaQuery.of(context).size.height/6,),
                    Flexible(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(onPressed: () async{await resetpass();},

                                child:  Text("rest password".tr()),
                                //icon: Icon(Icons.settings),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF2429F9),//change background color of button
                                  // onPrimary: Colors.yellow,//change text color of button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 2,

                                ),


                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));


    //   Scaffold(
    //
    //     body: SingleChildScrollView(
    //       child: Padding(
    //         padding:  EdgeInsets.only(right: 20.0,left: 20,top:MediaQuery.of(context).size.height/5),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           mainAxisSize: MainAxisSize.max,
    //
    //           children: [
    //             Text("rest password".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
    //             SizedBox(height: 10,),
    //             Text("Please, enter your email",style: TextStyle(color: Theme.of(context).textTheme.headline5!.color,fontWeight: FontWeight.bold,fontSize: 15),),
    //
    //             SizedBox(height: 70,),
    //
    //
    //
    //             TextFormField(
    //               controller: email,
    //               //enableInteractiveSelection: true,
    //               decoration: InputDecoration(
    //                   label:Text("Email".tr()) ,
    //                   floatingLabelBehavior: FloatingLabelBehavior.auto
    //                 // labelText: 'Email'.tr(),
    //                 //
    //                 // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                 //
    //                 // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
    //                 // border:
    //                 // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
    //               ),
    //               validator:(value) {
    //                 if (value == null || value.isEmpty) {
    //                   return 'Please enter some text';
    //                 }
    //                 return null;
    //               },
    //             ),
    //
    //
    //             SizedBox(height: 50,),
    //             Center(
    //               child: Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 child: ElevatedButton(onPressed: () async{await resetpass();},
    //
    //                   child:  Text("rest password".tr()),
    //                   //icon: Icon(Icons.settings),
    //                   style: ElevatedButton.styleFrom(
    //                     primary: Color(0xFF2429F9),//change background color of button
    //                     // onPrimary: Colors.yellow,//change text color of button
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(15),
    //                     ),
    //                     elevation: 15.0,
    //
    //                   ),
    //
    //
    //                 ),
    //               ),
    //             ),
    //             SizedBox(height: 30,)
    //
    //           ],
    //         ),
    //       ),
    //     )
    // );
  }
}
