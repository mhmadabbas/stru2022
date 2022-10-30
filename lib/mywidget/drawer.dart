
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stru2022/Pages/GlobalPages/About.dart';
import 'package:stru2022/Pages/GlobalPages/ContactUs.dart';
import 'package:stru2022/Pages/GlobalPages/privacy.dart';


import 'package:stru2022/forthemes/config.dart';

 import '../Pages/Alumni/Consultation.dart';
import '../Pages/Alumni/RegistrationForm.dart';
import '../Pages/Application/ownapplication.dart';
import '../Pages/News/NewNewsCategores.dart';
import '../Pages/Notifications/notificationsList.dart';
import '../Pages/Posts/allPostsList.dart';
import '../Pages/Scholar/degreeList.dart';
import '../Pages/Scholar/favorite/favoriteUniversity.dart';
import '../Pages/Scholar/universitiesCategory.dart';
import '../Pages/auth/login.dart';
import '../Pages/broadcasts/archivebroadcasts.dart';
import '../Pages/home.dart';
import '../Pages/kommunicate/prechat.dart';
import '../Pages/profile/profileInfo.dart';

import '../Vars/globalss.dart' as globalss;
import '../Vars/globalss.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool mybool = false;
    return Container(
      width: double.infinity,
      child: Drawer(
        child: Container(

          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [






                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("drawer.Show More".tr(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodyText1!.color),),
                    IconButton(onPressed: (){
                    //  Scaffold.of(context).  openEndDrawer();
                      Navigator.pop(context);
                    }, icon:Icon(Icons.close,color:globalss.cgray ,size: 30,) ),

                  ],),




                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomeLand()));

                    },
                    child:   Row(children: [
                      SvgPicture.asset(
                        'assets/new_svg/home.svg',
                          color: Theme.of(context).textTheme.headline5!.color,
                        fit: BoxFit.contain,

                      ),
                      SizedBox(width: 10,),
                      Text('drawer.Home'.tr(),
                        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                    ],
                    ),
                  ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => profileInfoP())
                    );
                  },
                  child: Row(
                    children: [
                    SvgPicture.asset(
                      'assets/new_svg/profile.svg',
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Profile'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ownapp()));
                //    print("hi");
                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/application.svg',
                      color: Theme.of(context).textTheme.headline5!.color,
width: 18,
                      height: 18,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Applications'.tr(),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                GestureDetector(
                  onTap: (){
                    globalss.uncateforfilter = "";
                    globalss.Fromprossbar='';

                    globalss.unids="";
                    globalss.Degreeids="" ;
                    globalss.Courseids="";
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => uncategory()));

                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/unhat.svg',
                    //  width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Find Universities'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => degreeList()));
                    print("hi");
                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/open-book.svg',
                     // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Find Courses'.tr(),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) =>broadcastsarchive ())); //MyAppqqq

                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/broadcast.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Broadcast'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => allPosts()));

                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/forum.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Forum'.tr(),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),

                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => newnewscategory()));
                //    print("hi");
                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/news.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Latest News'.tr(),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),


                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Privacy()));
                    print("hi");
                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/terms.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Terms & Conditions'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                SizedBox(height: 10,),

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => favoriteuniversitiesList()));
                    // print("hi");
                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/favorrites.svg',
                       width: 18,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.fill,

                    ),
                    SizedBox(width: 10,),
                    Text('newlandingPage.Favorites'.tr(),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),

                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),


                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => About()));
                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/about.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.About Us'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),


                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),


                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PreChatPage()));

                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/chatwithteam.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Chat with our team'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),

                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),


                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => RegistrationForm()));



                  },
                  child:   Row(children: [
                    // SvgPicture.asset(
                    //   'assets/new_svg/contact.svg',
                    //   // width: 20,
                    //   color: Theme.of(context).textTheme.headline5!.color,
                    //   fit: BoxFit.contain,
                    //
                    // ),
                              FaIcon(
                                FontAwesomeIcons.userGraduate,size: 20,color: Theme.of(context).textTheme.headline5!.color,
                              ),
                    SizedBox(width: 10,),
                    Text('drawer.Alumni Chat'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),


                GestureDetector(
                  onTap: (){

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => consultation()));


                  },
                  child:   Row(children: [
                    // SvgPicture.asset(
                    //   'assets/new_svg/contact.svg',
                    //   // width: 20,
                    //   color: Theme.of(context).textTheme.headline5!.color,
                    //   fit: BoxFit.contain,
                    //
                    // ),
                    Icon(Icons.headset_mic_rounded,size: 20,color: Theme.of(context).textTheme.headline5!.color,),
                    // FaIcon(
                    //   FontAwesomeIcons.agent,size: 20,color: Theme.of(context).textTheme.headline5!.color,
                    // ),
                    SizedBox(width: 10,),
                    Text('drawer.Consultation'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),


                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),
//

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => contactus()));

                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/contact.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Contact Us'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),

                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),



                GestureDetector(
                  onTap: (){
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => contactus()));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => notificationslist0()));
                  },
                  child:   Row(children: [
                    SvgPicture.asset(
                      'assets/new_svg/notification.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.headline5!.color,
                      fit: BoxFit.contain,

                    ),
                    SizedBox(width: 10,),
                    Text('drawer.Notification'.tr(),
                      style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                  ],
                  ),
                ),
                // Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),
                //
                // GestureDetector(
                //   onTap: (){
                //     Navigator.pushReplacement(context,
                //         MaterialPageRoute(builder: (context) => consultation()));
                //
                //   },
                //   child:   Row(children: [
                //     SvgPicture.asset(
                //       'assets/new_svg/notification.svg',
                //       // width: 20,
                //       color: Theme.of(context).textTheme.headline5!.color,
                //       fit: BoxFit.contain,
                //
                //     ),
                //     SizedBox(width: 10,),
                //     Text("Consultation",
                //       style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                //   ],
                //   ),
                // ),
                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),
                //    DropdownButton(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         Container(
                //           height: 20,
                //           width: 20,
                //           child:
                //           FaIcon(
                //             FontAwesomeIcons.language,size: 20,color: Theme.of(context).textTheme.headline5!.color,
                //           ),
                //         ),
                //
                //
                //         SizedBox(width: 10,),
                //         Text(
                //           'drawer.Change Language'.tr(),
                //           style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 16),
                //         ),
                //       ],
                //     ),
                //     DropdownButton<String>(
                //       underline: Container(
                //
                //       ),
                //
                //
                //       iconSize: 30,
                //       icon: Padding( //Icon at tail, arrow bottom is default icon
                //           padding: EdgeInsets.only(left:20),
                //           child:Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,)
                //       ),
                //       items: [ //add items in the dropdown
                //         DropdownMenuItem(
                //           child: Text("English"),
                //           value: "English",
                //         ),
                //         DropdownMenuItem(
                //             child: Text("عربي"),
                //             value: "عربي"
                //         ),
                //         DropdownMenuItem(
                //             child: Text("русский"),
                //             value: "ru"
                //         ),
                //
                //
                //       ],
                //       onChanged: (value) {
                //         if(value=='عربي'){
                //           context.setLocale(Locale('ar', ''));
                //         }
                //         if(value=='English'){
                //           context.setLocale(Locale('en', ''));  }
                //         if(value=='ru'){
                //           context.setLocale(Locale('ru', ''));  }
                //       },
                //
                //     ),
                //
                //   ],
                // ),


//next dell
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        var alertStyle = AlertStyle(
                          alertPadding: EdgeInsets.only(right: 0,left: 0),
                          animationType: AnimationType.fromBottom,
                          isCloseButton: false,
                          isOverlayTapDismiss: true,
                          descStyle: TextStyle(fontWeight: FontWeight.bold),
                          descTextAlign: TextAlign.start,
                          animationDuration: Duration(milliseconds: 400),
                          alertBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          titleStyle: TextStyle(
                            color: Colors.red,

                          ),
                          alertAlignment: Alignment.bottomCenter,
                        );

                        Alert(

                          //width: MediaQuery.of(context).size.width ,
                            style: alertStyle,
                            context: context,
                            // title: "chose language plas uah",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text("drawer.Choose new language".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold)),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),
                                TextButton.icon(
                                  icon: CircleAvatar(
                                    backgroundColor:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Color(0xffDFDFDF): Color(0xff575757),
                                    radius:MediaQuery.of(context).size.width*(15/375),
                                    child:SizedBox(
                                       height: MediaQuery.of(context).size.width*(15/375),
                                      //  width: MediaQuery.of(context).size.width*(15/375),
                                        child: Image.asset("assets/22images/eflag.png",fit: BoxFit.fill,)),
                                    // child:
                                    // Icon(FontAwesomeIcons.rus,size:MediaQuery.of(context).size.width*(14/375),color: Colors.black.withOpacity(0.3),
                                    // ),
                                  ),
                                  label: Text('drawer.English language'.tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold)),
                                  onPressed: () async{

                                    context.setLocale(Locale('en', ''));
                                    Navigator.pop(context);

                                  },
                                ),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),
                                TextButton.icon(

                                  icon: CircleAvatar(
                                    backgroundColor:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Color(0xffDFDFDF): Color(0xff575757),
                                    radius:MediaQuery.of(context).size.width*(15/375),
                                    child:SizedBox(
                                        height: MediaQuery.of(context).size.width*(15/375),
                                        //  width: MediaQuery.of(context).size.width*(15/375),
                                        child: Image.asset("assets/22images/ruflag.png",fit: BoxFit.fill,)),                                  ),


                                  label: Text('drawer.Russian language'.tr(),style:TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold)),
                                  onPressed: () async{
                                    context.setLocale(Locale('ru', ''));
                                    Navigator.pop(context);

                                  },
                                ),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),
                                TextButton.icon(

                                  icon: CircleAvatar(
                                    backgroundColor:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Color(0xffDFDFDF): Color(0xff575757),
                                    radius:MediaQuery.of(context).size.width*(15/375),
                                    child:SizedBox(
                                        height: MediaQuery.of(context).size.width*(15/375),
                                        //  width: MediaQuery.of(context).size.width*(15/375),
                                        child: Image.asset("assets/22images/arflag.png",fit: BoxFit.fill,)),                                  ),


                                  label: Text('drawer.Arabic language'.tr(),style:TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold)),
                                  onPressed: () async{

                                    context.setLocale(Locale('ar', ''));
                                    Navigator.pop(context);
                                  },
                                ),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),


                                ElevatedButton(

                                  onPressed: () async{
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    primary: globalss.cblue,
                                  ),
                                  child: SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width,
                                      child: Center(
                                          child: Text("ApplytoCourse.close".tr(),
                                              style: TextStyle(
                                                  color: Colors.white)))),
                                ),
                                SizedBox(height: 50,)

                              ],
                            ),
                            buttons: [
                              // DialogButton(
                              //   onPressed: () => Navigator.pop(context),
                              //   child: Text(
                              //     "LOGIN",
                              //     style: TextStyle(color: Colors.white, fontSize: 20),
                              //   ),
                              // )
                            ]).show();
                      },
                      child: Row(
                        children: [
                          // Container(
                          //   // color: Colors.red,
                          //
                          //     height: 20,
                          //     width: 20,
                          //     child: SvgPicture.asset(
                          //       'assets/svgicon/changlang.svg',
                          //       //color:Theme.of(context).textTheme.headline4!.color,
                          //       fit: BoxFit.contain,
                          //     )
                          // ),
                                    FaIcon(
                                      FontAwesomeIcons.fontAwesomeFlag,size: 20,color: Theme.of(context).textTheme.headline5!.color,
                                    ),


                          SizedBox(width: 10,),
                          Text(
                            'drawer.Change Language'.tr(),
                            style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 16),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),

                //



                Divider(color:Theme.of(context).textTheme.headline5!.color ,thickness: 1,),

                GestureDetector(
                  onTap: (){
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => newlandingpage()));
                    print("hi");
                  },
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/new_svg/theme.svg',
                            // width: 20,
                            color: Theme.of(context).textTheme.headline5!.color,
                            fit: BoxFit.contain,

                          ),
                          SizedBox(width: 10,),
                          Text('drawer.Dark Theme'.tr(),
                            style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),),
                        ],
                      ),
                      Switch(
                        value: (!st!),
                        onChanged: (value) {
                          currenttheme.SwitchTheme();
                        },
                      ),

                    ],
                  )
                ),

                ElevatedButton(

                  style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        // side: BorderSide(
                        //     color: globalss.cblue,
                        //     width: 1,
                        //     style: BorderStyle.solid
                        // ),
                        // side: BorderSide(color: Colors.red)
                      ),
                      primary:globalss.cgray,
                  ),
                  onPressed: () async{
                    KommunicateFlutterPlugin.logout();
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('username');
                    prefs.remove('password');
                    globalss.tokenfromserver ="";
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));

                  },
                  child:  SizedBox(
                      width:MediaQuery.of(context).size.width ,child: Center(child: Text("drawer.Logout".tr(),
                    style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,),))),
                ),
                SizedBox(height: 20,)






                //
                //
                //
                // Container(
                //   padding: EdgeInsets.all(2.0),
                //   child: Center(
                //       child: Column(
                //         children: [
                //           // Text("Please Pick Up a Theme",style: TextStyle(color: Colors.white,fontSize: 16 ),),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Switch(
                //                 value: (!st!),
                //                 onChanged: (value) {
                //                   currenttheme.SwitchTheme();
                //                 },
                //               ),
                //               TextButton(
                //                   onPressed: () {
                //                     // currenttheme.SwitchTheme();
                //                   },
                //                   child: Text('drawer.Dark Theme'.tr(),
                //                       style: TextStyle(
                //                           color: Colors.white, fontSize: 16))),
                //
                //               // TextButton(onPressed:(){                  currenttheme.SwitchTheme();
                //               // } , child: Text("light",style: TextStyle(color: Colors.white,fontSize: 10 ))),
                //             ],
                //           )
                //         ],
                //       )),
                // ),
                // Divider(
                //   thickness: 1,
                //   color: Colors.white,
                //   endIndent: 50,
                //   indent: 50,
                // ),
                //
                //
                //
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text('drawer.Find Universities'.tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/university.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       globalss.uncateforfilter = "";
                //       globalss.Fromprossbar='';
                //
                //       globalss.unids="";
                //       globalss.Degreeids="" ;
                //       globalss.Courseids="";
                //
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (context) => uncategory()));
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Find Courses".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/COURSES.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       // Navigator.push(context,
                //       //     MaterialPageRoute(builder: (context) => degreeList()));
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Broadcast".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/BROADCAST.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       // Navigator.push(context,
                //       //     MaterialPageRoute(builder: (context) => broadcastsarchive()));
                //
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Forum".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/FORUM.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       // Navigator.push(context,
                //       //     MaterialPageRoute(builder: (context) => allPosts()));
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.News".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/NEWS.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       // Navigator.push(context,
                //       //     MaterialPageRoute(builder: (context) => newscategory()));
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Terms of Use".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/termsofnews.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(builder: (context) => Privacy()),
                //       // );
                //       // Update the state of the app.
                //       // ...
                //     },
                //   ),
                // ),
                // Divider(
                //   thickness: 1,
                //   color: Colors.white,
                //   endIndent: 50,
                //   indent: 50,
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Favorites".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/Favorites.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //
                //
                //       if(globalss.userverified){
                //         globalss.unids="";
                //         globalss.Degreeids="" ;
                //         globalss.Courseids="";
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => favoriteuniversitiesList()));
                //       }else{
                //         Alert(
                //           context: context,
                //           image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,),
                //           desc: "You should login to see this content".tr(),
                //           buttons: [
                //
                //             DialogButton(
                //               child: Text(
                //                 "Login".tr(),
                //                 style: TextStyle(color: Colors.white, fontSize: 10),
                //               ),
                //               onPressed: () {
                //                 Navigator.pushReplacement(
                //                   context,
                //                   MaterialPageRoute(builder: (context) => LoginPage()),
                //                 );
                //               },
                //               width: 120,
                //             ),
                //             DialogButton(
                //               child: Text(
                //                 "Cancel".tr(),
                //                 style: TextStyle(color: Colors.white, fontSize: 10),
                //               ),
                //               onPressed: () => Navigator.pop(context),
                //
                //               width: 120,
                //             )
                //           ],
                //         ).show();
                //       }
                //     },
                //   ),
                // ),
                //
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.About Us".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/AboutUs.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (context) => About()));
                //
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Chat with team".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/chat.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       if(globalss.userverified){
                //         // Navigator.push(context,
                //         //     MaterialPageRoute(builder: (context) => PreChatPage()));
                //       }else{
                //         Alert(
                //           context: context,
                //           image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,),
                //           desc: "You should login to see this content".tr(),
                //           buttons: [
                //
                //             DialogButton(
                //               child: Text(
                //                 "Login".tr(),
                //                 style: TextStyle(color: Colors.white, fontSize: 10),
                //               ),
                //               onPressed: () {
                //                 Navigator.pushReplacement(
                //                   context,
                //                   MaterialPageRoute(builder: (context) => LoginPage()),
                //                 );
                //               },
                //               width: 120,
                //             ),
                //             DialogButton(
                //               child: Text(
                //                 "Cancel".tr(),
                //                 style: TextStyle(color: Colors.white, fontSize: 10),
                //               ),
                //               onPressed: () => Navigator.pop(context),
                //
                //               width: 120,
                //             )
                //           ],
                //         ).show();
                //       }
                //
                //       // Update the state of the app.
                //       // ...
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Contact Us".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/contactus.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //       // Navigator.push(
                //       //     context,   MaterialPageRoute(builder: (context) => contactus()
                //       // ));
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Notification".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: Icon(
                //           Icons.notifications_outlined ,
                //           color: Colors.white,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () {
                //
                //       if(globalss.userverified){
                //         // Navigator.push(context,
                //         //     MaterialPageRoute(builder: (context) => notificationslist0()));
                //       }else{
                //         Alert(
                //           context: context,
                //           image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,),
                //           desc: "You should login to see this content".tr(),
                //           buttons: [
                //
                //             DialogButton(
                //               child: Text(
                //                 "Login".tr(),
                //                 style: TextStyle(color: Colors.white, fontSize: 10),
                //               ),
                //               onPressed: () {
                //                 Navigator.pushReplacement(
                //                   context,
                //                   MaterialPageRoute(builder: (context) => LoginPage()),
                //                 );
                //               },
                //               width: 120,
                //             ),
                //             DialogButton(
                //               child: Text(
                //                 "Cancel".tr(),
                //                 style: TextStyle(color: Colors.white, fontSize: 10),
                //               ),
                //               onPressed: () => Navigator.pop(context),
                //
                //               width: 120,
                //             )
                //           ],
                //         ).show();
                //       }
                //     },
                //   ),
                // ),
                // // SizedBox(height: 20,),
                // SizedBox(
                //   height: 35,
                //   child: ListTile(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     dense: true,
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //
                //     title: Text("drawer.Logout".tr(),
                //         style: TextStyle(color: Colors.white,fontSize: 16)),
                //     leading: Container(
                //         // color: Colors.red,
                //
                //         height: 40,
                //         width: 40,
                //         child: SvgPicture.asset(
                //           'assets/SVG_ICONS/logout.svg',
                //           color: Colors.white,
                //           fit: BoxFit.cover,
                //         )),
                //
                //     // Icon(Icons.access_alarm),
                //
                //     onTap: () async{
                //   //    KommunicateFlutterPlugin.logout();
                //
                //
                //       final SharedPreferences prefs = await SharedPreferences.getInstance();
                //       prefs.remove('username');
                //       prefs.remove('password');
                //       Navigator.pushReplacement(context,
                //           MaterialPageRoute(builder: (context) => LoginPage()));
                //       // var alertStyle = AlertStyle(
                //       //   animationType: AnimationType.fromTop,
                //       //   isCloseButton: false,
                //       //   isOverlayTapDismiss: false,
                //       //   descStyle: TextStyle(fontWeight: FontWeight.bold),
                //       //   descTextAlign: TextAlign.start,
                //       //   animationDuration: Duration(milliseconds: 400),
                //       //   alertBorder: RoundedRectangleBorder(
                //       //     borderRadius: BorderRadius.circular(15.0),
                //       //     side: BorderSide(
                //       //       color: Colors.grey,
                //       //     ),
                //       //   ),
                //       //   titleStyle: TextStyle(
                //       //     color: Colors.red,
                //       //   ),
                //       //   alertAlignment: Alignment.topCenter,
                //       // );
                //       //
                //       //
                //       // Alert(
                //       //   context: context,
                //       //   style: alertStyle,
                //       //   type: AlertType.info,
                //       //   title: "RFLUTTER ALERT",
                //       //   desc: "Flutter is more awesome with RFlutter Alert.",
                //       //   buttons: [
                //       //     DialogButton(
                //       //       child: Text(
                //       //         "COOL",
                //       //         style: TextStyle(color: Colors.white, fontSize: 20),
                //       //       ),
                //       //       onPressed: () => Navigator.pop(context),
                //       //       color: Color.fromRGBO(0, 179, 134, 1.0),
                //       //       radius: BorderRadius.circular(0.0),
                //       //     ),
                //       //   ],
                //       // ).show();
                //
                //
                //
                //       // Alert(
                //       //     context: context,
                //       //     title: "LOGIN",
                //       //     content: Column(
                //       //       children: <Widget>[
                //       //         TextField(
                //       //           decoration: InputDecoration(
                //       //             icon: Icon(Icons.account_circle),
                //       //             labelText: 'Username',
                //       //           ),
                //       //         ),
                //       //         TextField(
                //       //           obscureText: true,
                //       //           decoration: InputDecoration(
                //       //             icon: Icon(Icons.lock),
                //       //             labelText: 'Password',
                //       //           ),
                //       //         ),
                //       //       ],
                //       //     ),
                //       //     buttons: [
                //       //       DialogButton(
                //       //         onPressed: () => Navigator.pop(context),
                //       //         child: Text(
                //       //           "LOGIN",
                //       //           style: TextStyle(color: Colors.white, fontSize: 20),
                //       //         ),
                //       //       )
                //       //     ]).show();
                //      //  Alert(
                //      //    context: context,
                //      //    image: Image.asset("assets/image/studyinrussialogopng2.png",height: 50,width: 50,),
                //      // //   type: AlertType.info,
                //      //    title: "RFLUTTER ALERT",
                //      //    desc: "Flutter is more awesome with RFlutter Alert.",
                //      //    buttons: [
                //      //      DialogButton(
                //      //        child: Text(
                //      //          "COOL",
                //      //          style: TextStyle(color: Colors.white, fontSize: 20),
                //      //        ),
                //      //        onPressed: () => Navigator.pop(context),
                //      //        color: Color.fromRGBO(0, 179, 134, 1.0),
                //      //        radius: BorderRadius.circular(0.0),
                //      //      ),
                //      //    ],
                //      //  ).show();
                //      //  final SharedPreferences prefs = await SharedPreferences.getInstance();
                //      //  prefs.remove('username');
                //      //  prefs.remove('password');
                //      //  Navigator.pushReplacement(context,
                //      //      MaterialPageRoute(builder: (context) => LoginPage()));
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // // Container(
                // //   child: Center(
                // //       child: Column(
                // //     children: [
                // //       Text(
                // //         'drawer.Change Language'.tr(),
                // //         style: TextStyle(color: Colors.white, fontSize: 16),
                // //       ),
                // //       Row(
                // //         mainAxisAlignment: MainAxisAlignment.center,
                // //         children: [
                // //           TextButton(
                // //               onPressed: () {
                // //                 // context.locale = Locale('ar','');
                // //                 context.setLocale(Locale('ar', ''));
                // //               },
                // //               child: Text("عربي",
                // //                   style: TextStyle(
                // //                       color: Colors.white, fontSize: 10))),
                // //           TextButton(
                // //               onPressed: () {
                // //                 //  context.locale = Locale('en','');
                // //                 context.setLocale(Locale('en', ''));
                // //               },
                // //               child: Text("English",
                // //                   style: TextStyle(
                // //                       color: Colors.white, fontSize: 10))),
                // //         ],
                // //       )
                // //     ],
                // //   )),
                // // ),
                // // Container(
                // //   padding: EdgeInsets.all(2.0),
                // //   child: Center(
                // //       child: Column(
                // //     children: [
                // //       // Text("Please Pick Up a Theme",style: TextStyle(color: Colors.white,fontSize: 16 ),),
                // //       Row(
                // //         mainAxisAlignment: MainAxisAlignment.center,
                // //         children: [
                // //           Switch(
                // //             value: (!st!),
                // //             onChanged: (value) {
                // //               currenttheme.SwitchTheme();
                // //             },
                // //           ),
                // //           TextButton(
                // //               onPressed: () {
                // //                 // currenttheme.SwitchTheme();
                // //               },
                // //               child: Text('drawer.Dark Theme'.tr(),
                // //                   style: TextStyle(
                // //                       color: Colors.white, fontSize: 16))),
                // //
                // //           // TextButton(onPressed:(){                  currenttheme.SwitchTheme();
                // //           // } , child: Text("light",style: TextStyle(color: Colors.white,fontSize: 10 ))),
                // //         ],
                // //       )
                // //     ],
                // //   )),
                // // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
