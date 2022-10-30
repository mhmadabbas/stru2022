import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_html/flutter_html.dart';
import 'package:stru2022/Model/UnDetails.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';
import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;



class UnversityDetailsImages extends StatefulWidget {


  UnversityDetailsImages({Key? key}) : super(key: key);

  @override
  _UnversityDetailsImagesState createState() => _UnversityDetailsImagesState();
}

class _UnversityDetailsImagesState extends State<UnversityDetailsImages> {
  List<Media>  imagelist=[];
  late List<String> listurls ;


   Future<UnDetails?> getundetails() async{
    String Url = 'https://studyinrussia.app/api/scholar/university/${globalss.unids}?lang=${context.locale.toString()}';

    final response = await http.get(
      Uri.parse(Url),
    );

    if (response.statusCode == 200) {



      UnDetails unDetailsFromJson(String str) => UnDetails.fromJson(convert.json.decode(response.body));

      final undetails = unDetailsFromJson(response.body);
      imagelist = [];
      listurls = [];
      for(int i = 0; i < undetails.data.media.length; i++){
      listurls.add(undetails.data.media[i].path.toString());
   // print(listurls);
      }

      return undetails;
    }else{
      return null;
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


        body:FutureBuilder(
          future:getundetails() ,
          builder: (context,AsyncSnapshot snapshot){

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return Center(child: CircularProgressIndicator(),);
                }
              case ConnectionState.done:
                if (snapshot.hasData) {
                  // List<String> wew = [];
                  // wew = wew.addAll(imagelist.path.toString());

                  return SingleChildScrollView(
                    child: Column(
                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Padding(
                            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(27/375) ,left:MediaQuery.of(context).size.width*(11/375) ,right:MediaQuery.of(context).size.width*(11/375) ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back)
                                ),

                                Text("uninfo.Photo Gallery".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                              ],
                            )
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*(30/375) ,right:MediaQuery.of(context).size.width*(30/375)),
                          child: Text(snapshot.data.data.name.toString(),style:TextStyle(fontSize: 16,)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/1.5,
                          child: ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                child:(listurls.length==0)?SizedBox():

                                CarouselSlider.builder(
                                  itemCount: listurls.length,
                                  options: CarouselOptions(
                                    enlargeCenterPage: true,
                                  //  height: MediaQuery.of(context).size.height-200,
                                    height: MediaQuery.of(context).size.height/1.5 -50,
                                    autoPlay: false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    reverse: false,
                                    aspectRatio: 5.0,
                                  ),
                                  itemBuilder: (context, i, id){
                                    //for onTap to redirect to another screen
                                    return GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: Colors.white,)
                                        ),
                                        //ClipRRect for image border radius
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(
                                            globalss.UrlImageuniversityy2+listurls[i].toString(),
                                            width: MediaQuery.of(context).size.width-50,

                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        var url = listurls[i];
                                        print(url.toString());
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
