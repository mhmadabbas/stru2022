import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/Model/News.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';

import 'allnews.dart';
import '../../Model/Categories.dart';
import '../../Model/News.dart';
import '/Vars/globalss.dart' as globalss;
import 'newsDetails.dart';

class newscategory extends StatefulWidget {
  const newscategory({Key? key}) : super(key: key);

  @override
  _newscategoryState createState() => _newscategoryState();
}

class _newscategoryState extends State<newscategory> {




  final RefreshController refreshController = RefreshController();
  final String assetName = 'assets/SVG_ICONS/AboutUs.svg';

  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> datac = [];

  List<Datumn> datan = [];

  String catnumber='notnumber' ;
  String passcatnumber='notnumber' ;
  String selectedcate='' ;
  int selectedtocolored = 200;
  


  Future<Getcat> getnewscategory() async {
    print(context.locale);
    String Url = 'https://studyinrussia.app/api/news/categories?lang='+context.locale.toString();
    var response = await http.get(
      Uri.parse(Url),
    );
    Getcat getcatFromJson(String str) => Getcat.fromJson(convert.json.decode(response.body));
    String getcatToJson(Getcat data) => convert.json.encode(data.toJson());

    final getcat = getcatFromJson(response.body);


     // catnumber = getcat.data![0].id.toString();





print(getcat.message);
     return getcat;

  }

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
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
      endDrawer:MyDrawer(),
      appBar:ApplicationToolbarnosearch(),


      bottomNavigationBar:myBottomAppBar(),


      body: Padding(
        padding: const EdgeInsets.only(right: 8.0,left:  8.0,bottom:  8.0),
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(right: 20.0,left: 20,bottom: 1,top: 10),
              child:Row(
                //crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("drawer.News".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
                  TextButton(
                    style: TextButton.  styleFrom(
                      textStyle: const TextStyle(fontSize: 15,color: Colors.red),

                      primary: Colors.blue,


                    ),
                    onPressed: (){
                      Map<String, dynamic> ppp={
                        "idd": catnumber,
                        "title": selectedcate,
                      };



                      if(catnumber=='notnumber'){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => newsall(pp: ppp,))
                        );
                        //  Alert(context: context, title: "", desc: "select category first.").show();

                      }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => newsall(pp: ppp,))
                        );
                      }


                    },
                    child:  Text('View All..'.tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 13,),),

                  ),
                ],
              )
            ),
            FutureBuilder(
              future:
              getnewscategory(),
              builder: (context,AsyncSnapshot snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(child: SizedBox(),);
                    }
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      return Row(
                        mainAxisAlignment:MainAxisAlignment.start ,
                        children: [
                         SizedBox(width: 15,),
                          SizedBox(height: 60,),
                          // Container(
                          //   decoration: BoxDecoration(
                          //    // borderRadius: BorderRadius.circular(8),
                          //     color:Colors.blue,
                          //       shape:BoxShape.rectangle,
                          //       borderRadius: BorderRadius.all(Radius.circular(20.0))
                          //   ),
                          //     height: 40,
                          // //width: 50,
                          //
                          //
                          //
                          // child:Center(child: Padding(
                          //   padding: const EdgeInsets.only(left: 12.0,right: 12),
                          //   child: Text("All"),
                          // ))
                          // // GestureDetector(
                          // //
                          // //     child: SvgPicture.asset('assets/SVG_ICONS/NEWS.svg',color: Colors.white ,fit:BoxFit.cover ,),
                          // //   onTap: (){
                          // //       setState(() {
                          // //          catnumber='notnumber' ;
                          // //          passcatnumber='notnumber' ;
                          // //          selectedcate='' ;
                          // //          selectedtocolored=200;
                          // //       });
                          // //
                          // //   },
                          // // ),
                          //
                          // //Icon(Icons.ten_mp,size: 50,)
                          // ),
                SizedBox(width: 2,),
                Expanded(
                  child:Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //    // color:Colors.grey.withOpacity(0.3),
                // ),
                           height: 40,


                            // width: 300,
                            child: ListView.builder(

                             shrinkWrap: false,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, i){
                                //selectedtocolored = dataa[i].inCurrentUserFavorite;

                               // var coloor =(selectedtocolored == i)?Colors.blue : Colors.red;
                                var coloor =(selectedtocolored == i)?globalss.cblue : globalss.cgray;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 1.0 , right: 1.0),
                                  child: Container(
                                    //  height: 90,
                                   // width: 100,
                                    child: GestureDetector(
                                      onTap: (){
                                     //   print("clicked");
                                        setState(() {
                                          catnumber = snapshot.data.data[i].id.toString();
                                          selectedcate = snapshot.data.data[i].name.toString();
                                          selectedtocolored = i;

                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                            color: coloor,
                                            shape:BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10),
                                          child: Center(
                                            child: Text(snapshot.data.data[i].name,style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },


                            ),
                          ),),
                          SizedBox(width: 15,),
                        ],

                      );

                    }
                }
                return Center(child: SizedBox(),);


              },
            ),

            FutureBuilder(
                future: getNews(),
                builder: (context,AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    case ConnectionState.done:
                      if (snapshot.hasData) {

                        return Expanded(
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                           // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(4.0),
                              //   child: Center(child:(selectedcate=='')?Text("please select category.",style: TextStyle(fontSize:12),):Text(selectedcate.toString(),style: TextStyle(fontSize: 12),),),
                              // ),
                              Expanded(
                                child:(snapshot.data.data.length>0)? ListView.separated(
                                  padding:EdgeInsets.only(top: 5),

                                  itemBuilder: (context, i){
                                    final dataaa =snapshot.data.data[i];
                                    return Container(
                                      margin: EdgeInsets.only(right: 16,left: 16),
                                        decoration: BoxDecoration(
                                       // color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.all(Radius.circular(5),),

                                        ),
                                      child:
                                        GestureDetector(
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
                                      //     height: double.infinity,
                                      //    // width: double.infinity,
                                      //     // height: 60,
                                      //      width: 60,
                                      //     child: CachedNetworkImage(
                                      //       imageUrl: globalss.UrlImagenews+snapshot.data.data[i].media.toString(),
                                      //       imageBuilder: (context, imageProvider) => Container(
                                      //         decoration: BoxDecoration(
                                      //
                                      //           borderRadius:BorderRadius.circular(8) ,
                                      //           // boxShadow: [
                                      //           //   BoxShadow(
                                      //           //     color: Colors.grey.withOpacity(0.5),
                                      //           //     spreadRadius: 4,
                                      //           //     blurRadius: 4,
                                      //           //     offset: Offset(0, 3), // changes position of shadow
                                      //           //   ),
                                      //           // ],
                                      //           image: DecorationImage(
                                      //             image: imageProvider,
                                      //             fit: BoxFit.fill,
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
                                  // separatorBuilder: (context, i) => Divider(),
                                  separatorBuilder: (context, i) => SizedBox(height: 15,),
                                  itemCount: snapshot.data.data.length,

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

                              // Center(child:TextButton(
                              //   style: TextButton.  styleFrom(
                              //     textStyle: const TextStyle(fontSize: 15,color: Colors.red),
                              //
                              //     primary: Colors.blue,
                              //
                              //
                              //   ),
                              //   onPressed: (){
                              //     Map<String, dynamic> ppp={
                              //       "idd": catnumber,
                              //       "title": selectedcate,
                              //     };
                              //
                              //
                              //
                              //     if(catnumber=='notnumber'){
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(builder: (context) => newsall(pp: ppp,))
                              //       );
                              //     //  Alert(context: context, title: "", desc: "select category first.").show();
                              //
                              //     }else{
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(builder: (context) => newsall(pp: ppp,))
                              //       );
                              //     }
                              //
                              //
                              //   },
                              //   child:  Text('View All..'.tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color),),
                              //
                              // ),),
                              SizedBox(height: 10,)
                            ],
                          ));


                  }

                  }
                  return Center(child: CircularProgressIndicator(),);


                },
            ),

          ],

        ),
      ),
    );
  }
}























// import 'dart:async';
// import 'package:easy_localization/easy_localization.dart';
//
//
// import 'package:flutter/material.dart';
// import 'dart:convert' as convert;
//
//
// import 'package:http/http.dart' as http;
//
// import 'allnews.dart';
// import '../../Model/Categories.dart';
//
// class newscategory extends StatefulWidget {
//   const newscategory({Key? key}) : super(key: key);
//
//   @override
//   _newscategoryState createState() => _newscategoryState();
// }
//
// class _newscategoryState extends State<newscategory> {
//
//   Future<Getcat> getnewscategory() async {
//     print(context.locale);
//     String Url = 'https://studyinrussia.app/api/news/categories?lang='+context.locale.toString();
//     var response = await http.get(
//       Uri.parse(Url),
//     );
//     Getcat getcatFromJson(String str) => Getcat.fromJson(convert.json.decode(response.body));
//     String getcatToJson(Getcat data) => convert.json.encode(data.toJson());
//
//     final getcat = getcatFromJson(response.body);
//
//     print(getcat.message);
//     return getcat;
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future:getnewscategory(),
//         builder: (context,AsyncSnapshot snapshot){
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               {
//                 return Center(child: CircularProgressIndicator(),);
//               }
//             case ConnectionState.done:
//               if (snapshot.hasData) {
//
//                 return ListView.builder(
//                     itemCount: snapshot.data.data.length,
//                     itemBuilder: (context, i){
//                       return ListTile(
//                         focusColor: Colors.amberAccent,
//                         title: Text(snapshot.data.data[i].name.toString()),
//
//                         onTap: (){
//                           //  final String xx = snapshot.data.data[i].id.toString();
//                           //  final List xxx = snapshot.data.data[i];
//                           //  List<Datum> xxxx =   snapshot.data.data[i];
//                           Map<String, dynamic> xxxx={
//                             "id": snapshot.data.data[i].id,
//                             "name": snapshot.data.data[i].name
//                           };
//                           // final Datum xc =snapshot.data.data[i] ;
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => newsall(pp: xxxx))
//                           );
//
//                         },
//                         subtitle: Text('dg',style: TextStyle(color: (snapshot.data.data[i].id<5)? Colors.red:Colors.amber  ),),
//
//                         trailing:IconButton(icon:Icon(Icons.favorite,
//                           color: (snapshot.data.data[i].id<5)? Colors.red:Colors.amber,
//
//                         ),onPressed: ()async{
//
//                         }, ),
//
//
//
//
//                       );
//                     }
//
//                 );
//
//               }
//           }
//           return Center(child: CircularProgressIndicator(),);
//
//
//         },
//       ),
//     );
//   }
// }
