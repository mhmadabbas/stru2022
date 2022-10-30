import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/auth/Siginup.dart';
import 'Pages/home.dart';
import 'Pages/introduction/wellcome.dart';
import 'forthemes/config.dart';
import 'Vars/globalss.dart' as globalss ;
import 'forthemes/themecolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//firebase

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important Notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('main');

  print('A bg message just showed up :  ${message.messageId}');
}


//login auto
bool loginstate = false;

Future  autoLogIn() async{

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username')?? "";
  String password = prefs.getString('password')?? "";


  var map = new Map<String, dynamic>();
  map['_username'] =  username;
  map['_password'] = password;


  final response = await http.post(
      Uri.parse('https://studyinrussia.app/api/login_check'),
      body: map
  );

  if (response.statusCode == 200) {


    if(json.decode(response.body)["code"]==200){

      if(jsonDecode(response.body)["user"]["verified"]){
        globalss.tokenfromserver=jsonDecode(response.body)["token"].toString();
        globalss.fname=jsonDecode(response.body)["user"]["firstName"].toString();
        globalss.lname=jsonDecode(response.body)["user"]["lastName"].toString();
        globalss.email=jsonDecode(response.body)["user"]["email"].toString();
        globalss.password=password;
        globalss.id=jsonDecode(response.body)["user"]["id"].toString();
        globalss.profileimage=jsonDecode(response.body)["user"]["image"].toString();
        globalss.userverified=true;
        loginstate=true;
      }else{
        globalss.userverified=false;
        loginstate=false;
      }
    }else{
      loginstate=false;
    }
  }else{
    globalss.userverified=false;
    loginstate=false;
  }
  return null;
}
//
bool isoffline = true;
StreamSubscription? connection;

// mobb() async{
//   connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//     // whenevery connection status is changed.
//     if(result == ConnectivityResult.none){
//       //there is no any connection
//
//         isoffline = true;
//
//
//
//     }else if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi ){
//       //connection is mobile data network
//       //connection is from wifi
//
//         isoffline = false;
//
//     }
//
//   });
// }
//
void main() async {
//

//await mobb();

//


  WidgetsFlutterBinding.ensureInitialized();

  //if(!isoffline){ Duration(seconds: 15)
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
//8
    await autoLogIn();
 // }

   await EasyLocalization.ensureInitialized();


  final prefs = await SharedPreferences.getInstance();
  st = prefs.getBool("savedtheme")?? false;
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', ''), Locale('ar', ''),Locale('ru', '')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', ''),

      child: MyApp()
  ),
  );
}

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);
  bool vv = globalss.themeselected;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currenttheme.addListener(() {
      setState(() {

      });
    });
    // autoLogIn();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,


      theme:ThemeData(
        fontFamily: 'KumbhSans',
        brightness: Brightness.light,

       primarySwatch:Palette.kToBlue,
        primaryColor:Colors.white,
       // primarySwatch:createMaterialColor(Color(0xFF174378)),
        // primaryColor: Colors.white,
         textTheme:

        TextTheme(


          bodyText1: TextStyle(color: globalss.cblack),
          headline1: TextStyle(color: globalss.cblue,),
          headline2: TextStyle(color: globalss.cred),
          headline3: TextStyle(color: globalss.cgray),
          headline4: TextStyle(color: globalss.cblack.withOpacity(0.2)),
          headline5: TextStyle(color: globalss.cblack.withOpacity(0.3)),
        //for chat bg only
          headline6: TextStyle(color: globalss.cgraychat),
          bodyText2: TextStyle(color: globalss.cblack.withOpacity(0.3)),
          //color bg drawer
          labelMedium:TextStyle(color: globalss.cdrawerlight),
          //categores
          subtitle1: TextStyle(color: globalss.ccategores),


        ),



      ),

      darkTheme: ThemeData(
        fontFamily: 'KumbhSans',
        brightness:Brightness.dark ,

      //  primarySwatch: Colors.blue,

        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline3: TextStyle(color:  Colors.white),
          headline4: TextStyle(color: Colors.white.withOpacity(0.2)),
          headline5: TextStyle(color: Colors.white.withOpacity(0.3)),
          //for chat bg only
          headline6: TextStyle(color: globalss.cblue),
          bodyText2: TextStyle(color: Colors.white.withOpacity(0.3)),
          //color bg drawer
          labelMedium:TextStyle(color:globalss.cblack),
          //categores
          subtitle1: TextStyle(color: Colors.white),

        ),

      ),
      themeMode: currenttheme.currenttheme(),

//    home:(loginstate)?newlandingpage() : LoginPage(),
      home:

      (loginstate)?HomeLand():wellcomepage(),

    //  (isoffline)?signup22():((loginstate)?HomeLand():wellcomepage()),
    );
  }
}





