import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/NewsDetails.dart';
import 'dart:convert' as convert;
import 'package:flutter_html/flutter_html.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;
class newNewsDetails extends StatefulWidget {
  Map<String, dynamic> mapnews;

  newNewsDetails({Key? key,required this.mapnews}) : super(key: key);

  @override
  _newNewsDetailsState createState() => _newNewsDetailsState();
}

class _newNewsDetailsState extends State<newNewsDetails> {

  Future<GetNewsDetails?> getnewsdetails() async{
    String Url = 'https://studyinrussia.app/api/news/${widget.mapnews["id"]}?lang=${context.locale.toString()}';

    final response = await http.get(
      Uri.parse(Url),
    );
    // GetNewsDetails getNewsDetailsFromJson(String str) => GetNewsDetails.fromJson(convert.json.decode(response.body));
    // final getnewsdetails = getNewsDetailsFromJson(response.body);
    if (response.statusCode == 200) {
      GetNewsDetails getNewsDetailsFromJson(String str) =>
          GetNewsDetails.fromJson(convert.json.decode(response.body));
      final getnewsdetails = getNewsDetailsFromJson(response.body);
      return getnewsdetails;
    }else{
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
        // endDrawer: MyDrawer(),
        // appBar:ApplicationToolbarnosearch(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        leading: BackButton(

        color: Colors.white,
    ),

        ),
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


        body:FutureBuilder(
          future:getnewsdetails() ,
          builder: (context,AsyncSnapshot snapshot){

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return Center(child: CircularProgressIndicator(),);
                }
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return Container(
                    color: Theme.of(context).primaryColor,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                height: MediaQuery.of(context).size.width*231/375,
                                imageUrl: globalss.UrlImagenews+snapshot.data.data.media.toString(),
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
                                bottom: 50,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                                    child: Text(snapshot.data.data.title.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),maxLines: 3),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                                  child:
                                  Text(snapshot.data.data.publishTime.date.toString().substring(0, 10),style: TextStyle(fontSize: 15,color:Colors.white),),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10,),


                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8,top: 8,bottom: 20),
                            child: Html(data: snapshot.data.data.content ,

                              style: {
                                "p": Style(color:Theme.of(context).textTheme.headline5!.color,),
                              "body": Style(
                              fontSize: FontSize(18.0),)


                              } ,
                            ),

                          ),

                        ],
                      ),
                    ),
                  );


                }
            }
            return Center(child: CircularProgressIndicator(),);

          },
        )

    );
  }
}
