
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Vars/globalss.dart' as globalss;

class myFloatingActionButton extends StatelessWidget {

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Opening conversation, Please Wait....",
                          style:
                          TextStyle(fontSize: 15, color: Colors.black),
                        )
                      ]),
                    )
                  ]
              )
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      backgroundColor:Theme.of(context).primaryColor,
      shape:  BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      onPressed: ()async {

        //
        //
        //
        //
        // try {
        //   dynamic kmUser;
        //   if(globalss.email==""){
        //     kmUser = {
        //       'userId':"nulluser@mail.com",
        //       //emailController.text,dfdh
        //       'displayName':"null user"
        //     };
        //
        //   }else{
        //     kmUser = {
        //       'userId':"7"+globalss.email,
        //       //emailController.text,dfdh
        //       'displayName':"7"+globalss.fname+" "+globalss.lname
        //     };
        //   }
        //
        //   dynamic conversationObject = {
        //     'appId': AppConfig.APP_ID,// The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
        //     'isSingleConversation': true,
        //     'kmUser': jsonEncode(kmUser)
        //   };
        //   dynamic result = await KommunicateFlutterPlugin.buildConversation(conversationObject);
        //   print("Conversation builder success : " + result.toString());
        // } on Exception catch (e) {
        //   print("Conversation builder error occurred : " + e.toString());
        // }

      },
      child:Container(
        // color: Colors.red,

          height: 30,
          width: 30,
          child: SvgPicture.asset(
            'assets/svgicon/chatwithteam.svg',
            color: Colors.red,
            fit: BoxFit.cover,
          )),


      // Image.asset('assets/svgicon/chatwithteam.svg',fit: BoxFit.fill,),
    );
  }

}




// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:kommunicate_flutter/kommunicate_flutter.dart';
// import 'package:studyinrussia/Pages/kommunicate/AppConfig.dart';
//
// import '../../Vars/globalss.dart' as globalss;
//
// class myFloatingActionButton extends StatelessWidget {
//
//   static Future<void> showLoadingDialog(
//       BuildContext context, GlobalKey key) async {
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return new WillPopScope(
//               onWillPop: () async => false,
//               child: SimpleDialog(
//                   key: key,
//                   backgroundColor: Colors.white,
//                   children: <Widget>[
//                     Center(
//                       child: Column(children: [
//                         CircularProgressIndicator(),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "Opening conversation, Please Wait....",
//                           style:
//                           TextStyle(fontSize: 15, color: Colors.black),
//                         )
//                       ]),
//                     )
//                   ]
//               )
//           );
//         }
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return FloatingActionButton(
//       backgroundColor:Theme.of(context).primaryColor,
//       shape:  BeveledRectangleBorder(
//           borderRadius: BorderRadius.circular(5)
//       ),
//       onPressed: ()async {
//
//
//
//
//
// try {
//   dynamic kmUser;
//   if(globalss.email==""){
//     kmUser = {
//       'userId':"nulluser@mail.com",
//       //emailController.text,dfdh
//       'displayName':"null user"
//     };
//
//   }else{
//     kmUser = {
//       'userId':"7"+globalss.email,
//       //emailController.text,dfdh
//       'displayName':"7"+globalss.fname+" "+globalss.lname
//     };
//   }
//
//   dynamic conversationObject = {
//     'appId': AppConfig.APP_ID,// The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
//     'isSingleConversation': true,
//     'kmUser': jsonEncode(kmUser)
//   };
//   dynamic result = await KommunicateFlutterPlugin.buildConversation(conversationObject);
//   print("Conversation builder success : " + result.toString());
// } on Exception catch (e) {
//   print("Conversation builder error occurred : " + e.toString());
// }
//
//       },
//       child:Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
//     );
//   }
//
// }