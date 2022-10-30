



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/Model/universities.dart';
import 'package:stru2022/Pages/Scholar/universitiesInfo.dart';
import 'package:stru2022/mywidget/appbarnonimage.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';



import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../Siginin.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'SubCoursList.dart';
import 'coursesList.dart';
import 'degreeList.dart';



class universitiesList extends StatefulWidget {
  //Map<String, dynamic> mapunc;
  universitiesList({Key? key}) : super(key: key);


  @override
  _universitiesListState createState() => _universitiesListState();
}



class _universitiesListState extends State<universitiesList> {
  bool issearch = false;
  String searchvalue = '';
  TextEditingController searchvaluecontroller = new TextEditingController();

bool colorbool = false;

  Icon customIcon =  Icon(Icons.search,size: 60,);
  Widget customSearchBar = const Text('My Personal Journal');
  int ee = 0 ;
  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datumun> dataa = [];

  List mhj = [];
  //var completer =[] ;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;

  bool result=false;


  Future favorite({required String idun} ) async {
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


  Future<bool> getUniversities({required bool isRefresh}) async {
    searchvalue = searchvaluecontroller.text;
    // <List<Datum>>

    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';

    if( globalss.uncateforfilter==""){

      if(searchvalue!=''){
        Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&page=$currentPage&name=${searchvaluecontroller.text}';
        print(Url);
      }else{
        Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&page=$currentPage';
        print(Url);
      }
      //
   //   Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&&page=$currentPage';
    }else{

      if(searchvalue!=''){
        Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&page=$currentPage&category=${globalss.uncateforfilter}&name=${searchvaluecontroller.text}';
        print(Url);
      }else{
        Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&page=$currentPage&category=${globalss.uncateforfilter}';
        print(Url);
      }
    }


    print(Url);
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );
    GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));


    final getUniversities = getUniversitiesFromJson(response.body);

    //print(getUniversities.data);


    if (response.statusCode == 200) {
      GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));
      final getUniversities = getUniversitiesFromJson(response.body);
      //print(getUniversities.data.toString());
      if (isRefresh) {
        dataa = [];
        dataa = getUniversities.data;

      }else {
        if(currentPage <= totalPages){
          dataa.addAll(getUniversities.data);
        }
      }



      totalPages =(getUniversities.pagination.totalItems / 10).round();
      if ((totalPages * 10) < getUniversities.pagination.totalItems) {
        totalPages=totalPages+1;
      }else{
        totalPages=1;
      }

      if(currentPage <= totalPages){
        currentPage++;
      }

      // print(dataa.first.inCurrentUserFavorite);
      // print(totalPages);
      // print("total pages "+totalPages.toString());
      setState(() {});
      return true;
    }else{
      print("some error not 200");
      return false;

    }


  }


  @override
  Widget build(BuildContext context) {

    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
        endDrawer:MyDrawer(),
        appBar:ApplicationToolbarnosearch(),



        bottomNavigationBar:myBottomAppBarnew(),
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


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),

          (globalss.Fromprossbar!='')?
          Container(
              height: (MediaQuery.of(context).size.width-40)/4,
              alignment: Alignment.centerLeft,

              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: ListView(



                  scrollDirection:Axis.horizontal,
                  reverse: true,






                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width-40,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image(
                              image: AssetImage(
                                  "assets/22images/scholar/arrow2.png"),
                              fit: BoxFit.fill,
                              matchTextDirection: true,
                            ),
                          ),
                          Positioned.fill(
                              child: Padding(
                                padding:EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,



                                  children: [
                                    SizedBox(
                                      width:(MediaQuery.of(context).size.width-40)/2,
                                      height:(MediaQuery.of(context).size.width-40)/4 ,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,


                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 35,),
                                              Text("processcourse.select".tr()),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              // Icon(Icons.grade,size: 15),
                                              SizedBox(width: 10,),
                                              SvgPicture.asset('assets/22images/scholar/iconun.svg',color: Theme.of(context).textTheme.headline1!.color ,fit:BoxFit.cover ,),
                                              SizedBox(width: 2,),
                                              Container(
                                                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/6, maxWidth: MediaQuery.of(context).size.width*(60/100)),
                                                  height: MediaQuery.of(context).size.width*(8/100),
                                                  child: FittedBox(child: Text( "processcourse.University".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 25 ,fontWeight: FontWeight.bold ) ))),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text("03",style: TextStyle(color:(Theme.of(context).textTheme.headline1!.color==globalss.cblue)?globalss.cblue.withOpacity(0.2):Colors.white.withOpacity(0.2),fontSize: 40 ,fontWeight: FontWeight.bold ),)
                                  ],
                                ),
                              )
                          )

                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-40,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image(
                              image: AssetImage(
                                  "assets/22images/scholar/arrow1.png"),
                              fit: BoxFit.fill,
                              matchTextDirection: true,
                            ),
                          ),
                          Positioned.fill(
                              child: Padding(
                                padding:EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,



                                  children: [
                                    SizedBox(
                                      width:(MediaQuery.of(context).size.width-40)/2,
                                      height:(MediaQuery.of(context).size.width-40)/4 ,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,


                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 35,),
                                              Text("processcourse.select".tr()),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              // Icon(Icons.grade,size: 15),
                                              SizedBox(width: 10,),
                                              SvgPicture.asset('assets/22images/scholar/iconcourse.svg',color: Theme.of(context).textTheme.headline1!.color ,fit:BoxFit.cover ,),
                                              SizedBox(width: 2,),
                                              Container(
                                                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/6, maxWidth: MediaQuery.of(context).size.width*(60/100)),
                                                  height: MediaQuery.of(context).size.width*(8/100),
                                                  child: FittedBox(child: Text( "processcourse.Course".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color,fontSize: 30 ,fontWeight: FontWeight.bold ) ))),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text("02",style: TextStyle(color: (Theme.of(context).textTheme.headline1!.color==globalss.cblue)?globalss.cblue.withOpacity(0.2):Colors.white.withOpacity(0.2),fontSize: 40 ,fontWeight: FontWeight.bold ),)
                                  ],
                                ),
                              )
                          )

                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-40,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child:
                            Image(
                              image: AssetImage(
                                  "assets/22images/scholar/arrow.png"),
                              fit: BoxFit.fill,
                              matchTextDirection: true,
                            ),

                          ),
                          Positioned.fill(
                              child: Padding(
                                padding:EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,



                                  children: [
                                    SizedBox(
                                      width:(MediaQuery.of(context).size.width-40)/2,
                                      height:(MediaQuery.of(context).size.width-40)/4 ,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,


                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 35,),
                                              Text("processcourse.select".tr()),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [


                                              SvgPicture.asset('assets/22images/scholar/icondegree.svg',color: Theme.of(context).textTheme.headline1!.color ,fit:BoxFit.cover ,),
                                              SizedBox(width: 2,),
                                              Container(
                                                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/6, maxWidth: MediaQuery.of(context).size.width*(60/100)),
                                                  height: MediaQuery.of(context).size.width*(8/100),
                                                  child: FittedBox(child: Text("processcourse.Degree".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 30 ,fontWeight: FontWeight.bold ) ))),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text("01",style: TextStyle(color:(Theme.of(context).textTheme.headline1!.color==globalss.cblue)?globalss.cblue.withOpacity(0.2):Colors.white.withOpacity(0.2),fontSize: 40 ,fontWeight: FontWeight.bold ),)
                                  ],
                                ),
                              )

                          )

                        ],
                      ),
                    ),




                  ],
                ),
              )
          )


              :
//Text("fg"),
          Padding(
              padding:  EdgeInsets.only(right: 20.0,left: 20,bottom: 1,top: 10),
              child:Row(
                //crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("home.Universities".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),

                ],
              )
          ),

          Padding(
            padding:  EdgeInsets.only(right: 20.0,left: 20,bottom: 5,top: 2),

            child:  TextFormField(
                textInputAction: TextInputAction.search,
                controller: searchvaluecontroller,
                decoration: InputDecoration(
                    isDense: true,
                    label: Text("Search".tr()),
                    prefixIcon: Icon(Icons.search),
                    floatingLabelBehavior:FloatingLabelBehavior.never),


                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Please enter search";
                //   }
                //   if (value.length < 10 ) {
                //     return "An invalid email address";
                //   }
                //   //
                //   // return null;
                // },
                onFieldSubmitted: (value)async{

                  await getUniversities(isRefresh: true);

                }
            ),
          ),

          Expanded(
            child: SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () async {
                   result = await getUniversities(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },

                onLoading:() async {
                  //           final result = await getPassengerData();

                   result = await getUniversities(isRefresh: false);

                  //  await getNews();
                  if (result){
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadFailed();
                  }
                },
              child:


              (!result&&dataa.length==0)? SizedBox(height: 10,):
              (result&&dataa.length>0)?ListView.separated(
                padding: EdgeInsets.only(top: 2),


                itemBuilder: (context, i){
                  var dataaa = dataa[i];

                  colorbool = dataa[i].inCurrentUserFavorite;

                  var coloor =(colorbool)?globalss.cblue: Colors.grey;


                  return Padding(
                 //   padding: const EdgeInsets.only(right:24 ,left: 24,top: 5),
                    padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*(15/375) ,left: MediaQuery.of(context).size.width*(15/375),top: MediaQuery.of(context).size.width*(15/375)),

                    child: Container(

                      child:

                      Column(
                        //crossAxisAlignment:CrossAxisAlignment.stretch ,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [




                          CachedNetworkImage(
                            height: MediaQuery.of(context).size.width/2.2,
                            width: MediaQuery.of(context).size.width,
                            // fit: BoxFit.fitHeight,

                            imageUrl: globalss.UrlImageuniversity+dataaa.logo.toString(),
                            imageBuilder: (context, imageProvider) =>
                            // CircleAvatar(
                            //   radius: 200,
                            //   backgroundImage: imageProvider,
                            // ),
                            Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10),),


                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),



                              ),
                            ),
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),


                          ) ,


                          Container(
                            height: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              //  SizedBox(width: 16,),
                                Icon(Icons.location_on_outlined ,size: 15,),
                                Text(dataaa.city.name.toString(),style: TextStyle(fontSize: 10),)
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(dataaa.name.toString() ,style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),
                            ],
                          ),

                          Container(
                            height: MediaQuery.of(context).size.width*(45/375),

                            child: Padding(
                              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375) ),

                              child: Row(
                                // crossAxisAlignment:CrossAxisAlignment.center ,
                                mainAxisAlignment:MainAxisAlignment.start ,
                                children: [
                                  SizedBox(
                                    height:MediaQuery.of(context).size.width*(29/375),
                                    width:MediaQuery.of(context).size.width*(84/375) ,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                             // shadowColor:Colors.transparent,
                                        elevation: 0,
                                        primary: globalss.cblue.withOpacity(0.1),
                                      ),
                                      onPressed: () {
                                        Map<String, dynamic> Mapnews={
                                          "id": dataaa.id,
                                          "title": dataaa.name,
                                          "description": dataaa.description,
                                          "creator":dataaa.logo,

                                        };
                                    //    globalss.ginCurrentUserFavorite = dataaa.inCurrentUserFavorite;

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => UnversityDetails(mapun: Mapnews))
                                        );
                                      },
                                      child: Center(
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(1/375),right:MediaQuery.of(context).size.width*(1/375)),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*(84/375),
                                              child: FittedBox(
                                                child: Text("Show more".tr(),
                                                  style: TextStyle(
                                                      color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),

                                  CircleAvatar(
                                    backgroundColor:globalss.cblue.withOpacity(0.1) ,
                                  //  radius: 25,
                                    radius: MediaQuery.of(context).size.width*(29/375),
                                    child:
                                    Center(
                                      child: IconButton(
                                      onPressed: ()async{
                                        await favorite(idun: dataaa.id.toString());

                                        setState((){
                                          if(dataaa.inCurrentUserFavorite){
                                            dataaa.inCurrentUserFavorite  = false;
                                          }else{
                                            dataaa.inCurrentUserFavorite  = true;
                                          }
                                        });



                                      },
                                    //  icon:Icon(Icons.favorite,color:coloor),
                                        icon:Icon(Icons.favorite,color:coloor,size: MediaQuery.of(context).size.width*(18/375)),

                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),

                          )
                        ],

                      ),
                    ),
                  );





                },
                separatorBuilder: (context, i) => Divider(),

                itemCount: dataa.length,

              ):
              (result&&dataa.length==0)?
              Center(child:Text("coming soon.."),)
                  :
              SizedBox(height: 10,),

            ),
          ),
        ],
      )
    );
  }
}






















