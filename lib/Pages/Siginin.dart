import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stru2022/Pages/restpassword.dart';
import 'package:stru2022/Pages/signup.dart';



import '../Vars/globalss.dart' as globalss;

import 'GlobalPages/About.dart';
import 'newlandingpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isObscure = true;

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  //String gh = globalss.ghj;
  final _formKey = GlobalKey<FormState>();

  Future login() async {
    var alertStyle = AlertStyle(

      titleStyle: TextStyle(
          color:Theme.of(context).textTheme.bodyText1!.color
      ),
      descStyle:TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color
      ),
      isCloseButton: false,

    );
    bool valid = true;
    if(user.text.isEmpty ||pass.text.isEmpty  ){
      valid = false;
      Alert(
          context: context,



          image:Image.asset("assets/screens/login/alerttest2.png",height: 200,width:MediaQuery.of(context).size.width,fit: BoxFit.fill,) ,
          desc:"enter all fields required.".tr(),
        style:alertStyle,
        buttons: [
          DialogButton(
            child: Text(
              "Cancel".tr(),
              style: TextStyle(color: globalss.cblue, fontSize: 15),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
            radius: BorderRadius.circular(20.0),
            border: Border.fromBorderSide(
              BorderSide(
                color: globalss.cblue,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),



          ),
          DialogButton(
            child: Text(
              "Login",
              style: TextStyle(color:Colors.white , fontSize: 15),
            ),
            onPressed: () => Navigator.pop(context),
            color: globalss.cblue,
            radius: BorderRadius.circular(20.0),
            // border: Border.fromBorderSide(
            //   BorderSide(
            //     color: globalss.cblue,
            //     width: 1,
            //     style: BorderStyle.solid,
            //   ),
            // ),



          ),
        ],
        padding: EdgeInsets.symmetric(vertical: 0),


      ).show();
      return;
    } else{
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(user.text);

      int lenghtpass = pass.text.length;

      if(!emailValid){
    //    Alert(context: context, image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid Email Address.".tr(),style:alertStyle).show();
        valid = false;
        return;
      }
      if(lenghtpass<6){
    //    Alert(context: context, image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "password too short min lenght 6 chars".tr(),style:alertStyle).show();
        valid = false;
        return;
      }
    }

    if(valid){
      var map = new Map<String, dynamic>();
      map['_username'] =  user.text.toString();
      map['_password'] = pass.text.toString();


      final response = await http.post(
          Uri.parse('https://studyinrussia.app/api/login_check'),
          body: map
      );
print(response);
      if (response.statusCode == 200) {

        if(json.decode(response.body)["code"]==200){

          if(jsonDecode(response.body)["user"]["verified"]){
            globalss.tokenfromserver=jsonDecode(response.body)["token"].toString();
            globalss.fname=jsonDecode(response.body)["user"]["firstName"].toString();
            globalss.lname=jsonDecode(response.body)["user"]["lastName"].toString();
            globalss.email=jsonDecode(response.body)["user"]["email"].toString();
            globalss.password=pass.text.toString();
            globalss.id=jsonDecode(response.body)["user"]["id"].toString();
            globalss.profileimage=jsonDecode(response.body)["user"]["image"].toString();

            globalss.userverified=jsonDecode(response.body)["user"]["verified"];

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('username',user.text.toString());
            prefs.setString('password',pass.text.toString());



            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => newlandingpage()),
            );

          }
          else{

            globalss.tokenfromserver="";
            globalss.fname="";
            globalss.lname="";
            globalss.email="";
            globalss.password="";
            globalss.id="";
            globalss.profileimage="";
            globalss.userverified=false;
            // Alert(
            //   context: context,
            //     style:alertStyle,
            //  // type: AlertType.warning,
            //     image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,),
            //   desc: "Your Account not verified !!".tr(),
            //   buttons: [
            //
            //     DialogButton(
            //       child: Text(
            //         "login".tr(),
            //         style: TextStyle(color: Colors.white, fontSize: 10),
            //       ),
            //       onPressed: () {
            //         Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(builder: (context) => LoginPage()),
            //         );
            //       },
            //       width: 120,
            //     ),
            //     DialogButton(
            //       child: Text(
            //         "Continue as guest".tr(),
            //         style: TextStyle(color: Colors.white, fontSize: 10),
            //       ),
            //       onPressed: () {
            //         globalss.tokenfromserver="";
            //         globalss.fname="";
            //         globalss.lname="";
            //         globalss.email="";
            //         globalss.password="";
            //         globalss.id="";
            //         globalss.profileimage="";
            //         globalss.userverified=false;
            //         Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(builder: (context) => newlandingpage()),
            //         );
            //       },
            //       width: 120,
            //     )
            //   ],
            // ).show();

          }




        }
        else{


        }

// pushNewScreen(
//   context,
//   screen: landingpage(),
//   withNavBar: true, // OPTIONAL VALUE. True by default.
//   pageTransitionAnimation: PageTransitionAnimation.cupertino,
// );



      }else{
    //    Alert(context: context,image:Image.asset("assets/nm/WARNING.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid credentials.".tr(),style:alertStyle).show();
      }
      return jsonDecode(response.body);
    }

  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:SingleChildScrollView(
          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//SizedBox(height: 40,),

          Container(
            height: MediaQuery.of(context).size.height/2.1  ,
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(
                    'assets/screens/login/login.png'),
                fit: BoxFit.fill,
              ),

            ),


          ),

                SizedBox(width: 0.0,height: 10.0,),
                Row(
                    children: <Widget>[
SizedBox(width: 20,),
                      Text("Welcome".tr(),style: TextStyle( fontSize: 35,fontWeight: FontWeight.bold),),
                    ]
                ),
                // Row(
                //     children: <Widget>[
                //       SizedBox(width: 20,),
                //       Icon(Icons.email,size: 25,color: Theme.of(context).textTheme.headline1!.color,),
                //       SizedBox(width: 10,),
                //       Text("Email".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color , fontSize: 20),),
                //     ]
                // ),
                //SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),

                  child: TextFormField(
                    controller: user,
                    decoration: InputDecoration(
                     // hintText: "Email".tr(),
                      label:Text("Email".tr()) ,
                      floatingLabelBehavior: FloatingLabelBehavior.auto
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      // border:
                      // OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter username";
                      }
                      return null;
                    },
                  ),
                ),
              //  SizedBox(width: 0.0,height: 5.0,),
                // Row(
                //     children: <Widget>[
                //       SizedBox(width: 20,),
                //       Icon(Icons.lock,size: 25,color:Theme.of(context).textTheme.headline1!.color,),
                //       SizedBox(width: 5,),
                //       Text("PassWord".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color , fontSize: 20),)
                //     ]
                // ),
              //  SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: TextFormField(
                    cursorColor:globalss.cblue ,
                    obscureText: _isObscure,
                    controller: pass,
                    decoration: InputDecoration(
                      focusColor:Theme.of(context).textTheme.headline1!.color ,
                      hoverColor:Theme.of(context).textTheme.headline1!.color ,
                      fillColor:Theme.of(context).textTheme.headline1!.color ,
                      suffixIcon:IconButton(
                        icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility , color:Theme.of(context).textTheme.headline4!.color,),
                        onPressed: (){
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },

                      ) ,
                    //  hintText: "PassWord".tr(),
                        label:Text("PassWord".tr()) ,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                  //   contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                  //   border:
                  //    OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
                  //       borderSide: BorderSide(
                  //         color: Color(0xFF2429F9),
                  //       ),
                  //     ),

                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter PassWord';
                      }
                      return null;
                    },
                  ),
                ),
               Row(
                 children: [
                   SizedBox(width: 16,),
                   SizedBox(

                     child:

                     TextButton(
                       style: TextButton.  styleFrom(
                         textStyle: const TextStyle(fontSize: 12,),

                         primary:Theme.of(context).textTheme.headline1!.color,


                       ),
                       onPressed: ()async{

                         Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => restpass()));
                       },
                       child: Text("Forgot Your Password?".tr(),style:TextStyle(color:Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold ),),

                     ),

                   ),
                 ],
               ),
                SizedBox(height: 15,),

Row(
  children: [
    SizedBox(width: 20,),
    Text("i dont have account"),
    TextButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => signup()),
          );

        },
        child: Text("sign up",style: TextStyle(color: Theme.of(context).textTheme.headline1!.color),))
  ],
),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,

                   // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      ElevatedButton(

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
                          await login();


                        },
                        child:  SizedBox(width:MediaQuery.of(context).size.width/3 ,child: Center(child: Text("Sign IN".tr(),style: TextStyle(color:globalss.cblue),))),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),

                          ),
                          primary: globalss.cblue,
                        ),
                        onPressed: () {
                          globalss.tokenfromserver="";
                          globalss.fname="";
                          globalss.lname="";
                          globalss.email="";
                          globalss.password="";
                          globalss.id="";
                          globalss.profileimage="";
                          globalss.userverified=false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => About()),
                          );
                        },
                       // child:  Text("Continue as guest".tr(),style:TextStyle(color: Colors.blue), ),
                        child:  SizedBox(width:MediaQuery.of(context).size.width/3 ,child: Center(child: Text("Continue as guest".tr(),style:TextStyle(color: Colors.white)))),

                      ),
                    ],
                  ),
                ),

                //
                // Padding(
                //   padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                //   child: SizedBox(
                //
                //     width: MediaQuery.of(context).size.width,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //           // side: BorderSide(color: Colors.red)
                //         ),
                //         primary: Colors.red,),
                //       onPressed: () async{
                //         await login();
                //
                //
                //       },
                //       child:  Text("Sign IN".tr()),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                //
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //           side: BorderSide(
                //               color: Colors.blue,
                //               width: 1,
                //               style: BorderStyle.solid
                //           ),
                //         ),
                //         primary: Colors.white,),
                //       onPressed: () {
                //         // Navigator.push(
                //         //   context,
                //         //   MaterialPageRoute(builder: (context) => signup()),
                //         // );
                //       },
                //       child:  Text("Sign UP".tr(),style:TextStyle(color: Colors.blue), ),
                //     ),
                //   ),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                //
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //           side: BorderSide(
                //               color: Colors.blue,
                //               width: 1,
                //               style: BorderStyle.solid
                //           ),
                //         ),
                //         primary: Colors.white,),
                //       onPressed: () {
                //         globalss.tokenfromserver="";
                //         globalss.fname="";
                //         globalss.lname="";
                //         globalss.email="";
                //         globalss.password="";
                //         globalss.id="";
                //         globalss.profileimage="";
                //         globalss.userverified=false;
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => newlandingpage()),
                //         );
                //       },
                //       child:  Text("Continue as guest".tr(),style:TextStyle(color: Colors.blue), ),
                //     ),
                //   ),
                // ),


                SizedBox(height: 100,)

              ],
            ),
          ),
        )

    );

  }
}
