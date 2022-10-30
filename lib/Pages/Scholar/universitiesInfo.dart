import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/Model/SubCourses.dart';
import 'package:stru2022/Model/UnDetails.dart';

import 'package:stru2022/Pages/Scholar/subCourseInfo.dart';
import 'package:stru2022/Pages/Scholar/universitiesInfoImages.dart';
import 'package:stru2022/Pages/Scholar/universitiesInfovideo.dart';

import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';
import '../../mywidget/botombarnew.dart';
import '../Application/ApplytoCourse.dart';
import '../Siginin.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;
import 'dart:ui' as ui;

class UnversityDetails extends StatefulWidget {
  Map<String, dynamic> mapun;

  UnversityDetails({Key? key,required this.mapun}) : super(key: key);

  @override
  _UnversityDetailsState createState() => _UnversityDetailsState();
}

class _UnversityDetailsState extends State<UnversityDetails> {

  final RefreshController refreshController = RefreshController(initialRefresh: true);
  bool colorbool = false;
  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> dataa = [];

  //more media un
  bool f = true;
  bool v = false;


   int id=0;
   String name="";
   String city="";
   String description="";
   String logo="";
   String photo="";
   String content="";
   String phone="";
   String email="";
   String website="";
   String category="";
  int featured=0;
   bool inCurrentUserFavorite = false;

  bool result = false;




  Future getundetails() async{

    String Url = 'https://studyinrussia.app/api/scholar/university/${widget.mapun["id"]}?lang=${context.locale.toString()}';

    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},
    );

    if (response.statusCode == 200) {



      UnDetails unDetailsFromJson(String str) => UnDetails.fromJson(convert.json.decode(response.body));

      final undetails = unDetailsFromJson(response.body);




        id=unDetailsFromJson(response.body).data.id;
        name=unDetailsFromJson(response.body).data.name;
        city=unDetailsFromJson(response.body).data.city.name;
        description=unDetailsFromJson(response.body).data.description;
        logo=unDetailsFromJson(response.body).data.logo;
        photo=unDetailsFromJson(response.body).data.photo;
        content=unDetailsFromJson(response.body).data.content;
        phone=unDetailsFromJson(response.body).data.phone;
        email=unDetailsFromJson(response.body).data.email;
        website=unDetailsFromJson(response.body).data.website;
        category=unDetailsFromJson(response.body).data.category.name;
        featured=unDetailsFromJson(response.body).data.featured;
        inCurrentUserFavorite=unDetailsFromJson(response.body).data.inCurrentUserFavorite;
        globalss.unids=id.toString();





      return true;
    }else{
      return false;
    }

  }

  Future<bool> getSubCourses({required bool isRefresh}) async {

   await getundetails();


    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';

    if(globalss.unids.isNotEmpty && globalss.Degreeids.isNotEmpty  && globalss.Courseids.isNotEmpty){
      Url = 'https://studyinrussia.app/api/scholar/sub_courses?course=${globalss.Courseids}&university=${globalss.unids}&degree=${globalss.Degreeids}&lang=${context.locale.toString()}&page=$currentPage';
      print(Url);
    }
    else if(globalss.unids.isNotEmpty && globalss.Degreeids.isEmpty&& globalss.Courseids.isEmpty ){
      Url = 'https://studyinrussia.app/api/scholar/sub_courses?university=${globalss.unids.toString()}&lang=${context.locale.toString()}&page=$currentPage';
      print(Url);
    }else{
      Url = 'url  null';
      print(Url);
    }






    final response = await http.get(
      Uri.parse(Url),
     headers: {"Authorization": "bearer "+globalss.tokenfromserver},
    );


    GetSubCorseList getSubCorseListFromJson(String str) => GetSubCorseList.fromJson(convert.json.decode(response.body));
    final getSubCorseList = getSubCorseListFromJson(response.body);
    print(getSubCorseList.message);


    if (response.statusCode == 200) {
      GetSubCorseList getSubCorseListFromJson(String str) => GetSubCorseList.fromJson(convert.json.decode(response.body));
      final getSubCorseList = getSubCorseListFromJson(response.body);

      if (isRefresh) {
        dataa = [];
        dataa = getSubCorseList.data;
      }else {
        if(currentPage <= totalPages){
          dataa.addAll(getSubCorseList.data);
        }
      }



      totalPages =(getSubCorseList.pagination.totalItems / 10).round();
      if ((totalPages * 10) < getSubCorseList.pagination.totalItems) {
        totalPages=totalPages+1;
      }else{
        totalPages=1;
      }

      if(currentPage <= totalPages){
        currentPage++;
      }


      print(totalPages);
      //dataa.addAll(getnews.data);
    setState(() {


    });
      return true;
    }else{
      print("some error not 200");
      return false;
    }
  }

  Future favorite({required String idsc} ) async {

    var map = new Map<String, dynamic>();
    map['subcourse'] = idsc;
    String Urlf = 'https://studyinrussia.app/api/scholar/favorite/add/subcourse';
    final responsef = await http.post(
        Uri.parse(Urlf),
        headers: {"Authorization": "bearer "+globalss.tokenfromserver},
        body: map
    );
    print(convert.jsonDecode(responsef.body));
  }


  Future favoriteun({required String idun} ) async {
    if(!globalss.userverified){
      Alert(
        context: context,
        image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,),
        desc: "You must be logged in to complete the process".tr(),
        buttons: [

          DialogButton(
            child: Text(
              "Login".tr(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            width: 120,
          ),
          DialogButton(
            child: Text(
              "Cancel".tr(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            onPressed: () => Navigator.pop(context),

            width: 120,
          )
        ],
      ).show();
      return;
    }
    var map = new Map<String, dynamic>();
    map['university'] = idun;
    String Urlf = 'https://studyinrussia.app/api/scholar/favorite/add/university';
    final responsef = await http.post(
        Uri.parse(Urlf),
        headers: {"Authorization": "bearer "+globalss.tokenfromserver},
        body: map
    );

  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
        extendBodyBehindAppBar: true,

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
                onPressed: () {
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

        body:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              GestureDetector(
                onTap: ()async{
                  await favoriteun(idun: id.toString());

                  setState((){
                    if(inCurrentUserFavorite){
                      inCurrentUserFavorite  = false;

                    }else{
                      inCurrentUserFavorite  = true;

                    }
                  });
                  // print("fgfg");
                  // await favorite(idsc: widget.postinfo["id"].toString());
                  // setState(() {
                  //   if (widget.postinfo["likedByCurrentUser"].toString()=="true") {
                  //     widget.postinfo["likedByCurrentUser"] =
                  //     "false";
                  //     widget.postinfo["likes"] =(int.parse(widget.postinfo["likes"].toString())-1).toString();
                  //   } else{
                  //     widget.postinfo["likedByCurrentUser"] =
                  //     "true";
                  //     widget.postinfo["likes"] =(int.parse(widget.postinfo["likes"].toString())+1).toString();
                  //
                  //   }
                  // }
                  // );
                },
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      height: MediaQuery.of(context).size.width*231/375,
                      imageUrl: globalss.UrlImageuniversity+photo,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(

                          borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:  Radius.circular(20)) ,
                          // gradient: LinearGradient(
                          //     colors: [Colors.green, Colors.blue]),

                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),

                        ),
                      ),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width*231/375,
                      decoration: BoxDecoration(

                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:  Radius.circular(20)) ,
                        gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.2)]),



                      ),
                    ),
                    Positioned(
                      bottom:  MediaQuery.of(context).size.width*(20/375),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8),
                          child: Row(
                            children: [
                              CachedNetworkImage(

                                height: MediaQuery.of(context).size.width*(64/375),
                                width:  MediaQuery.of(context).size.width*(64/375),
                                fit: BoxFit.cover,

                                imageUrl: globalss.UrlImageuniversity+logo,
                                imageBuilder: (context, imageProvider) =>

                                    Container(

                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],

                                          shape:BoxShape.circle,
                                          color: Colors.white


                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                shape:BoxShape.circle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                          ),
                                        ),
                                      ) ,
                                    ),
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),


                              ),
                              SizedBox(width:  MediaQuery.of(context).size.width*(10/375),),
                              SizedBox(
                                width:  MediaQuery.of(context).size.width*(266/375),
                                height: MediaQuery.of(context).size.width*(64/375),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),maxLines: 3),
                                    Row(

                                      children: [
                                        Icon(Icons.location_on,color: Colors.white,size:MediaQuery.of(context).size.width*(12/375) ),
                                        Text(" "+city,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),maxLines: 1),
                                      ],
                                    ),

                                  ],
                                ),
                              )

                            ],
                          )
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 20,
                    //   child: Padding(
                    //     padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                    //     child: SizedBox(
                    //       height:MediaQuery.of(context).size.width*(18/375) ,
                    //       width:MediaQuery.of(context).size.width*(345/375) ,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text("dfhd",
                    //       //"widget.postinfo["createdBy"].toString()",
                    //             style: TextStyle(color:Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    //           Text("fb",//"widget.postinfo["publishTime"].toString().substring(0, 10)",
                    //             style: TextStyle(color:Colors.white),)
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(

                      right:MediaQuery.of(context).size.width*(31/375) ,
                      //    left:MediaQuery.of(context).size.width*(31/375) ,
                      top:MediaQuery.of(context).size.width*(31/375) ,
                      child:
                      (inCurrentUserFavorite)

                          ?
                      SizedBox(
                        height: MediaQuery.of(context).size.width*(31/375),
                        width: MediaQuery.of(context).size.width*(160/375),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.width*(31/375),
                                width: MediaQuery.of(context).size.width*(122/375),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white

                                ),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width:MediaQuery.of(context).size.width*(20/375) ,
                                      height:MediaQuery.of(context).size.width*(31/375) ,
                                      child: IconButton(
                                          icon:(Icon(Icons.favorite,color: Colors.red,size:10,)),
                                          onPressed: () {}


                                      ),
                                    ),


                                    SizedBox(
                                      width:MediaQuery.of(context).size.width*(100/375) ,
                                      height:MediaQuery.of(context).size.width*(31/375) ,
                                      child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text("uninfo.Added to Favorites".tr(),style: TextStyle(color: Colors.black),)),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(
                                height:MediaQuery.of(context).size.width*(31/375) ,
                                width:MediaQuery.of(context).size.width*(31/375) ,
                                child: IconButton(
                                  icon:Icon(Icons.favorite,color: Colors.white,size: MediaQuery.of(context).size.width*(20/375)) ,
                                  onPressed: ()async{

                                  },
                                )
                            ),

                          ],
                        ),
                      )
                          :
                      SizedBox(
                          height:MediaQuery.of(context).size.width*(31/375) ,
                          width:MediaQuery.of(context).size.width*(31/375) ,


                          child: IconButton(
                            icon:Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*(20/375)) ,
                            onPressed: () async{
                            },
                          )
                      ),
                    ),
                    Positioned(

                      //  right:MediaQuery.of(context).size.width*(31/375) ,
                        left:MediaQuery.of(context).size.width*(15/375) ,
                        top:MediaQuery.of(context).size.width*(31/375) ,
                        child:

                        SizedBox(
                            height: MediaQuery.of(context).size.width*(31/375),
                            width: MediaQuery.of(context).size.width*(31/375),
                            child: Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: BackButton(
                                color: Colors.white,
                              ),
                            )
                        )

                    ),
                  ],
                ),
              ),
              Padding(
                padding:
              //  EdgeInsets.only(left:MediaQuery.of(context).size.width*(1/375) ,right:MediaQuery.of(context).size.width*(1/375) ,top:MediaQuery.of(context).size.width*(24/375) ,bottom:MediaQuery.of(context).size.width*(16/375) ),

                  EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375) ,top:MediaQuery.of(context).size.width*(24/375) ,bottom:MediaQuery.of(context).size.width*(12/375) ),
                child: Text("uninfo.About University".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),),
              ),

              Padding(
                padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*(5/375) ,right:MediaQuery.of(context).size.width*(5/375)),
                child: Html(data:content,),
              ),
//media
              Padding(
                padding:
                //  EdgeInsets.only(left:MediaQuery.of(context).size.width*(1/375) ,right:MediaQuery.of(context).size.width*(1/375) ,top:MediaQuery.of(context).size.width*(24/375) ,bottom:MediaQuery.of(context).size.width*(16/375) ),

                EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375) ,top:MediaQuery.of(context).size.width*(24/375) ,bottom:MediaQuery.of(context).size.width*(12/375) ),
                child: Text("uninfo.Media life".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375),bottom:MediaQuery.of(context).size.width*(15/375) ),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: globalss.cblue,
                      ),
                      onPressed:(){

                        globalss.unids=id.toString();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UnversityDetailsImages()),
                        );

                      },
                      child: SizedBox(
                          width:
                          MediaQuery.of(context).size.width *(84/375),
                          height: MediaQuery.of(context).size.width *(30/375),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text("uninfo.Photo Gallery".tr(),
                                style: TextStyle(
                                    color: Colors.white)),
                          )),
                    ),
                    SizedBox(width:MediaQuery.of(context).size.width*(5/375) ,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: globalss.cblue,
                      ),
                      onPressed:(){
                        globalss.unids=id.toString();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UnversityDetailsVideo()),
                        );

                      },
                      child: SizedBox(
                          width:
                          MediaQuery.of(context).size.width *(84/375),
                          height: MediaQuery.of(context).size.width *(30/375),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text("uninfo.Video Gallery".tr(),
                                style: TextStyle(
                                    color: Colors.white)),
                          )),
                    ),
                  ],
                )
              ),


              //subcorse
              Padding(
                padding:
                //  EdgeInsets.only(left:MediaQuery.of(context).size.width*(1/375) ,right:MediaQuery.of(context).size.width*(1/375) ,top:MediaQuery.of(context).size.width*(24/375) ,bottom:MediaQuery.of(context).size.width*(16/375) ),

                EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375) ,top:MediaQuery.of(context).size.width*(24/375) ,bottom:MediaQuery.of(context).size.width*(12/375) ),
                child: Text("uninfo.Subcourses".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),),
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () async {
                    result = await getSubCourses(isRefresh: true);
                    if (result) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },

                  onLoading:() async {
                    //           final result = await getPassengerData();

                    result = await getSubCourses(isRefresh: false);

                    //  await getNews();
                    if (result){
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  },
                  child:
                  (!result&&dataa.length==0)?SizedBox(height: 10,):
                  (result&&dataa.length>0)?ListView.separated(

                    padding:  EdgeInsets.only(top: 2.0),

                    itemBuilder: (context, i){
                      var dataaa = dataa[i];

                      colorbool = dataa[i].inCurrentUserFavorite;

                      var coloor =(colorbool)?globalss.cblue : Colors.grey;

                      return Padding(
                        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:  Theme.of(context).primaryColor,
                              boxShadow:[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                //  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ]
                          ),


                          child: Padding(
                            padding:  EdgeInsets.all(MediaQuery.of(context).size.width*(15/375)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                    Icon(Icons.language,color: Theme.of(context).textTheme.headline1!.color,size:12 ,),
                                    SizedBox(width: 5,),
                                    Text(dataaa.language.toString()+"   "+dataaa.level.toString(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color ,fontSize: 12)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width*(15/375),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width*(300/375),
                                        // height: 40,
                                        child: Text(dataaa.name.toString(),style: TextStyle( fontWeight: FontWeight.bold,fontSize: 16,color:Theme.of(context).textTheme.bodyText1!.color ),)),


                                  ],
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.width*(45/375),
                                  child: Padding(
                                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375),),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap:(){
                                            globalss.SubCourseids=dataaa.id.toString();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => MyApp50()),
                                            );
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.width*(30/375),
                                            width: MediaQuery.of(context).size.width*(84/375),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                              color: globalss.cblue,
                                            ),
                                            child:Padding(
                                              padding:  EdgeInsets.only(left:  MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375),top: MediaQuery.of(context).size.width*(5/375),bottom: MediaQuery.of(context).size.width*(5/375)),
                                              child: SizedBox(

                                                  child: FittedBox(child: Text("uninfo. APPLY ".tr(),style: TextStyle(color: Colors.white),))),
                                            ) ,
                                          ),
                                          // child: Container(
                                          //   height: MediaQuery.of(context).size.width*(30/375),
                                          //   width: MediaQuery.of(context).size.width*(84/375),
                                          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                          //     color: globalss.cblue,
                                          //   ),
                                          //   child:Padding(
                                          //     padding: const EdgeInsets.all(5.0),
                                          //     child: Center(child: Text("uninfo. APPLY ".tr(),style: TextStyle(color: Colors.white),)),
                                          //   ) ,
                                          // ),
                                        ),

                                        GestureDetector(
                                          onTap:(){
                                            Map<String, dynamic> Mapsubcorse={
                                              "id": dataaa.id,
                                              "name": dataaa.name,
                                              "content": dataaa.content,
                                              "degree":dataaa.degree.name,
                                              "university":dataaa.university.name,
                                              "city":dataaa.university.city.name,
                                              "fees":dataaa.fees,
                                              "course":dataaa.course.name,

                                              "language":dataaa.language,
                                              "level":dataaa.level,
                                              "featured":dataaa.featured,

                                              "in_current_user_favorite":dataaa.inCurrentUserFavorite,


                                            };

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => subcorseinfo(mapsub:Mapsubcorse ,)),
                                            );
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.width*(30/375),
                                            width: MediaQuery.of(context).size.width*(84/375),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                              color: globalss.cblue,
                                            ),
                                            child:Padding(
                                              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(5/375),right: MediaQuery.of(context).size.width*(5/375)),
                                              child: SizedBox(
                                                  height: MediaQuery.of(context).size.width*(30/375),
                                                  width: MediaQuery.of(context).size.width*(84/375),
                                                  child: FittedBox(child: Text("Show more".tr(),style: TextStyle(color: Colors.white),))),
                                            ) ,
                                          ),
                                          // child: Container(
                                          //   height: MediaQuery.of(context).size.width*(30/375),
                                          //   width: MediaQuery.of(context).size.width*(84/375),
                                          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                          //     color: globalss.cblue,
                                          //   ),
                                          //   child:Padding(
                                          //     padding: const EdgeInsets.all(5.0),
                                          //     child: Center(child: Text("Show more",style: TextStyle(color: Colors.white),)),
                                          //   ) ,
                                          // ),
                                        ),

                                        // IconButton(
                                        //   onPressed: ()async{
                                        //     Map<String, dynamic> Mapsubcorse={
                                        //       "id": dataaa.id,
                                        //       "name": dataaa.name,
                                        //       "content": dataaa.content,
                                        //       "degree":dataaa.degree.name,
                                        //       "university":dataaa.university.name,
                                        //       "city":dataaa.university.city.name,
                                        //       "fees":dataaa.fees,
                                        //       "course":dataaa.course.name,
                                        //
                                        //       "language":dataaa.language,
                                        //       "level":dataaa.level,
                                        //       "featured":dataaa.featured,
                                        //
                                        //       "in_current_user_favorite":dataaa.inCurrentUserFavorite,
                                        //
                                        //
                                        //     };
                                        //
                                        //     Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(builder: (context) => subcorseinfo(mapsub:Mapsubcorse ,)),
                                        //     );
                                        //
                                        //   },
                                        //   icon:Icon(Icons.info_outline ),
                                        // ),
                                        CircleAvatar(

                                          backgroundColor:globalss.cblue.withOpacity(0.1) ,
                                          radius: MediaQuery.of(context).size.width*(29/375),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: ()async{
                                                await favorite(idsc: dataaa.id.toString());


                                                setState((){
                                                  if(dataaa.inCurrentUserFavorite){
                                                    dataaa.inCurrentUserFavorite  = false;
                                                  }else{
                                                    dataaa.inCurrentUserFavorite  = true;
                                                  }
                                                });


                                              },
                                              icon:Icon(Icons.favorite,color:coloor,size: MediaQuery.of(context).size.width*(18/375)),
                                              //
                                              //
                                              // SizedBox(
                                              //       height:MediaQuery.of(context).size.width*(30/375),
                                              //       width:MediaQuery.of(context).size.width*(30/375),
                                              //       child: FittedBox(child: Icon(Icons.favorite,color:globalss.cblue,))),
                                            ),
                                          ),
                                        ),

                                        // CircleAvatar(
                                        //
                                        //     backgroundColor:globalss.cblue.withOpacity(0.1) ,
                                        //     radius: 25,
                                        //   child: IconButton(
                                        //     onPressed: ()async{
                                        //       await favorite(idsc: dataaa.id.toString());
                                        //
                                        //
                                        //       setState((){
                                        //         if(dataaa.inCurrentUserFavorite){
                                        //           dataaa.inCurrentUserFavorite  = false;
                                        //         }else{
                                        //           dataaa.inCurrentUserFavorite  = true;
                                        //         }
                                        //       });
                                        //
                                        //
                                        //     },
                                        //     icon:Icon(Icons.favorite,color:coloor,),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),


                        ),
                      );



                      //   ListTile(
                      //   focusColor: Colors.amberAccent,
                      //   title: Text(dataaa.name.toString()),
                      //   subtitle:Text(dataaa.id.toString()+dataaa.content.toString()) ,
                      //   isThreeLine: true,
                      //
                      //
                      //   onTap: (){
                      //
                      //   },
                      // );
                    },
                    separatorBuilder: (context, i) => Divider(),

                    itemCount: dataa.length,

                  ):
                  (result&&dataa.length==0)? Center(
                    child:Text("More courses will be added soon..")
                    //Image.asset("assets/nm/EMPTYPAGE.png",height: 200,width: 200,fit: BoxFit.fill,),
                  ):
                  SizedBox(height: 10,),

                ),
              ),









              //old
            // Column(
            //
            //   children: [
            //     (photo=="")?SizedBox(height: 10,):
            //     Container(
            //       color: Colors.transparent ,
            //       height: 230,
            //       width: MediaQuery.of(context).size.width,
            //
            //       child: Stack(
            //         children: [
            //           CachedNetworkImage(
            //             height: 200,
            //             //  width: 90,
            //             fit: BoxFit.contain,
            //
            //             imageUrl: globalss.UrlImageuniversity+photo,
            //             imageBuilder: (context, imageProvider) =>
            //
            //             Container(
            //
            //               decoration: BoxDecoration(
            //
            //
            //                 shape:BoxShape.rectangle,
            //
            //
            //                   border:Border(
            //                     bottom: BorderSide(color: Colors.red, width: 8, style: BorderStyle.solid),
            //                    // left: BorderSide(color: Colors.green, width: 10, style: BorderStyle.solid),
            //                   ),
            //
            //                 image: DecorationImage(
            //                   image: imageProvider,
            //                   fit: BoxFit.fill,
            //                 ),
            //
            //
            //
            //               ),
            //             ),
            //             placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            //             errorWidget: (context, url, error) => Icon(Icons.error),
            //
            //
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //
            //             child: Container(
            //               // color: Colors.
            //                 color:Colors.black12,
            //                 height: 50,
            //                 child: Column(
            //
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Flexible(
            //                       child: RichText(
            //
            //                         overflow: TextOverflow.ellipsis,
            //                         strutStyle: StrutStyle(fontSize: 22.0),maxLines: 2,
            //                         text: TextSpan(
            //
            //                             style: TextStyle(color: Colors.white,fontSize: 22 ),
            //                             text: name),
            //                       ),
            //                     ),
            //
            //                   ],
            //                 )
            //             ),
            //           ),
            //
            //           Positioned(
            //             top:  80,
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 20.0,right:20.0),
            //               child: CachedNetworkImage(
            //
            //                 height: 200,
            //                 width: 90,
            //                 fit: BoxFit.cover,
            //
            //                 imageUrl: globalss.UrlImageuniversity+logo,
            //                 imageBuilder: (context, imageProvider) =>
            //
            //                 Container(
            //
            //                   decoration: BoxDecoration(
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.grey.withOpacity(0.5),
            //                           spreadRadius: 1,
            //                           blurRadius: 1,
            //                           offset: Offset(0, 3), // changes position of shadow
            //                         ),
            //                       ],
            //
            //                     shape:BoxShape.circle,
            //                     color: Colors.white
            //
            //
            //                   ),
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(5.0),
            //                     child: Center(
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           shape:BoxShape.circle,
            //                           image: DecorationImage(
            //                             image: imageProvider,
            //                             fit: BoxFit.contain,
            //                           ),
            //                         )
            //                       ),
            //                     ),
            //                   ) ,
            //                 ),
            //                 placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            //                 errorWidget: (context, url, error) => Icon(Icons.error),
            //
            //
            //               ),
            //             ),
            //           )
            //
            //         ],
            //
            //       ),
            //     ) ,
            //
            //
            //
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text("About University",style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 20),),
            //     ),
            //
            //
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0,right: 8),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.min,
            //
            //               children: [
            //
            //                 Icon(
            //
            //                   Icons.phone,
            //
            //                   size: 16,
            //
            //                   color: Theme.of(context).textTheme.headline2!.color
            //
            //
            //
            //                 ),
            //
            //                 Flexible(
            //
            //                   child: RichText(
            //
            //
            //
            //                     overflow: TextOverflow.ellipsis,
            //
            //                     strutStyle: StrutStyle(fontSize: 12.0),
            //
            //
            //
            //                     text: TextSpan(
            //
            //                         style: Theme.of(context).textTheme.bodyText1,
            //
            //
            //
            //
            //                         text:" "+ phone,),
            //
            //                   ),
            //
            //                 ),
            //
            //
            //
            //               ],
            //
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0,right: 8),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //
            //                 Icon(
            //
            //                   Icons.email,
            //
            //                     size: 16,
            //
            //                     color: Theme.of(context).textTheme.headline2!.color
            //
            //
            //
            //                 ),
            //
            //                 Flexible(
            //
            //                   child: RichText(
            //
            //
            //
            //                     overflow: TextOverflow.ellipsis,
            //
            //                     strutStyle: StrutStyle(fontSize:12.0),
            //
            //                     text: TextSpan(
            //
            //
            //
            //                         style: Theme.of(context).textTheme.bodyText1,
            //
            //                         text:" "+ email),
            //
            //                   ),
            //
            //                 ),
            //
            //
            //
            //               ],
            //
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8,right: 8),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //
            //                 Icon(
            //
            //                   Icons.insert_link,
            //
            //                     size: 16,
            //
            //                     color: Theme.of(context).textTheme.headline2!.color
            //
            //
            //                 ),
            //
            //                 Flexible(
            //
            //                   child: RichText(
            //
            //
            //
            //                     overflow: TextOverflow.ellipsis,
            //
            //                     strutStyle: StrutStyle(fontSize: 12.0),
            //
            //                     text: TextSpan(
            //
            //
            //
            //                         style: Theme.of(context).textTheme.bodyText1,
            //
            //                         text:" "+ website),
            //
            //                   ),
            //
            //                 ),
            //
            //
            //
            //               ],
            //
            //             ),
            //           ),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 8,right: 8),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //
            //                   Icon(
            //
            //                     Icons.location_on_outlined,
            //
            //                       size: 16,
            //
            //                       color: Theme.of(context).textTheme.headline2!.color
            //
            //
            //
            //                   ),
            //
            //                   Flexible(
            //
            //                     child: RichText(
            //
            //
            //
            //                       overflow: TextOverflow.ellipsis,
            //
            //                       strutStyle: StrutStyle(fontSize: 12.0),
            //
            //                       text: TextSpan(
            //
            //
            //
            //                           style: Theme.of(context).textTheme.bodyText1,
            //
            //                           text:" "+ city),
            //
            //                     ),
            //
            //                   ),
            //
            //
            //
            //                 ],
            //
            //               ),
            //             ),
            //         ],
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(right: 8.0,left: 8),
            //               child: SizedBox(
            //                 child: ElevatedButton.icon(
            //                   style: ElevatedButton.styleFrom(
            //                       shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(10.0),
            //                         // side: BorderSide(color: Colors.red)
            //                       ),
            //                       primary:Theme.of(context).textTheme.headline2!.color),
            //                   onPressed: () {
            //                     // globalss.unids=id.toString();
            //                     // Navigator.push(
            //                     //   context,
            //                     //   MaterialPageRoute(builder: (context) => UnversityDetailsImages()),
            //                     // );
            //                   },
            //                   icon: Icon(Icons.photo),
            //                   label: Text(""),
            //                 //  child: const Text('images',style:TextStyle(color: Colors.white), ),
            //
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(right: 8.0,left: 8),
            //               child: SizedBox(
            //                 //   width: MediaQuery.of(context).size.width * 0.40,
            //                 child: ElevatedButton.icon(
            //                   style: ElevatedButton.styleFrom(
            //                     //  fixedSize:Size(150, 40) ,
            //                       shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(10.0),
            //                         // side: BorderSide(color: Colors.red)
            //                       ),
            //
            //
            //
            //                       //primary: Color(0xFF2429F9)),
            //                     primary: Theme.of(context).textTheme.headline2!.color),
            //                   onPressed: () {
            //                     // globalss.unids=id.toString();
            //                     // Navigator.push(
            //                     //   context,
            //                     //   MaterialPageRoute(builder: (context) => UnversityDetailsVideo()),
            //                     // );
            //                     },
            //                   label: Text(""),
            //                   icon: Icon(Icons.live_tv),
            //                  // child: const Text('video',style:TextStyle(color: Colors.white), ),
            //                 ),
            //               ),
            //             ),
            //         ],)
            //       ],
            //     ),
            //
            //     Padding(
            //       padding: const EdgeInsets.all(10),
            //       child: Html(data:content,),
            //     ),
            //
            //
            //   ],
            // ),

            SizedBox(height: 30,)
            ],
          ),
        )

    );
  }
}
