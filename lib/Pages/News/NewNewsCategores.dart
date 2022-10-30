import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
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

import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import 'allnews.dart';
import '../../Model/Categories.dart';
import '../../Model/News.dart';
import '/Vars/globalss.dart' as globalss;
import 'newallnews.dart';
import 'newnewsdetails.dart';
import 'newsDetails.dart';

class newnewscategory extends StatefulWidget {
  const newnewscategory({Key? key}) : super(key: key);

  @override
  _newnewscategoryState createState() => _newnewscategoryState();
}

class _newnewscategoryState extends State<newnewscategory> {




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



      body: Padding(
        padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*15/375,left:  MediaQuery.of(context).size.width*15/375,bottom:  8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:  EdgeInsets.only(bottom: 1,top: 10),
                child:Row(
                  //crossAxisAlignment: CrossAxisAlignment.,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/5, maxWidth: MediaQuery.of(context).size.width*(70/100)),

                        child: FittedBox(child: Text("drawer.Latest News".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*(20/100),
                      child: FittedBox(
                        child: TextButton( 
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
                                  MaterialPageRoute(builder: (context) => newnewsall(pp: ppp,))
                              );
                              //  Alert(context: context, title: "", desc: "select category first.").show();

                            }else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => newnewsall(pp: ppp,))
                              );
                            }


                          },
                          child:  Text('View All..'.tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 13,),),

                        ),
                      ),
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
                       //   SizedBox(width: 15,),
                          SizedBox(height: 60,),

                         // SizedBox(width: 2,),
                          Expanded(
                            child:Container(
                              height: 40,
                              child: ListView.builder(

                                shrinkWrap: false,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (context, i){
                                  //selectedtocolored = dataa[i].inCurrentUserFavorite;

                                  // var coloor =(selectedtocolored == i)?Colors.blue : Colors.red;
                                  var coloor =(selectedtocolored == i)?globalss.cblue : (Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Color(0xFFDFDFDF):Color(0xFF383838);
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
                                              child: Text(
                                                snapshot.data.data[i].name,
                                                style: TextStyle(
                                                    color:(coloor==globalss.cblue)?Colors.white:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? Color(0xFF505050):Colors.white,
                                                    fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },


                              ),
                            ),),
                          //SizedBox(width: 15,),
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
                              Expanded(
                                  child:(snapshot.data.data.length>0)?
                                  ListView.separated(
                                    padding:EdgeInsets.only(top: 5),

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
                                          )

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





















