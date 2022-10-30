import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';



//import 'GlobalPages/privacy.dart';
import 'Siginin.dart';
import '../Vars/globalss.dart' as globalss;

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {

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
  Alert(context: context, image:Image.asset("assets/nm/WARNING.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "enter all fields required.".tr(),style:alertStyle).show();
  //return;
  return;
} else{
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text);

  int lenghtpass = pass.text.length;

if(!emailValid){
  Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid Email Address.".tr(),style:alertStyle).show();
  valid = false;
  return;
}

if(lenghtpass<6){
  Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "password too short min lenght 6 chars".tr(),style:alertStyle).show();
  valid = false;
  return;
}
if(confirmpass.text !=pass.text ){
  Alert(context: context, image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "passwords don't match".tr(),style:alertStyle).show();
  valid = false;
  return;
}
  if(!agreeterms){
    Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "you should agree terms and conditions to signup".tr(),style:alertStyle).show();
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
  Alert(
      context: context,
      image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,),
      desc: "An email has been sent to your email address containing an activation link. Please click on the link to activate your account.".tr(),
      buttons: [

  DialogButton(
  child: Text(
  "ok".tr(),
    style: TextStyle(color: Colors.white, fontSize: 12),
    ),
    onPressed: () {
      Navigator.pop(context);
    // Navigator.pushReplacement(
    // context,
    // MaterialPageRoute(builder: (context) => LoginPage()),
    // );
    },
    // width: 120,
    ),

    ],
  ).show();


  // Future.delayed(Duration(seconds: 1), () {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => LoginPage()),
  //   );
  // });

}else{
  Alert(context: context,image:Image.asset("assets/nm/WARNING.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "email alredy exist".tr()).show();

}

  }else{
    Alert(context: context, title: "error", desc: "try again").show();

  }

  return null;
}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:SingleChildScrollView(
          child: Form(
            key: _formKeyup,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [


                SizedBox(width: 0.0,height: 100.0,),
                // Row(
                //     children: <Widget>[
                //       SizedBox(width: 20,),
                //       Icon(Icons.email,size: 25,color:Theme.of(context).textTheme.headline1!.color,),
                //       SizedBox(width: 10,),
                //       Text("Email".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color , fontSize: 20),),
                //
                //
                //     ]
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20 ,bottom: 10),

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
                // Row(
                //     children: <Widget>[
                //       SizedBox(width: 20,),
                //       Icon(Icons.person_sharp,size: 25,color: Theme.of(context).textTheme.headline1!.color,),
                //       SizedBox(width: 10,),
                //       Text("First Name".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color , fontSize: 20),),
                //
                //
                //     ]
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),

                  child: TextFormField(
                    controller: firstname,
                    decoration: InputDecoration(
                     // hintText: ,
                        label:Text("First Name".tr()) ,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                      // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      // border:
                      // OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // Row(
                //     children: <Widget>[
                //       SizedBox(width: 20,),
                //       Icon(Icons.person_sharp,size: 25,color:Theme.of(context).textTheme.headline1!.color,),
                //       SizedBox(width: 10,),
                //       Text("Last Name".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color , fontSize: 20),),
                //
                //
                //     ]
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),

                  child: TextFormField(
                    controller: lastname,
                    decoration: InputDecoration(
                    //  hintText: "Last Name".tr(),
                        label:Text("Last Name".tr()) ,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                      // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      // border:
                      // OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // Row(
                //     children: <Widget>[
                //       SizedBox(width: 20,),
                //       Icon(Icons.lock,size: 25,color:Theme.of(context).textTheme.headline1!.color,),
                //       SizedBox(width: 10,),
                //       Text("PassWord".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color , fontSize: 20),),
                //
                //
                //     ]
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),
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
                     // hintText: "PassWord".tr(),
                        label:Text( "PassWord".tr()) ,
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                      // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      // border:
                      // OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // Row(
                //     children: <Widget>[
                //       SizedBox(width: 20,),
                //       Icon(Icons.lock,size: 25,color:Theme.of(context).textTheme.headline1!.color,),
                //       SizedBox(width: 10,),
                //       Text("Confirm Password".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color , fontSize: 20),),
                //
                //
                //     ]
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),
                  child: TextFormField(

                    obscureText: _isObscure,
                    controller: confirmpass,
                    decoration: InputDecoration(
                   //   isDense: true,
                    //  prefixStyle: ,

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
                      // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      // border:
                      // OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                //
                // Checkbox(
                //   value: agreeterms,
                //
                //   onChanged: (){
                //     setState((){
                //       agreeterms = true;
                //     });
                //   },
                // ),

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

                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
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
                    child:  SizedBox(width:MediaQuery.of(context).size.width ,child: Center(child: Text("register".tr(),style: TextStyle(color:globalss.cblue),))),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
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
                //           // side: BorderSide(color: Colors.red)
                //         ),
                //         //   BorderSide:
                //         // OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                //         //   border:OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                //
                //
                //         primary: Colors.white,),
                //
                //       onPressed: () async{
                //         await register();
                //       },
                //       child:  Text("register".tr(),style:TextStyle(color: Colors.blue), ),
                //     ),
                //   ),
                // ),
              SizedBox(height: 20,)



              ],
            ),
          ),
        )

    );
  }
}
