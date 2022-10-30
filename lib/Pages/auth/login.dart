import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stru2022/Pages/restpassword.dart';

import '../home.dart';
import '/Vars/globalss.dart' as globalss;
import 'Siginup.dart';

// import 'GlobalPages/About.dart';
// import 'newlandingpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  bool _isActive1 = false;
  bool _isActive2 = false;



  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  //String gh = globalss.ghj;
  final _formKey = GlobalKey<FormState>();

  Future login() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
    var alertStyle = AlertStyle(
      titleStyle:
          TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      descStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      isCloseButton: false,
    );
    bool valid = true;


    if (valid) {
      var map = new Map<String, dynamic>();
      map['_username'] = user.text.toString();
      map['_password'] = pass.text.toString();

      final response = await http.post(
          Uri.parse('https://studyinrussia.app/api/login_check'),
          body: map);
     // print(response);
      if (response.statusCode == 200) {
        if (json.decode(response.body)["code"] == 200) {
          if (jsonDecode(response.body)["user"]["verified"]) {
            globalss.tokenfromserver =
                jsonDecode(response.body)["token"].toString();
            globalss.fname =
                jsonDecode(response.body)["user"]["firstName"].toString();
            globalss.lname =
                jsonDecode(response.body)["user"]["lastName"].toString();
            globalss.email =
                jsonDecode(response.body)["user"]["email"].toString();
            globalss.password = pass.text.toString();
            globalss.id = jsonDecode(response.body)["user"]["id"].toString();
            globalss.profileimage =
                jsonDecode(response.body)["user"]["image"].toString();

            globalss.userverified =
                jsonDecode(response.body)["user"]["verified"];

            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setString('username', user.text.toString());
            prefs.setString('password', pass.text.toString());

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeLand()),
            );

          } else {
            globalss.tokenfromserver = "";
            globalss.fname = "";
            globalss.lname = "";
            globalss.email = "";
            globalss.password = "";
            globalss.id = "";
            globalss.profileimage = "";
            globalss.userverified = false;
            // Alert(
            //   context: context,
            //   type: AlertType.error,
            //   title: "RFLUTTER ALERT1",
            //   desc: "Flutter is more awesome with RFlutter Alert.",
            //   buttons: [
            //     DialogButton(
            //       child: Text(
            //         "COOL",
            //         style: TextStyle(color: Colors.white, fontSize: 20),
            //       ),
            //       onPressed: () => Navigator.pop(context),
            //       width: 120,
            //     )
            //   ],
            // ).show();
          }
        }

      }
if(response.statusCode == 401){
  Navigator.pop(context);
  // Alert(
  //   context: context,
  //   type: AlertType.error,
  //   title: "Invalid credentials.".tr(),
  //   desc: "Invalid credentials. RFlutter Alert.",
  //   buttons: [
  //     DialogButton(
  //       child: Text(
  //         "COOL",
  //         style: TextStyle(color: Colors.white, fontSize: 20),
  //       ),
  //       onPressed: () => Navigator.pop(context),
  //       width: 120,
  //     )
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
              Icon(Icons.error_outline)
            ],
          ),
          content: Text(
            "Invalid credentials.".tr(),
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


      return jsonDecode(response.body);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
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
                          "Sign IN".tr(),
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w900,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        TextFormField(
                          controller: user,
                          decoration: InputDecoration(
                              label: Text("Email".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                // 2
                                _isActive1 = false;
                              });
                              return "please enter email.".tr();
                            }
                            if (value.length < 10 ) {
                              setState(() {
                                // 2
                                _isActive1 = false;
                              });
                              return "Invalid Email Address.".tr();
                            }
                            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                            if(!emailValid){
                                setState(() {
                                  // 2
                                  _isActive1 = false;
                                });

                                return "Invalid Email Address.".tr();
                            }
                            else{
                              setState(() {
                                // 2
                                _isActive1 = true;
                              });
                              return null;
                            }

                          },
                          onChanged: (value){
                            if (value == null || value.isEmpty||value.length < 2) {
                              setState(() {
                                // 2
                                _isActive1 = false;
                              });

                            }else{
                              setState(() {
                                // 2
                                _isActive1 = true;
                              });
                            }

                          },
                        ),
                        TextFormField(
                          cursorColor: globalss.cblue,
                          obscureText: _isObscure,
                          controller: pass,
                          decoration: InputDecoration(
                              focusColor:
                                  Theme.of(context).textTheme.headline1!.color,
                              hoverColor:
                                  Theme.of(context).textTheme.headline1!.color,
                              fillColor:
                                  Theme.of(context).textTheme.headline1!.color,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;

                                  });
                                },
                              ),



                              label: Text("PassWord".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                // 2
                                _isActive2 = false;
                              });
                              return 'Please enter a password';
                            }
                            if (value.length < 6 ) {
                              return 'password must have at least 6 characters.';
                            }
                            setState(() {
                              // 2
                              _isActive2 = true;
                            });
                            return null;
                          },
                          onChanged: (value){
                            if (value == null || value.isEmpty||value.length < 2) {
                              setState(() {
                                // 2
                                _isActive2 = false;
                              });

                            }else{
                              setState(() {
                                // 2
                                _isActive2 = true;
                              });
                            }

                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 12,
                            ),
                            primary:
                                Theme.of(context).textTheme.headline1!.color,
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => restpass()));
                          },
                          child: Text(
                            "Forgot Your Password?".tr(),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontWeight: FontWeight.bold),
                          ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dont have account?".tr(),
                                style: TextStyle(color: Color(0xff8D8D8D))),
                          ],
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,

                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Flexible(
                              flex: 2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: globalss.cblue,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                    primary: Colors.white),
                                onPressed: () async {
                                  String catnumber='notnumber' ;
                                  String selectedcate='' ;
                                  Map<String, dynamic> ppp={
                                    "idd": catnumber,
                                    "title": selectedcate,
                                  };
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => signup22())
                                  );



                                },
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Center(
                                        child: FittedBox(
                                          child: Text(
                                      "Sign UP".tr(),
                                      style:
                                            TextStyle(color: globalss.cblue),
                                    ),
                                        ))),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  primary: globalss.cblue,
                                ),
                                onPressed:(_isActive1&&_isActive2)? () async{
                                  if (_formKey.currentState!.validate()) {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //       content: Text('Processing Data')),
                                    //
                                    // );
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return Center(child: CircularProgressIndicator(),);
                                    //     });

                                    await login();

                                    //Navigator.pop(context);

                                  }else{

                                  }

                                  // globalss.tokenfromserver = "";
                                  // globalss.fname = "";
                                  // globalss.lname = "";
                                  // globalss.email = "";
                                  // globalss.password = "";
                                  // globalss.id = "";
                                  // globalss.profileimage = "";
                                  // globalss.userverified = false;
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => About()),
                                  // );
                                }:null,
                                // child:  Text("Continue as guest".tr(),style:TextStyle(color: Colors.blue), ),
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Center(
                                        child: Text("Sign IN".tr(),
                                            style: TextStyle(
                                                color: Colors.white)))),
                              ),
                            ),
                          ],
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
      ),
    ));
  }
}
