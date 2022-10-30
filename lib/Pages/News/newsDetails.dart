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
import '/Vars/globalss.dart' as globalss;
class NewsDetails extends StatefulWidget {
  Map<String, dynamic> mapnews;

   NewsDetails({Key? key,required this.mapnews}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

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
      endDrawer: MyDrawer(),
        appBar:ApplicationToolbarnosearch(),

        bottomNavigationBar:myBottomAppBar(),


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
              CachedNetworkImage(
                height: 150,
                imageUrl: globalss.UrlImagenews+snapshot.data.data.media.toString(),
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
                      fit: BoxFit.fill,
                    ),

                  ),
                ),
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              //Text(snapshot.data.data.id.toString()),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                   //crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // Container(
                        //     height: 60,
                        //     width: 60,
                        //     child: SvgPicture.asset('assets/SVG_ICONS/NEWS.svg',color:Theme.of(context).textTheme.headline2!.color ,fit:BoxFit.cover ,)),
                        Text(snapshot.data.data.category.name.toString(),style: TextStyle(fontSize: 22,color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),),
                      ],
                    ),


                    Text(snapshot.data.data.publishTime.date.toString().substring(0, 10),style: TextStyle(fontSize: 15,color:Theme.of(context).textTheme.headline1!.color),),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Text(snapshot.data.data.title.toString(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8,top: 8,bottom: 20),
                child: Html(data: snapshot.data.data.content ,
                  style: {
                  "p": Style(color:Theme.of(context).textTheme.headline5!.color,),

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
