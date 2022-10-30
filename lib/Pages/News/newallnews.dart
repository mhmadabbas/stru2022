import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';

import '../../Model/News.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import 'newnewsdetails.dart';
import 'newsDetails.dart';

import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';



class newnewsall extends StatefulWidget {
  Map<String, dynamic> pp;
  newnewsall({Key? key,required this.pp}) : super(key: key);


  @override
  _newnewsallState createState() => _newnewsallState();
}



class _newnewsallState extends State<newnewsall> {
  bool issearch = false;
  String searchvalue = '';
  TextEditingController searchvaluecontroller = new TextEditingController();


  Icon customIcon =  Icon(Icons.search,size: 60,);
  Widget customSearchBar = const Text('My Personal Journal');

  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datumn> dataa = [];
  //var completer =[] ;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;





  Future<bool> getNews({required bool isRefresh}) async {

    searchvalue = searchvaluecontroller.text;

    // <List<Datum>>

    if (isRefresh) {
      currentPage = 1;
    }
    String Url ='';



    if(widget.pp["idd"].toString()=='notnumber'){
      // Url = 'https://studyinrussia.app/api/news?lang=${context.locale.toString()}&page=$currentPage';
      if(searchvalue!=''){
        Url = 'https://studyinrussia.app/api/news?lang=${context.locale.toString()}&page=$currentPage&title=${searchvaluecontroller.text}';
        print(Url);
      }else{
        Url = 'https://studyinrussia.app/api/news?lang=${context.locale.toString()}&page=$currentPage';
        print(Url);
      }
    }else{
      if(searchvalue!=''){
        Url = 'https://studyinrussia.app/api/news?lang=${context.locale.toString()}&category=${widget.pp["idd"].toString()}&page=$currentPage&title=${searchvaluecontroller.text}';
        print(Url);
      }else{
        Url = 'https://studyinrussia.app/api/news?lang=${context.locale.toString()}&category=${widget.pp["idd"].toString()}&page=$currentPage';
        print(Url);
      }
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

      if (isRefresh) {
        dataa = [];
        dataa = getnews.data;
      }else {
        if(currentPage <= totalPages){
          dataa.addAll(getnews.data);
        }
      }



      totalPages =(getnews.pagination.totalItems / 10).round();
      if ((totalPages * 10) < getnews.pagination.totalItems) {
        totalPages=totalPages+1;
      }else{
        totalPages=1;
      }

      if(currentPage <= totalPages){
        currentPage++;
      }


      print(totalPages);
      //dataa.addAll(getnews.data);
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




        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
                padding:  EdgeInsets.only(right: 20.0,left: 20,bottom: 1,top: 10),
                child:Row(
                  //crossAxisAlignment: CrossAxisAlignment.,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("drawer.Latest News".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),

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


                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter search";
                    }
                    if (value.length < 10 ) {
                      return "An invalid email address";
                    }
                    //
                    // return null;
                  },
                  onFieldSubmitted: (value)async{
                    // here you do your operation when you hit the
                    // keypad magnifying lens
                    // check with print()
                    // print('Pressed via keypad');
                    await getNews(isRefresh: true);

                  }
              ),
            ),
            Expanded(
              child:  SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () async {
                    bool result = await getNews(isRefresh: true);
                    if (result) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },

                  onLoading:() async {
                    //           final result = await getPassengerData();

                    bool result = await getNews(isRefresh: false);

                    //  await getNews();
                    if (result){
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  },
                  child:



                  ListView.separated(
                    padding:EdgeInsets.only(top:10),

                    itemBuilder: (context, i){
                      final dataaa = dataa[i];
                      return Container(
                          margin: EdgeInsets.only(right: 16,left: 16),
                          decoration: BoxDecoration(
                            // color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5),),

                          ),
                          child: GestureDetector(
                            onTap: (){
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
                            child:
                            Column(
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
                                // SizedBox(height:MediaQuery.of(context).size.width*16/375 ,),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          //     icon: Icon(Icons.remove_red_eye_outlined,color:Theme.of(context).textTheme.headline5!.color ),
                                          icon: Icon(Icons.remove_red_eye_outlined,color:Theme.of(context).textTheme.headline5!.color ,size: 16),

                                          //    label: Text(dataaa.views.toString(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color )),
                                          label: Text(dataaa.views.toString(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color,fontSize: 12 )),

                                          onPressed: null,

                                        ),
                                      ),

                                    ),

                                  ],
                                ),
                              ],
                            )
                            // Column(
                            //   children: [
                            //     Row(
                            //       mainAxisSize: MainAxisSize.max,
                            //       children: [
                            //         SizedBox(
                            //           height: MediaQuery.of(context).size.width/4,
                            //           width: MediaQuery.of(context).size.width/4,
                            //           child:CachedNetworkImage(
                            //             imageUrl: globalss.UrlImagenews+dataaa.media.toString(),
                            //             imageBuilder: (context, imageProvider) => Container(
                            //               decoration: BoxDecoration(
                            //
                            //                 borderRadius:BorderRadius.circular(8) ,
                            //                 image: DecorationImage(
                            //                   image: imageProvider,
                            //                   fit: BoxFit.cover,
                            //                 ),
                            //
                            //               ),
                            //             ),
                            //             placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            //             errorWidget: (context, url, error) => Icon(Icons.error),
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child:
                            //           Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: SizedBox(
                            //               height: MediaQuery.of(context).size.width/4,
                            //               child: Column(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 mainAxisSize: MainAxisSize.max,
                            //                 children: [
                            //                   Text(dataaa.title.toString(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 16),maxLines: 2,),
                            //                   SizedBox(height: 5,),
                            //                   Text(dataaa.description.toString(),maxLines: 2,style: TextStyle(color: Theme.of(context).textTheme.headline5!.color,fontSize: 12)) ,
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         )
                            //
                            //       ],
                            //     ),
                            //     // Row(
                            //     //   children: [
                            //     //     SizedBox(
                            //     //       width: MediaQuery.of(context).size.width/4,
                            //     //
                            //     //       child: ElevatedButton(
                            //     //
                            //     //         style: ElevatedButton.styleFrom(
                            //     //
                            //     //             shape: RoundedRectangleBorder(
                            //     //               borderRadius: BorderRadius.circular(20.0),
                            //     //             ),
                            //     //
                            //     //             primary: Color(0xFF002BFF)
                            //     //
                            //     //         ),
                            //     //         onPressed: () {
                            //     //
                            //     //         },
                            //     //         child:  Text("Continue",style: TextStyle(color:Colors.white),),
                            //     //       ),
                            //     //     ),
                            //     //
                            //     //   ],
                            //     // ),
                            //     Row(
                            //       mainAxisSize: MainAxisSize.max,
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         SizedBox(
                            //           height: MediaQuery.of(context).size.width*(29/375),
                            //           //  width: MediaQuery.of(context).size.width*(84/375),
                            //           child:ElevatedButton(
                            //
                            //             style: ElevatedButton.styleFrom(
                            //
                            //
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.circular(20.0),
                            //
                            //
                            //               ),
                            //               elevation: 0,
                            //               //  shadowColor:Colors.transparent,
                            //               primary:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),
                            //             ),
                            //             onPressed: () {
                            //               Map<String, dynamic> Mapnews={
                            //                 "id": dataaa.id,
                            //                 "title": dataaa.title,
                            //                 "description": dataaa.description,
                            //                 "creator":dataaa.creator,
                            //                 "media":dataaa.media,
                            //                 "views":dataaa.views,
                            //                 "featured":dataaa.featured,
                            //               };
                            //
                            //               Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(builder: (context) => newNewsDetails(mapnews: Mapnews))
                            //               );
                            //             },
                            //             child: Center(
                            //                 child: Text("Show more",
                            //                   style: TextStyle(
                            //                       color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),maxLines: 1,)
                            //             ),
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height:MediaQuery.of(context).size.width*29/375 ,
                            //           child:
                            //           Container(
                            //
                            //             decoration: BoxDecoration(
                            //
                            //
                            //               borderRadius:BorderRadius.circular(20) ,
                            //               color:
                            //               (Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),
                            //
                            //
                            //             ),
                            //
                            //
                            //             child: TextButton.icon(
                            //               //     icon: Icon(Icons.remove_red_eye_outlined,color:Theme.of(context).textTheme.headline5!.color ),
                            //               icon: Icon(Icons.remove_red_eye_outlined,color:Theme.of(context).textTheme.headline5!.color ,size: 16),
                            //
                            //               //    label: Text(dataaa.views.toString(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color )),
                            //               label: Text(dataaa.views.toString(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color,fontSize: 12 )),
                            //
                            //               onPressed: null,
                            //
                            //             ),
                            //           ),
                            //
                            //         ),
                            //
                            //       ],
                            //     ),
                            //   ],
                            // )
                          )

                      );


                    },
                    separatorBuilder: (context, i) => SizedBox(height: 15,),

                    itemCount: dataa.length,

                  )
              ),
            )

          ],
        )

    );
  }
}

