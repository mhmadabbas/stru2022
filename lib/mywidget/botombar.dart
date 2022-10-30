import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stru2022/Pages/GlobalPages/About.dart';
import 'package:stru2022/Pages/GlobalPages/ContactUs.dart';
import 'package:stru2022/Pages/Siginin.dart';

//import '../newlandingpage.dart';
import '/Vars/globalss.dart' as globalss ;

class myBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Container(


                      height: 40,
                      width: 40,
                      child: SvgPicture.asset(
                        'assets/svgicon/Application.svg',
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        //Theme.of(context).textTheme.headline3!.color,
                      )
                  ),
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => newlandingpage()));
                  },
                ),
                SizedBox(
                  width: 60,
                    child: FittedBox(child: Text(" "+"drawer.Applications".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color),maxLines: 1,softWrap:false ,))),
              ],
            )
            ),
            Expanded(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    //  icon: Icon(Icons.show_chart),
                    icon:Container(


                        height: 40,
                        width: 40,
                        child: SvgPicture.asset(
                          'assets/svgicon/Live.svg',
                          color: Colors.white,
                        )
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,   MaterialPageRoute(builder: (context) => contactus()
                      ));
                    },),
                  SizedBox(
                    width: 40,
                    child: FittedBox(
                        child: Text("  "+"drawer.News".tr()+"  ",style: TextStyle(color:Colors.white))),
                  ),

                ],
              )
            ),
           // Expanded(child: new Text('')),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Container(
                      // color: Colors.red,

                        height: 40,
                        width: 40,
                        child: SvgPicture.asset(
                          'assets/svgicon/university.svg',
                          color: Colors.red,
                          fit: BoxFit.fill,
                        )),

                    onPressed: () {                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => About()));  },),
                  SizedBox(
                    width: 40,
                    child: FittedBox(
                        child: Text("newlandingPage.Universities".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color,),maxLines: 1,)),
                  ),

                ],
              )
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  IconButton(
                    icon:Container(
                      // color: Colors.red,

                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/svgicon/Favorites.svg',
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fit: BoxFit.cover,
                        )),

                    onPressed: () async{
                      //    KommunicateFlutterPlugin.logout();


                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('username');
                      prefs.remove('password');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },),
                  SizedBox(
                    width: 40,
                    child: FittedBox(
                        child: Text("newlandingPage.Favorites".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color,fontSize: 8))),
                  ),

                ],
              )
            ),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  IconButton(
                    icon:Container(
                      // color: Colors.red,

                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/svgicon/Showmore.svg',
                          color:Theme.of(context).textTheme.headline4!.color,
                          fit: BoxFit.contain,
                        )
                    ),


                    onPressed: () async{
                      Scaffold.of(context).openEndDrawer();
                      // //    KommunicateFlutterPlugin.logout();
                      //
                      //
                      // final SharedPreferences prefs = await SharedPreferences.getInstance();
                      // prefs.remove('username');
                      // prefs.remove('password');
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  SizedBox(
                    width: 40,
                    child: FittedBox(
                        child: Text("Show More".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color,fontSize: 12))),
                  ),

                ],
              )
            ),
          ],
        ),
      ),
    );
  }

}