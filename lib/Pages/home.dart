import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import 'package:stru2022/Pages/profile/profileInfo.dart';

import 'package:stru2022/mywidget/drawer.dart';

import '../../mywidget/botombarnew.dart';


import '../Model/News.dart';
import '../Model/universities.dart';
import '../mywidget/appbarnonimage.dart';
import '/Vars/globalss.dart' as globalss;
import 'GlobalPages/ContactUs.dart';
import 'News/NewNewsCategores.dart';
import 'News/newnewsdetails.dart';
import 'Posts/allPostsList.dart';
import 'Scholar/degreeList.dart';
import 'Scholar/universitiesCategory.dart';
import 'Scholar/universitiesInfo.dart';
import 'broadcasts/archivebroadcasts.dart';
import 'kommunicate/prechat.dart';

class HomeLand extends StatefulWidget {
  HomeLand({Key? key}) : super(key: key);

  @override
  _HomeLandState createState() => _HomeLandState();
}





class _HomeLandState extends State<HomeLand> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  StreamSubscription? connection;
  bool isoffline = false;


  String fullname =globalss.fname+globalss.lname;
  String ascicode = "";

  generate(){
    String tascicode="";
    for(int i = 0; i <fullname.length; i++) {
      fullname.codeUnitAt(i);
      tascicode = tascicode + fullname.codeUnitAt(i).toString();
    }
    setState(() {
      ascicode = tascicode+"000000000000000000000000000000000000";
    });
  }


  @override
  void initState() {

    generate();

    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi ){
        //connection is mobile data network
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }

    });
    super.initState();
  }


  Future<GetUniversities> getsilverUN() async {
    generate();

      String Url;
      Url =
      'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&featured=1';

      final response = await http.get(
        Uri.parse(Url),
        headers: {"Authorization": "bearer " + globalss.tokenfromserver},
      );
      GetUniversities getUniversitiesFromJson(String str) =>
          GetUniversities.fromJson(convert.json.decode(response.body));

      final getun = getUniversitiesFromJson(response.body);

      print(getun.message);

      if (response.statusCode == 200) {
        GetUniversities getUniversitiesFromJson(String str) =>
            GetUniversities.fromJson(convert.json.decode(response.body));

        final getun = getUniversitiesFromJson(response.body);

        return getun;
      } else {
        print("some error not 200");
        return getun;
      }




  }
  List<Datumn> datan = [];
  String catnumber='notnumber' ;
  int currentPage = 1;
  Future<GetNews> getNews() async {



    currentPage = 1;


    String Url;
    if(catnumber=='notnumber'){
      Url = 'https://studyinrussia.app/api/news?lang=${context.locale.toString()}&page=$currentPage';
    }else{
      Url = 'https://studyinrussia.app/api/news?lang=${context.locale.toString()}&category=$catnumber&page=$currentPage';

    }


    print(Url);
    final response = await http.get(
      Uri.parse(Url),
    );
    GetNews getNewsFromJson(String str) => GetNews.fromJson(convert.json.decode(response.body));


    final getnews = getNewsFromJson(response.body);

    print(getnews.message);


    if (response.statusCode == 200) {
      GetNews getNewsFromJson(String str) => GetNews.fromJson(convert.json.decode(response.body));
      final getnews = getNewsFromJson(response.body);


      datan = [];
      datan = getnews.data;



      return getnews;
    }else{
      print("some error not 200");
      return getnews;

    }



  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return (!isoffline)? Scaffold(
      key: _scaffoldkey,
      //  backgroundColor: Colors.white,
      endDrawer: MyDrawer(),
      appBar: appbarnonimage(),

      bottomNavigationBar: myBottomAppBarnew(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 25,
                ),
                FloatingActionButton(
                    elevation: 0,
                    backgroundColor:
                        Theme.of(context).textTheme.headline6!.color,

                    // shape: BoxShape.circle,
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PreChatPage()));
                    },
                    child: SvgPicture.asset(
                      'assets/svgicon/chatlastsvg.svg',
                      // width: 20,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      fit: BoxFit.contain,
                    )

                    // Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
                    )
              ],
            )
          : null,

      extendBodyBehindAppBar: true,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width *(326/375),
              child: Stack(
                children: [
                  SizedBox(
                    //   height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/22images/home/home.png',
                      // color:Theme.of(context).textTheme.headline1!.color,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.width * (244/375),
                    ),
                  ),
                  Positioned(
                    left:MediaQuery.of(context).size.width*(15/375),
                    right: MediaQuery.of(context).size.width*(15/375),
                    top: 0,
                    child: Padding(
                      padding:  EdgeInsets.all( MediaQuery.of(context).size.width*(5/375)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text("home.Hello ".tr()+"\n"+globalss.fname,
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.white,
                                        decoration: TextDecoration.none))),
                            SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: FittedBox(
                                child: Text("home.Welcome to your comprehensive guidance to study in Russia".tr(), style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none)
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                  //2
                  Positioned.fill(
                    top: MediaQuery.of(context).size.width *(115/375),
                    child: Padding(
                      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width *(15/375), right: MediaQuery.of(context).size.width *(15/375)),
                      child: Center(
                        child: Image.asset(
                          'assets/22images/home/blackcard.png',
                          height:MediaQuery.of(context).size.width *(169/375) ,
                          width: MediaQuery.of(context).size.width *(345/375),



                          // color:Theme.of(context).textTheme.headline1!.color,
                          fit: BoxFit.fill,

                          // height: MediaQuery.of(context).size.height/5,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: MediaQuery.of(context).size.width *(135/375),
                    child: Padding(
                      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width *(30/375), right: MediaQuery.of(context).size.width *(30/375)),
                      child: SizedBox(
                        height:  MediaQuery.of(context).size.width *(132/375),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*(15/375) ,left:MediaQuery.of(context).size.width*(15/375) ,top: MediaQuery.of(context).size.width*(20/375)),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width*(27/375),
                                width: MediaQuery.of(context).size.width*(85/375),
                                child: Image.asset(
                                  'assets/22images/logo22.png',
                                  color:Colors.white,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height:MediaQuery.of(context).size.width*(30/375) ,),
                            Padding(
                              padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*(15/375) ,left:MediaQuery.of(context).size.width*(15/375) ),

                              child: Text(ascicode.substring(0,4)+" "+ascicode.substring(4,8)+" "+ascicode.substring(8,12)+" "+ascicode.substring(12,16),style:TextStyle(color: Colors.white,fontSize: 14,)),
                            ),
                            SizedBox(height:MediaQuery.of(context).size.width*(5/375) ,),

                            Padding(
                              padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*(15/375) ,left:MediaQuery.of(context).size.width*(15/375) ),

                              child: Text(globalss.fname+" "+globalss.lname,style:TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)),
                            ),


                          ],
                        ),
                      )
                    ),
                  ),
                  //3
                  Positioned.fill(
                      top:  MediaQuery.of(context).size.width * (259/375),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 315 / 67,
                            child: Container(
                              //  width: 200,
                              height: 80,

                              decoration: BoxDecoration(
                              // color: Colors.white,
                                color:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? Colors.white:Color(0xff383838),
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    //offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                  Positioned.fill(
                      top:  MediaQuery.of(context).size.width * (259/375),
                      child: Padding(
                        padding:  EdgeInsets.only(left:  MediaQuery.of(context).size.width * (30/375), right: MediaQuery.of(context).size.width * (30/375)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(),
                            SizedBox(
                              height:MediaQuery.of(context).size.width * (67/375) ,

                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => profileInfoP())
                                  );

                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                   // Icon(Icons.ac_unit_outlined,color:Theme.of(context).textTheme.bodyText2!.color ),
                                    SvgPicture.asset(
                                      'assets/new_svg/profile.svg',
                                      color: Theme.of(context).textTheme.bodyText2!.color,
                                      fit: BoxFit.contain,

                                    ),
                                    SizedBox(
                                        width:MediaQuery.of(context).size.width * (41/375) ,
                                        child: Text('drawer.Profile'.tr(),maxLines: 2,style: TextStyle(fontSize: 10,color:Theme.of(context).textTheme.bodyText1!.color ),textAlign: TextAlign.center,)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(indent: 15,endIndent: 15,),
                            SizedBox(
                              height:MediaQuery.of(context).size.width * (67/375) ,

                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => allPosts()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                   // Icon(Icons.ac_unit_outlined,color:Theme.of(context).textTheme.bodyText2!.color ),
                                    SvgPicture.asset(
                                      'assets/new_svg/forum.svg',
                                      // width: 20,
                                      color: Theme.of(context).textTheme.bodyText2!.color,
                                      fit: BoxFit.contain,

                                    ),
                                    SizedBox(
                                        width:MediaQuery.of(context).size.width * (41/375) ,
                                        child: Text('drawer.Forum'.tr(),maxLines: 2,style: TextStyle(fontSize: 10,color:Theme.of(context).textTheme.bodyText1!.color ),textAlign: TextAlign.center,)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(indent: 15,endIndent: 15,),
                            SizedBox(
                              height:MediaQuery.of(context).size.width * (67/375) ,

                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => newnewscategory()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                  //  Icon(Icons.ac_unit_outlined,color:Theme.of(context).textTheme.bodyText2!.color ),
                                    SvgPicture.asset(
                                      'assets/new_svg/news.svg',
                                      // width: 20,
                                      color: Theme.of(context).textTheme.bodyText2!.color,
                                      fit: BoxFit.contain,

                                    ),
                                    SizedBox(
                                        width:MediaQuery.of(context).size.width * (41/375) ,
                                        child: Text('drawer.Latest News'.tr(),maxLines: 2,style: TextStyle(fontSize: 10,color:Theme.of(context).textTheme.bodyText1!.color ),textAlign: TextAlign.center,)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(indent: 15,endIndent: 15,),
                            SizedBox(
                              height:MediaQuery.of(context).size.width * (67/375) ,

                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => contactus()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                //    Icon(Icons.ac_unit_outlined,color:Theme.of(context).textTheme.bodyText2!.color ),
                                    SvgPicture.asset(
                                      'assets/new_svg/contact.svg',
                                      // width: 20,
                                      color: Theme.of(context).textTheme.bodyText2!.color,
                                      fit: BoxFit.contain,

                                    ),
                                    SizedBox(
                                        width:MediaQuery.of(context).size.width * (41/375) ,
                                        child: Text('drawer.Contact Us'.tr(),maxLines: 2,style: TextStyle(fontSize: 10,color:Theme.of(context).textTheme.bodyText1!.color ),textAlign: TextAlign.center,)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox()
                          ],
                        )
                      )
                  ),
                ],
              ),
            ),
            //un
            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width *(13/375),right:MediaQuery.of(context).size.width *(13/375),bottom:MediaQuery.of(context).size.width *(20/375),top:MediaQuery.of(context).size.width *(10/375)   ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("home.Universities".tr(),style: TextStyle(fontSize: 30,color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color ,fontWeight: FontWeight.bold),),

                  TextButton(onPressed: (){
                    globalss.uncateforfilter = "";
                    globalss.Fromprossbar='';

                    globalss.unids="";
                    globalss.Degreeids="" ;
                    globalss.Courseids="";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => uncategory()));
                  },

                      child: SizedBox(width:MediaQuery.of(context).size.width/6 ,child: FittedBox( fit: BoxFit.fitWidth, child: Text("home.Display all".tr(),style: TextStyle(color: globalss.cblue,decoration: TextDecoration.underline),)))),


                ],
              ),
            ),

            Padding(
          //    padding: const EdgeInsets.all(8.0),
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width *(15/375),right:MediaQuery.of(context).size.width *(15/375) ),

              child: SizedBox(
                //height: 300,
                child: FutureBuilder(
                  future: getsilverUN(),
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.width*(301/375),
                            child: (snapshot.data.data.length >= 1)
                                ? ListView.builder(
                                    shrinkWrap: false,
                                    //reverse: true,
                                    physics: ClampingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      var reversedList =
                                          snapshot.data.data.reversed.toList();

                                      //  final dataaa =snapshot.data.data[i];
                                      final dataaa = reversedList[i];
                                      return Container(
                                        // height:100,
                                        //  width: 300,
                                        width: (MediaQuery.of(context).size.width /
                                            1.6),
                                        height:
                                        (MediaQuery.of(context).size.width /
                                                1.6),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CachedNetworkImage(
                                                height: (MediaQuery.of(context)
                                                    .size
                                                    .width*0.6)*(185/225),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width*0.6,

                                                // fit: BoxFit.fitHeight,
                                                imageUrl:
                                                    globalss.UrlImageuniversity +
                                                        dataaa.logo.toString(),
                                                //  imageUrl: globalss.UrlImagenews+snapshot.data.data[i].media.toString(),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    top: 4.0,bottom:MediaQuery.of(context).size.width*(14/375) ),
                                                child: Text(
                                                  dataaa.name.toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.width*(29/375),
                                                  width: MediaQuery.of(context).size.width*(100/375),
                                                child:ElevatedButton(

                                                  style: ElevatedButton.styleFrom(


                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20.0),


                                                    ),
                                                    elevation: 0,
                                                    //  shadowColor:Colors.transparent,
                                                    primary:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),
                                                  ),
                                                  onPressed: () {

                                                    Map<String, dynamic> Mapnews={
                                                      "id": dataaa.id,
                                                      "title": dataaa.name,
                                                      "description": dataaa.description,
                                                      "creator":dataaa.logo,
                                                    };

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => UnversityDetails(mapun: Mapnews))
                                                    );

                                                  },
                                                  child: FittedBox(
                                                      child: Text("home.Find out more".tr(),
                                                        style: TextStyle(
                                                            color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),maxLines: 1,)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },

                                    // itemCount: snapshot.data.data.length,
                                    itemCount: snapshot.data.data.length
                                    //  (snapshot.data.data.length>3)?3: snapshot.data.data.length,
                                    )
                                : SizedBox(),
                          );
                        }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            //choose programm
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "home.Explore academic".tr() + "\n" + "home.programs and courses".tr(),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      //  height:MediaQuery.of(context).size.height/3,
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>degreeList ()));
                        },
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/22images/home/chooseprogram.png'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(

                                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/5, maxWidth: MediaQuery.of(context).size.width*(70/100)),                                      child: FittedBox(
                                        child: FittedBox(
                                          child: Text(
                                            "home.Choose program".tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )),
                ],
              ),
            ),

            //Special blog
            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/25,right: MediaQuery.of(context).size.width/25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width:MediaQuery.of(context).size.width/2.2 ,
                  child: FittedBox(                      fit: BoxFit.fitWidth,
                      child: Text("home.Special blog".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),)),
                ),
              TextButton(onPressed: () {
             //   Scaffold.of(context).openEndDrawer();
                _scaffoldkey.currentState?.openEndDrawer();
              },

                  child: SizedBox(width:MediaQuery.of(context).size.width/8 ,child: FittedBox( fit: BoxFit.fitWidth, child: Text("home.Show all".tr(),style: TextStyle(color: globalss.cblue,decoration: TextDecoration.underline,),)))),
              ],
            ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child:Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
scrollDirection:Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //forum
                      GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => allPosts()));
                  },
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.5,
                              height: MediaQuery.of(context).size.width/2.5,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/22images/home/forum.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                                bottom:10,
                                left: 10,

                                child: SizedBox(
                                  width:MediaQuery.of(context).size.width/4 ,
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text("drawer.Forum".tr()+"  ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ))  ],
                        ),
                      ),

                      SizedBox(width: 10,),


                      GestureDetector(

                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>broadcastsarchive ()));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.5,
                              height: MediaQuery.of(context).size.width/2.5,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/22images/home/podcast.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
 Positioned(
                                bottom:10,
                                left: 10,

                                child: SizedBox(
                                  width:MediaQuery.of(context).size.width/4 ,
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(" "+"drawer.Broadcast".tr()+"  ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => contactus()));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.5,
                              height: MediaQuery.of(context).size.width/2.5,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/22images/home/contactus.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                                bottom:10,
                                left: 10,

                                child: SizedBox(
                                  width:MediaQuery.of(context).size.width/4 ,
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text("drawer.Contact Us".tr(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ))

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),

            //news
            SizedBox(height:MediaQuery.of(context).size.width*(15/375),),
            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),

              child: SizedBox(
                height: MediaQuery.of(context).size.width*(670/375),

                child: FutureBuilder(
                  future: getNews(),
                  builder: (context,AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return Center(child: CircularProgressIndicator(),);
                        }
                      case ConnectionState.done:
                        if (snapshot.hasData) {

                          return Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(

                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(

                                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/5, maxWidth: MediaQuery.of(context).size.width*(70/100)),
                                      child: FittedBox(child: Text("drawer.Latest News".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),))),

                                ],
                              ),

                              Flexible(
                                  child:(snapshot.data.data.length>0)?
                                  ListView.separated(
                                    padding:EdgeInsets.only(top: 30),
                                      physics: NeverScrollableScrollPhysics(),

                                      itemBuilder: (context, i){
                                      final dataaa =snapshot.data.data[i];
                                      return Container(
                                          margin: EdgeInsets.only(right: 0,left: 0),
                                          height:MediaQuery.of(context).size.width*158/375 ,
                                          decoration: BoxDecoration(
                                            // color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.all(Radius.circular(5),),

                                          ),
                                          child:
                                          GestureDetector(
                                              onTap: (){

                                              },
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(context).size.width*(108/375),
                                                        width: MediaQuery.of(context).size.width*(108/375),
                                                        child:CachedNetworkImage(
                                                          imageUrl: globalss.UrlImagenews+dataaa.media.toString(),
                                                          imageBuilder: (context, imageProvider) => Container(
                                                            decoration: BoxDecoration(

                                                              borderRadius:BorderRadius.circular(8) ,
                                                              image: DecorationImage(
                                                                image: imageProvider,
                                                                fit: BoxFit.cover,
                                                              ),

                                                            ),
                                                          ),
                                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                        SizedBox(
                                                          height:MediaQuery.of(context).size.width*113/375 ,
                                                          width:MediaQuery.of(context).size.width*227/375 ,
                                                          child: Padding(
                                                            padding:  EdgeInsets.only(left: 8.0,right: 8),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                  height:MediaQuery.of(context).size.width*50/375 ,
                                                                  width:MediaQuery.of(context).size.width*227/375 ,
                                                                  child: AutoSizeText
                                                                    (dataaa.title.toString(),
                                                                    style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 16),
                                                                    maxLines: 3,
                                                                    overflow:TextOverflow.ellipsis,
                                                                    minFontSize: 10,
                                                                    //  maxFontSize: 20,
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                    height:MediaQuery.of(context).size.width*50/375 ,
                                                                    width:MediaQuery.of(context).size.width*227/375 ,
                                                                    child: AutoSizeText(dataaa.description.toString(),
                                                                      style: TextStyle(color: Theme.of(context).textTheme.headline5!.color,fontSize: 12),
                                                                      maxLines: 2,
                                                                      overflow:TextOverflow.ellipsis,
                                                                      minFontSize: 10,
                                                                    )
                                                                ) ,

                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )

                                                    ],
                                                  ),
                                                  SizedBox(height:MediaQuery.of(context).size.width*16/375 ,),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(context).size.width*(29/375),
                                                        //  width: MediaQuery.of(context).size.width*(84/375),
                                                        child:ElevatedButton(

                                                          style: ElevatedButton.styleFrom(


                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(20.0),


                                                            ),
                                                            elevation: 0,
                                                            //  shadowColor:Colors.transparent,
                                                            primary:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),
                                                          ),
                                                          onPressed: () {
                                                            Map<String, dynamic> Mapnews={
                                                              "id": dataaa.id,
                                                              "title": dataaa.title,
                                                              "description": dataaa.description,
                                                              "creator":dataaa.creator,
                                                              "media":dataaa.media,
                                                              "views":dataaa.views,
                                                              "featured":dataaa.featured,
                                                            };

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => newNewsDetails(mapnews: Mapnews))
                                                            );
                                                          },
                                                          child: Center(
                                                              child: Text("Show more".tr(),
                                                                style: TextStyle(
                                                                    color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),maxLines: 1,)
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:MediaQuery.of(context).size.width*29/375 ,
                                                        child:
                                                        Container(

                                                          decoration: BoxDecoration(


                                                            borderRadius:BorderRadius.circular(20) ,
                                                            color:
                                                            (Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),


                                                          ),


                                                          child: TextButton.icon(
                                                            icon: Icon(Icons.remove_red_eye_outlined,color:Theme.of(context).textTheme.headline5!.color ,size: 16),
                                                            label: Text(dataaa.views.toString(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color,fontSize: 12 )),
                                                            onPressed: null,

                                                          ),
                                                        ),

                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              )
                                          )

                                      );
                                    },
                                    // separatorBuilder: (context, i) => Divider(),
                                    separatorBuilder: (context, i) => SizedBox(height: 15,),
                                    itemCount:(snapshot.data.data.length<4)? snapshot.data.data.length:3,

                                  )
                                      :
                                  SizedBox( height: MediaQuery.of(context).size.height,
                                    child:  Positioned(
                                      //top: 200,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Center(child:Image.asset("assets/screens/empty.png",height: 100,width: double.infinity,fit: BoxFit.fill,),)),

                                  )

                              ),

                              Center(
                                child: ElevatedButton(


                                  style: ElevatedButton.styleFrom(
elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),

                                    ),
                                    primary:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => newnewscategory()));



                                  },
                                  child:  SizedBox(
                                      width:MediaQuery.of(context).size.width*223/375 ,
                                      child: Center(child: Text("home.Show all news".tr(),
                                    style: TextStyle(color:Theme.of(context).textTheme.headline1!.color,),))),
                                ),
                              ),
                              SizedBox(height: 20,),





                            ],
                          );


                        }

                    }
                    return Center(child: CircularProgressIndicator(),);


                  },
                ),
              ),
            ),

          ],
        ),
      ),
    ):Container(color: globalss.cblue,
    child:Center(child: Text("Connecting to the internet failed , please check your internet"),

    ),) ;
  }
}
