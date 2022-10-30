import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';



//import 'GlobalPages/privacy.dart';
import 'login.dart';
import '/Vars/globalss.dart' as globalss;

class signup22 extends StatefulWidget {
  const signup22({Key? key}) : super(key: key);

  @override
  _signup22State createState() => _signup22State();
}

class _signup22State extends State<signup22> {

  bool agreeterms = false;
  bool _isObscure = true;
  bool _isObscure1 = true;
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController confirmpass = new TextEditingController();


  final _formKeyup = GlobalKey<FormState>();


  Future register() async {
    var alertStyle = AlertStyle(

      titleStyle: TextStyle(
          color:Theme.of(context).textTheme.bodyText1!.color
      ),
      descStyle:TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color
      ),
    );

    bool valid = true;
    if(email.text.isEmpty ||pass.text.isEmpty || firstname.text.isEmpty || lastname.text.isEmpty ||confirmpass.text.isEmpty ){
      valid = false;
     // Alert(context: context, image:Image.asset("assets/nm/WARNING.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "enter all fields required.".tr(),style:alertStyle).show();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(

              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(Icons.error_outline)
                ],
              ),
              content: Text(
                "enter all fields required.".tr(),
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

      //return;
      return;
    } else{
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text);

      int lenghtpass = pass.text.length;

      if(!emailValid){
      //  Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid Email Address.".tr(),style:alertStyle).show();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(

                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Icon(Icons.error_outline)
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

        valid = false;
        return;
      }

      if(lenghtpass<6){
      //  Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "password too short min lenght 6 chars".tr(),style:alertStyle).show();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(

                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Icon(Icons.error_outline)
                  ],
                ),
                content: Text(
                  "password too short min lenght 6 chars".tr(),
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

        valid = false;
        return;
      }
      if(confirmpass.text !=pass.text ){
      //  Alert(context: context, image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "passwords don't match".tr(),style:alertStyle).show();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(

                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Icon(Icons.error_outline)
                  ],
                ),
                content: Text(
                  "passwords don't match".tr(),
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

        valid = false;
        return;
      }
      if(!agreeterms){
    //    Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "you should agree terms and conditions to signup".tr(),style:alertStyle).show();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(

                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Icon(Icons.error_outline)
                  ],
                ),
                content: Text(
                  "you should agree terms and conditions to signup".tr(),
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

        valid = false;
        return;
      }

    }


    if(valid){

      var map = new Map<String, dynamic>();
      map['email'] =  email.text.toString();
      map['password'] = pass.text.toString();
      map['first_name'] =  firstname.text.toString();
      map['last_name'] = lastname.text.toString();

      final response = await http.post(
          Uri.parse('https://studyinrussia.app/api/_register'),

          body: map
      );

      if (response.statusCode == 200) {

        if(jsonDecode(response.body)["code"]==200){
          // Alert(
          //   context: context,
          //   image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,),
          //   desc: "An email has been sent to your email address containing an activation link. Please click on the link to activate your account.".tr(),
          //   buttons: [
          //
          //     DialogButton(
          //       child: Text(
          //         "ok".tr(),
          //         style: TextStyle(color: Colors.white, fontSize: 12),
          //       ),
          //       onPressed: () {
          //         Navigator.pop(context);
          //         // Navigator.pushReplacement(
          //         // context,
          //         // MaterialPageRoute(builder: (context) => LoginPage()),
          //         // );
          //       },
          //       // width: 120,
          //     ),
          //
          //   ],
          // ).show();
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
                    "An email has been sent to your email address containing an activation link. Please click on the link to activate your account.".tr(),
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



        }else{
       //   Alert(context: context,image:Image.asset("assets/nm/WARNING.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "email alredy exist".tr()).show();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(

                  shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                  title: Row(
                    children: [
                      Icon(Icons.error_outline)
                    ],
                  ),
                  content: Text(
                    "email alredy exist".tr(),
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
        }

      }else{
      //  Alert(context: context, title: "error", desc: "try again").show();
      //   showDialog(
      //       barrierDismissible: false,
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //
      //           shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
      //           title: Row(
      //             children: [
      //               Icon(Icons.error_outline)
      //             ],
      //           ),
      //           content: Text(
      //             "post.something went wrong".tr(),
      //             style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),
      //
      //           ),
      //           actions: <Widget>[
      //
      //             SizedBox(
      //               height: MediaQuery.of(context).size.width*(30/375),
      //               child: Row(
      //                 children: [
      //                   Flexible(
      //                     flex:2,
      //                     child: ElevatedButton(onPressed: ()async {
      //                       Navigator.pop(context);
      //
      //                     },
      //                       child:  SizedBox(
      //                         // width:
      //                         // MediaQuery.of(context).size.width *(144/375),
      //                           child: Center(child: Text("ok".tr()))),
      //
      //                       style: ElevatedButton.styleFrom(
      //                         primary: Color(0xFF2429F9),//change background color of button
      //                         // onPrimary: Colors.yellow,//change text color of button
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(20),
      //                         ),
      //                         elevation: 0,
      //
      //                       ),
      //
      //
      //                     ),
      //                   ),
      //                   SizedBox(width:MediaQuery.of(context).size.width*(10/375) ,),
      //                   Flexible(
      //                     flex:2,
      //                     child: ElevatedButton(onPressed: () {
      //                       Navigator.pop(context);
      //
      //
      //                     },
      //                       child:  SizedBox(
      //                         // width:
      //                         // MediaQuery.of(context).size.width *(144/375),
      //                           child: Center(child: Text("ownapplication.Cancel".tr(),style: TextStyle(color: Colors.black),))),
      //
      //                       style: ElevatedButton.styleFrom(
      //                         primary: Color(0xFFDFDFDF),//change background color of button
      //                         // onPrimary: Colors.yellow,//change text color of button
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(20),
      //                         ),
      //                         elevation: 0,
      //
      //                       ),
      //
      //
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             )
      //
      //
      //           ],
      //         );
      //       });

      }

      return null;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:SafeArea(
          child: Form(
            key: _formKeyup,
            child: Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),

              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [


//logo
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
                  //content
              Flexible(
                flex: 10,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/5, maxWidth: MediaQuery.of(context).size.width*(80/100)),
                        child: FittedBox(
                          child: Text(
                            "Sign UP".tr(),
                            style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w900,
                              color: Theme.of(context).textTheme.bodyText1!.color,

                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),

                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            // hintText: "Email".tr(),
                              label:Text("Email".tr()) ,
                              floatingLabelBehavior: FloatingLabelBehavior.auto
                          ),
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),

                        child: TextFormField(
                          controller: firstname,
                          decoration: InputDecoration(
                            // hintText: ,
                              label:Text("First Name".tr()) ,
                              floatingLabelBehavior: FloatingLabelBehavior.auto
                          ),
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),

                        child: TextFormField(
                          controller: lastname,
                          decoration: InputDecoration(
                            //  hintText: "Last Name".tr(),
                              label:Text("Last Name".tr()) ,
                              floatingLabelBehavior: FloatingLabelBehavior.auto

                          ),
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          obscureText: _isObscure1,
                          controller: pass,
                          decoration: InputDecoration(
                              suffixIcon:IconButton(
                                icon: Icon(_isObscure1 ? Icons.visibility_off : Icons.visibility , color:Theme.of(context).textTheme.headline4!.color,),
                                onPressed: (){
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
                                  });
                                },

                              ) ,

                              label:Text( "PassWord".tr()) ,
                              floatingLabelBehavior: FloatingLabelBehavior.auto
                          ),
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(

                          obscureText: _isObscure,
                          controller: confirmpass,
                          decoration: InputDecoration(


                              suffixIcon:IconButton(
                                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility , color:Theme.of(context).textTheme.headline4!.color,),
                                onPressed: (){
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },

                              ) ,

                              //  hintText: "Confirm Password".tr(),
                              label:Text("Confirm Password".tr()) ,
                              floatingLabelBehavior: FloatingLabelBehavior.auto

                          ),
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: agreeterms,
                            onChanged: (bool? value) { // This is where we update the state when the checkbox is tapped
                              setState(() {
                                agreeterms = value!;
                              });
                            },
                          ),

                          TextButton(
                            style: TextButton.  styleFrom(
                              textStyle: const TextStyle(fontSize: 15,),

                              primary: Theme.of(context).textTheme.headline1!.color,


                            ),
                            onPressed: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Privacy()),
                              // );

                            },
                            child:  Text("agree to terms and conditions".tr()),

                          )



                        ],

                      ),

                    ]))),




              Flexible(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color: globalss.cblue,
                                    width: 1,
                                    style: BorderStyle.solid
                                ),
                                // side: BorderSide(color: Colors.red)
                              ),
                              primary: Colors.white
                          ),
                          onPressed: () async{
                            await register();


                          },
                          child:  SizedBox(
                              width:MediaQuery.of(context).size.width ,
                              child: Center(
                                child: Text("register".tr(),style: TextStyle(color:globalss.cblue),
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ]
                  ))),





                //  SizedBox(height: 20,)



                ],
              ),
            ),
          ),
        )

    );
  }
}
