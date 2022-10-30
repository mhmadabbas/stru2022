import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stru2022/Pages/GlobalPages/About.dart';
import 'package:stru2022/Pages/GlobalPages/ContactUs.dart';
import 'package:stru2022/Pages/Siginin.dart';

//import '../newlandingpage.dart';
import '../Pages/Application/ownapplication.dart';
import '../Pages/Scholar/favorite/favoriteUniversity.dart';
import '../Pages/Scholar/universitiesCategory.dart';
import '../Pages/broadcasts/archivebroadcasts.dart';
import '/Vars/globalss.dart' as globalss ;

class myBottomAppBarnew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.width*(10/375)),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Container(


                      width: MediaQuery.of(context).size.width*(30/375),
                      height: MediaQuery.of(context).size.width*(30/375),
                      child: SvgPicture.asset(
                        'assets/svgicon/Application.svg',
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        //Theme.of(context).textTheme.headline3!.color,
                      )
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ownapp()));
                  },
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width*(55/375),
                    height: MediaQuery.of(context).size.width*(14/375),
                    child: FittedBox(child: Text(" "+"BottomAppBar.Applications".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color),maxLines: 1,softWrap:false ,))),
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

                          width: MediaQuery.of(context).size.width*(30/375),
                          height: MediaQuery.of(context).size.width*(30/375),
                          child: SvgPicture.asset(
                            'assets/svgicon/Live.svg',
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) =>broadcastsarchive ()));
                      },),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*(55/375),
                      height: MediaQuery.of(context).size.width*(14/375),
                      child: FittedBox(
                          child: Text("  "+"BottomAppBar.Broadcast".tr()+"  ",style: TextStyle(color:Theme.of(context).textTheme.headline4!.color))),
                    ),

                  ],
                )
            ),
            Expanded(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Container(
                    // color: Colors.red,

                    height: 2,
                    width: 40,
                  ),

                  onPressed: () {  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => About()));  },),
                SizedBox(
                  width: MediaQuery.of(context).size.width*(65/375),
                  height: MediaQuery.of(context).size.width*(14/375),
                  child: FittedBox(
                      child: Text("BottomAppBar.Chat with us".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color,),maxLines: 1,)),
                ),

              ],
            )),
            //del
           // Expanded(child: new FloatingActionButton(onPressed: (){},child:ColoredBox(color: Colors.yellowAccent,))),
            Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Container(
                        // color: Colors.red,

                          width: MediaQuery.of(context).size.width*(30/375),
                          height: MediaQuery.of(context).size.width*(30/375),
                          child: SvgPicture.asset(
                            'assets/svgicon/university.svg',
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fit: BoxFit.fill,
                          )),

                      onPressed: () {
                        globalss.uncateforfilter = "";
                        globalss.Fromprossbar='';

                        globalss.unids="";
                        globalss.Degreeids="" ;
                        globalss.Courseids="";
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => uncategory()));
                        },),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*(55/375),
                      height: MediaQuery.of(context).size.width*(14/375),
                      child: FittedBox(
                          child: Text("BottomAppBar.Universities".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color,),maxLines: 1,)),
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

                          width: MediaQuery.of(context).size.width*(30/375),
                          height: MediaQuery.of(context).size.width*(30/375),
                          child: SvgPicture.asset(
                            'assets/svgicon/Favorites.svg',
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fit: BoxFit.cover,
                          )),

                      onPressed: () async{
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => favoriteuniversitiesList()));
                        //    KommunicateFlutterPlugin.logout();


                        // final SharedPreferences prefs = await SharedPreferences.getInstance();
                        // prefs.remove('username');
                        // prefs.remove('password');
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => LoginPage()));
                      },),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*(55/375),
                      height: MediaQuery.of(context).size.width*(14/375),
                      child: FittedBox(
                          child: Text("BottomAppBar.Favorites".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline4!.color,fontSize: 8))),
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