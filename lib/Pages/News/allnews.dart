import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';

import '../../Model/News.dart';
import 'newsDetails.dart';

import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';



class newsall extends StatefulWidget {
  Map<String, dynamic> pp;
  newsall({Key? key,required this.pp}) : super(key: key);


  @override
  _newsallState createState() => _newsallState();
}



class _newsallState extends State<newsall> {
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





      bottomNavigationBar:myBottomAppBar(),


      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
              padding:  EdgeInsets.only(right: 20.0,left: 20,bottom: 1,top: 10),
              child:Row(
                //crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("drawer.News".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
                 
                ],
              )
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
              child: ListView.separated(
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
                            MaterialPageRoute(builder: (context) => NewsDetails(mapnews: Mapnews))
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 88,
                            width: 108,
                            child:CachedNetworkImage(
                              imageUrl: globalss.UrlImagenews+dataaa.media.toString(),
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(

                                  borderRadius:BorderRadius.circular(8) ,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 4,
                                  //     blurRadius: 4,
                                  //     offset: Offset(0, 3), // changes position of shadow
                                  //   ),
                                  // ],
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dataaa.title.toString(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 16),maxLines: 2,),
                                  SizedBox(height: 5,),
                                  Text(dataaa.description.toString(),maxLines: 2,style: TextStyle(color: Theme.of(context).textTheme.headline5!.color,fontSize: 12)) ,
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    )
                    // ListTile(
                    //   contentPadding: EdgeInsets.symmetric(horizontal: 7.0),
                    //   focusColor: Colors.amberAccent,
                    //   title: Text(dataaa.title.toString(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),maxLines: 1,),
                    //   subtitle:Text(dataaa.description.toString(),maxLines: 3,) ,
                    //   leading:
                    //
                    //   SizedBox(
                    //     height: 60,
                    //     width: 60,
                    //     child: CachedNetworkImage(
                    //       imageUrl: globalss.UrlImagenews+dataaa.media.toString(),
                    //       imageBuilder: (context, imageProvider) => Container(
                    //         decoration: BoxDecoration(
                    //
                    //           borderRadius:BorderRadius.circular(8) ,
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.5),
                    //               spreadRadius: 4,
                    //               blurRadius: 4,
                    //               offset: Offset(0, 3), // changes position of shadow
                    //             ),
                    //           ],
                    //           image: DecorationImage(
                    //             image: imageProvider,
                    //             fit: BoxFit.cover,
                    //           ),
                    //
                    //         ),
                    //       ),
                    //       placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    //       errorWidget: (context, url, error) => Icon(Icons.error),
                    //     ),
                    //
                    //   ) ,
                    //   onTap: (){
                    //     Map<String, dynamic> Mapnews={
                    //       "id": dataaa.id,
                    //       "title": dataaa.title,
                    //       "description": dataaa.description,
                    //       "creator":dataaa.creator,
                    //       "media":dataaa.media,
                    //       "views":dataaa.views,
                    //       "featured":dataaa.featured,
                    //     };
                    //
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => NewsDetails(mapnews: Mapnews))
                    //     );
                    //
                    //   },
                    //   isThreeLine: true,
                    //
                    // ),
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

