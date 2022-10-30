


import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/broadcasts/broadcasts.dart';


import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';



import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../home.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'archivebroadcasts.dart';







class broadcastscomming extends StatefulWidget {

  broadcastscomming({Key? key}) : super(key: key);


  @override
  _broadcastscommingState createState() => _broadcastscommingState();
}



class _broadcastscommingState extends State<broadcastscomming> {
  bool issearch = false;
  String searchvalue = '';
  TextEditingController searchvaluecontroller = new TextEditingController();

  bool colorbool = false;
  bool result=false;
  Icon customIcon =  Icon(Icons.search,size: 60,);
  Widget customSearchBar = const Text('My Personal Journal');
  int ee = 0 ;
  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> dataa = [];

  List mhj = [];
  //var completer =[] ;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;





  Future<bool> getbroadcast({required bool isRefresh}) async {
    searchvalue = searchvaluecontroller.text;
    // <List<Datum>>

    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';



    if(searchvalue!=''){
      Url = 'https://studyinrussia.app/api/broadcasts?active=1&lang=${context.locale.toString()}&page=$currentPage&title=${searchvaluecontroller.text}';
      print(Url);
    }else{
      Url = 'https://studyinrussia.app/api/broadcasts?active=1&lang=${context.locale.toString()}&page=$currentPage';
      print(Url);
    }
    //
    //   Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&&page=$currentPage';



    print(Url);
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );

    Broadcasts broadcastsFromJson(String str) => Broadcasts.fromJson(convert.json.decode(response.body));
    final broadcasts = broadcastsFromJson(response.body);

    //print(getUniversities.data);


    if (response.statusCode == 200) {
      Broadcasts broadcastsFromJson(String str) => Broadcasts.fromJson(convert.json.decode(response.body));
      final broadcasts = broadcastsFromJson(response.body);
      //print(getUniversities.data.toString());
      if (isRefresh) {
        dataa = [];
        dataa = broadcasts.data;

      }else {
        if(currentPage <= totalPages){
          dataa.addAll(broadcasts.data);
        }
      }



      totalPages =(broadcasts.pagination.totalItems / 10).round();
      if ((totalPages * 10) < broadcasts.pagination.totalItems) {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375) ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeLand()),
                          );
                        },
                        icon: Icon(Icons.arrow_back)
                    ),
                    Text("broadcasts.Broadcasts".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                  ],
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.width*(10/375) ,),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width *(172/375),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.archive,color: Colors.grey,),
                      //FaIcon(FontAwesomeIcons.,color: Colors.deepOrange),
                      label:Text('broadcasts.archive'.tr(),style:TextStyle(color:Colors.grey), ),
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
                          primary:Color(0xFFEEEEEE) ),

                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => broadcastsarchive()),
                        );
                      },
                      //  child:  Text('post.All Posts'.tr(),style:TextStyle(color: Colors.white), ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *(172/375),

                    child: ElevatedButton.icon(
                      icon:

                      Icon(Icons.upcoming,color: Colors.white ,),
                      label:  Text('broadcasts.upcoming'.tr(),style:TextStyle(color:Colors.white ), ),
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
                          MaterialPageRoute(builder: (context) => broadcastscomming()),
                        );

                      },
                      //  child:  Text('post.Your Posts'.tr(),style:TextStyle(color: Colors.grey), ),
                    ),
                  ),
                ],
              ),
            ),


            Expanded(
              child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () async {
                     result = await getbroadcast(isRefresh: true);
                    if (result) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },

                  onLoading:() async {
                    //           final result = await getPassengerData();

                     result = await getbroadcast(isRefresh: false);

                    //  await getNews();
                    if (result){
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  },
                  child:
                  (result&&dataa.length==0)?

                  SizedBox(
                    child: Center(child: Text("Stay tuned for more broadcasts".tr())),
                  )

                      :
                  (result&&dataa.length>0)?  ListView.separated(
                    padding: EdgeInsets.only(top:  MediaQuery.of(context).size.width*(15/375)),


                    itemBuilder: (context, i){
                      var dataaa = dataa[i];

                      // colorbool = dataa[i].inCurrentUserFavorite;
                      //
                      // var coloor =(colorbool)?Colors.red : Colors.grey;


                      return Padding(
                        padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*(15/375) ,left: MediaQuery.of(context).size.width*(15/375)),
                        child: Container(
                       //   height: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10),),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                //offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],),
                          child:

                          Column(
                            //crossAxisAlignment:CrossAxisAlignment.stretch ,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(

    children: [

      Icon(Icons.date_range_outlined,color:Theme.of(context).textTheme.headline1!.color,size: 12, ),

      Text(" "+dataaa.broadcastTime.date.toString().substring(0, 16) ,style: TextStyle(color:Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold,fontSize: 12),maxLines: 1,),



    ],

  ),
),


                              ListTile(


                                contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                                visualDensity: VisualDensity(horizontal: 4, vertical: 4),
                              //  dense: true,

                                hoverColor: Colors.red,
                                // minLeadingWidth: 120,
                                focusColor: Colors.amberAccent,
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3,bottom: 3),
                                  child: Text(dataaa.title.toString() ,style: TextStyle(fontWeight: FontWeight.bold),),
                                ),

                                 // ,
                                 // style: TextStyle(color: Color(0xFF2429F9),fontWeight: FontWeight.bold),maxLines: 1,),
                                subtitle:Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3,bottom: 8),
                                  child: Text(dataaa.description.toString(),style: TextStyle(fontSize: 12), ),
                                ) ,



                                onTap: (){
                                  // globalss.unids=dataaa.id.toString();
                                  // Map<String, dynamic> Mapnews={
                                  //   "id": dataaa.id,
                                  //   "title": dataaa.name,
                                  //   "description": dataaa.description,
                                  //   "creator":dataaa.logo,
                                  // };
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => UnversityDetails(mapun:Mapnews,))
                                  // );

                                },


                              ),


                            ],

                          ),
                        ),
                      );




                    },
                    separatorBuilder: (context, i) => Divider(),

                    itemCount: dataa.length,

                  )
                        :
                    (!result&&dataa.length==0)?
                    SizedBox(
                    //child: CircularProgressIndicator(),
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






















