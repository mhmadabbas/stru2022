



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/universities.dart';
import 'package:stru2022/Pages/Scholar/universitiesInfo.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';


import 'dart:ui' as ui;
import '../../../mywidget/appbarimagewithoutsearch.dart';
import '../../../mywidget/botombarnew.dart';
import '../../kommunicate/prechat.dart';
import '../universitiesCategory.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'favoritesubcorses.dart';




class favoriteuniversitiesList extends StatefulWidget {
  //Map<String, dynamic> mapunc;
  favoriteuniversitiesList({Key? key}) : super(key: key);


  @override
  _favoriteuniversitiesListState createState() => _favoriteuniversitiesListState();
}



class _favoriteuniversitiesListState extends State<favoriteuniversitiesList> {


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
  bool result = false;
  String UrlImagenews = globalss.UrlImagenews;


  Future favorite({required String idun} ) async {
    var map = new Map<String, dynamic>();
    map['university'] = idun;
    String Urlf = 'https://studyinrussia.app/api/scholar/favorite/add/university';
    final responsef = await http.post(
        Uri.parse(Urlf),
        headers: {"Authorization": "bearer "+globalss.tokenfromserver},
        body: map
    );
    if(responsef.statusCode == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>favoriteuniversitiesList() ));
    }




  }


  Future<bool> getUniversities({required bool isRefresh}) async {
    searchvalue = searchvaluecontroller.text;

    // <List<Datum>>

    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';
    if(searchvalue!=''){
      Url = 'https://studyinrussia.app/api/scholar/favorite/universities?lang=${context.locale.toString()}&page=$currentPage&name=${searchvaluecontroller.text}';

    }
    else{
      Url = 'https://studyinrussia.app/api/scholar/favorite/universities?lang=${context.locale.toString()}&page=$currentPage';

    }
    // if( globalss.uncateforfilter==""){
    //   Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&&page=$currentPage';
    // }else{
    //
    //   Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&page=$currentPage&category=${globalss.uncateforfilter}';
    // }


    print(Url);
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );
    GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));


  //  final getUniversities = getUniversitiesFromJson(response.body);

    //print(getUniversities.data);


    if (response.statusCode == 200) {
      GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));
      final getUniversities = getUniversitiesFromJson(response.body);
      //print(getUniversities.data.toString());
      if (isRefresh) {
        dataa = [];
        if(getUniversities.data.isNotEmpty){
          dataa = getUniversities.data;
        }


      }else {
        if(currentPage <= totalPages){
          if(getUniversities.data.isNotEmpty) {
            dataa.addAll(getUniversities.data);
          }
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
    //  print("total pages "+totalPages.toString());
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
            Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.width*(15/375) ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text("drawer.Favorites".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                  ],
                )
            ),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width *(172/375),
                    child: ElevatedButton.icon(
                      icon:   Container(
                          height: 20,
                          width: 20,
                          child: Icon(Icons.menu_book,color: Colors.grey,size: 20,)

                        // SvgPicture.asset(
                        //   'assets/svgicon/findcourse.svg',
                        // //  'assets/22images/forum/allpostsicon.svg',
                        //   //color:Theme.of(context).textTheme.headline4!.color,
                        //   fit: BoxFit.contain,
                        //   color: Colors.white,
                        // )
                      ),
                      //FaIcon(FontAwesomeIcons.,color: Colors.deepOrange),
                      label:Text('uninfo.Subcourses'.tr(),style:TextStyle(color: Colors.grey), ),
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          //  fixedSize:Size(150, 40) ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight:  Radius.circular(0),
                              topRight:  Radius.circular(0),
                              topLeft: Radius.circular(20),

                            ),
                          ),
                          primary:Color(0xFFEEEEEE)),

                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => favoritesubcoursesList()),
                        );
                      },
                      //  child:  Text('post.All Posts'.tr(),style:TextStyle(color: Colors.white), ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *(172/375),

                    child: ElevatedButton.icon(
                      icon:
                      Container(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/new_svg/unhat.svg',
                            //  'assets/22images/forum/yourpostsicon.svg',
                            //color:Theme.of(context).textTheme.headline4!.color,
                            fit: BoxFit.contain,
                            color: Colors.white,
                          )
                      ),
                      //   Icon(Icons.messenger),
                      label:  Text('home.Universities'.tr(),style:TextStyle(color: Colors.white), ),
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          //   fixedSize:Size(150, 40) ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight:  Radius.circular(20),
                              topRight:  Radius.circular(20),
                              topLeft: Radius.circular(0),

                            ),

                            // side: BorderSide(color: Colors.red)
                          ),
                          primary: globalss.cblue

                      ),

                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => favoriteuniversitiesList()),
                        );

                      },
                      //  child:  Text('post.Your Posts'.tr(),style:TextStyle(color: Colors.grey), ),
                    ),
                  ),



                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width*(5/375),),

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

                     // colorbool = dataa[i].inCurrentUserFavorite;

                    //  var coloor =(colorbool)?globalss.cblue: Colors.grey;


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
                                          // child: Center(
                                          //     child: Padding(
                                          //       padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(1/375),right:MediaQuery.of(context).size.width*(1/375)),
                                          //       child: Text("Show more",
                                          //         style: TextStyle(
                                          //             color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),),
                                          //     )),
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
                                            icon:Icon(Icons.favorite,color:globalss.cblue,size: MediaQuery.of(context).size.width*(18/375)),

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
                  Center(child:                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("home.Find out more".tr()),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => uncategory()));
                      }, child: Text('drawer.Find Universities'.tr()))
                    ],
                  ),
                  )
                      :
                  SizedBox(height: 10,),
              ),
            ),
          ],
        )
    );
  }
}






















