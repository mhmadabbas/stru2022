
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:stru2022/Model/UnDetails.dart';
import 'package:stru2022/Pages/Scholar/vimeoPlayer.dart';
import 'package:stru2022/mywidget/drawer.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

class UnversityDetailsVideo extends StatefulWidget {


  UnversityDetailsVideo({Key? key}) : super(key: key);

  @override
  _UnversityDetailsVideoState createState() => _UnversityDetailsVideoState();
}

class _UnversityDetailsVideoState extends State<UnversityDetailsVideo> {
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

      for(int i = 0; i < undetails.data.videos.length; i++){
        listurls.add(undetails.data.videos[i].link.toString());
        print(listurls);
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

                                Text("uninfo.Video Gallery".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                              ],
                            )
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*(30/375) ,right:MediaQuery.of(context).size.width*(30/375)),
                          child: Text(snapshot.data.data.name.toString(),style:TextStyle(fontSize: 16,)),
                        ),


                        SizedBox(
                          height: MediaQuery.of(context).size.height/1.5,
                          child: ListView.builder(
                              itemCount: listurls.length,
                              itemBuilder: (context, i){

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height:350,
                                      //width: 40,

                                      decoration: BoxDecoration(
                                          color:  Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              color: Colors.black26,
                                              offset: Offset(0, 0),
                                              blurRadius: 1,
                                            )
                                          ]
                                      ),

                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text("Video "+(i+1).toString()),
                                              trailing:Icon(Icons.ondemand_video_rounded ) ,
                                              // subtitle:
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => vimo()),
                                                );
                                              },
                                            ),
                                            Container(
                                              height: 250,
                                              child: VimeoPlayer(
                                                videoId:listurls[i].split('/').last,

                                                //.split('/').last
                                              ),),
                                          ],
                                        ),
                                      )
                                    //Text(globalss.UrlImageuniversityy2+listurls[i].toString()),
                                  ),
                                );
                              }
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
