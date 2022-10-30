import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/SubCourses.dart';
import 'package:stru2022/Pages/Application/ApplytoCourse.dart';
import 'package:stru2022/mywidget/drawer.dart';

import 'dart:ui' as ui;

import '../../../mywidget/appbarimagewithoutsearch.dart';
import '../../../mywidget/botombarnew.dart';
import '../../kommunicate/prechat.dart';
import '../degreeList.dart';
import '../subCourseInfo.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';


import 'favoriteUniversity.dart';



class favoritesubcoursesList extends StatefulWidget {

  favoritesubcoursesList({Key? key}) : super(key: key);


  @override
  _favoritesubcoursesListState createState() => _favoritesubcoursesListState();
}



class _favoritesubcoursesListState extends State<favoritesubcoursesList> {
  bool issearch = false;
  String searchvalue = '';
  TextEditingController searchvaluecontroller = new TextEditingController();

  bool colorbool = false;
  Icon customIcon =  Icon(Icons.search,size: 60,);
  Widget customSearchBar = const Text('My Personal Journal');

  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> dataa = [];
  //var completer =[] ;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;

  late int length;

   bool result = false;





  Future<bool> getfavoriteSubCourses({required bool isRefresh}) async {

    searchvalue = searchvaluecontroller.text;


    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';
    if(searchvalue!=''){
    //  Url = 'https://studyinrussia.app/api/scholar/favorite/universities?lang=${context.locale.toString()}&page=$currentPage&name=${searchvaluecontroller.text}';
      Url = 'https://studyinrussia.app/api/scholar/favorite/subcourses?lang=${context.locale.toString()}&page=$currentPage&name=${searchvaluecontroller.text}';
    print(Url);
    }
    else{
      Url = 'https://studyinrussia.app/api/scholar/favorite/subcourses?lang=${context.locale.toString()}&page=$currentPage';
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



      //dataa.addAll(getnews.data);
      setState(() {length=dataa.length;});
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
    if(responsef.statusCode == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>favoritesubcoursesList() ));
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
         // SizedBox(height: 10,),
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
                        child: Icon(Icons.menu_book,color: Colors.white,size: 20,)

                        // SvgPicture.asset(
                        //   'assets/svgicon/findcourse.svg',
                        // //  'assets/22images/forum/allpostsicon.svg',
                        //   //color:Theme.of(context).textTheme.headline4!.color,
                        //   fit: BoxFit.contain,
                        //   color: Colors.white,
                        // )
                    ),
                    //FaIcon(FontAwesomeIcons.,color: Colors.deepOrange),
                    label:Text('uninfo.Subcourses'.tr(),style:TextStyle(color: Colors.white), ),
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
                        primary:globalss.cblue),

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
                          color: Colors.grey,
                        )
                    ),
                    //   Icon(Icons.messenger),
                    label:  Text('home.Universities'.tr(),style:TextStyle(color: Colors.grey), ),
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
                        primary: Color(0xFFEEEEEE)

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
                   result = await getfavoriteSubCourses(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },

                onLoading:() async {
                  //           final result = await getPassengerData();

                   result = await getfavoriteSubCourses(isRefresh: false);

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

                  //  colorbool = dataa[i].inCurrentUserFavorite;

                  //  var coloor =(colorbool)?Colors.red : Colors.grey;

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
                                              //  height: MediaQuery.of(context).size.width*(20/375),
                                              //  width: MediaQuery.of(context).size.width*(74/375),

                                                child: FittedBox(
                                                //  fit: BoxFit.fitHeight,

                                                    child: Text("uninfo. APPLY ".tr(),style: TextStyle(color: Colors.white),))),
                                          ) ,
                                        ),
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
                                            padding:  EdgeInsets.only(left: 5.0,right: 5),
                                            child: SizedBox(
                                                height: MediaQuery.of(context).size.width*(30/375),
                                                width: MediaQuery.of(context).size.width*(84/375),
                                                child: FittedBox(child: Text("Show more".tr(),style: TextStyle(color: Colors.white),))),
                                          ) ,
                                        ),
                                      ),


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
                                  icon:Icon(Icons.favorite,color:globalss.cblue,size: MediaQuery.of(context).size.width*(18/375)),
                                          //
                                          //
                                          // SizedBox(
                                          //       height:MediaQuery.of(context).size.width*(30/375),
                                          //       width:MediaQuery.of(context).size.width*(30/375),
                                          //       child: FittedBox(child: Icon(Icons.favorite,color:globalss.cblue,))),
                                          ),
                                        ),
                                      ),
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
                    child:


                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("home.Find out more".tr()),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => degreeList()));
                        }, child: Text('drawer.Find Courses'.tr()))
                      ],
                    ),
                ):
                SizedBox(height: 10,),




            //Center(child: Text("there is no sub courses now",style: TextStyle(fontSize:25 ),))
            ),
          ),
        ],
      )
    );
  }
}

