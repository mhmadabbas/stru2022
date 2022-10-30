import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/ApplicationMessages.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';
import 'package:stru2022/mywidget/myFloatingActionButton.dart';



import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';






class appMessages extends StatefulWidget {

  appMessages({Key? key}) : super(key: key);


  @override
  _appMessagesState createState() => _appMessagesState();
}



class _appMessagesState extends State<appMessages> {

  bool colorbool = false;


  Icon customIcon =  Icon(Icons.search,size: 60,);
  Widget customSearchBar = const Text('My Personal Journal');

  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> dataa = [];

  List<Datum> alpostclass = [];
  //var completer =[] ;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;

  bool result=false;




  Future<bool> getmessages({required bool isRefresh}) async {

    if (isRefresh) {
      currentPage = 1;
    }
    String Url = "";
    if(globalss.ownappids!=""){
      Url = 'https://studyinrussia.app/api/scholar/applications/messages?application=${globalss.ownappids}&page=$currentPage';

    }else{
     Url = 'https://studyinrussia.app/api/scholar/applications/messages?page=$currentPage';

    }


    print(Url);
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},
    );


    ApplicationMessages applicationMessagesFromJson(String str) => ApplicationMessages.fromJson(convert.json.decode(response.body));
    final applicationMessages = applicationMessagesFromJson(response.body);

    // print(getposts.message);


    if (response.statusCode == 200) {
      ApplicationMessages applicationMessagesFromJson(String str) => ApplicationMessages.fromJson(convert.json.decode(response.body));
      final applicationMessages = applicationMessagesFromJson(response.body);


      if (isRefresh) {
        dataa = [];
        dataa = applicationMessages.data;
      }else{
        if(applicationMessages.data.length > 0) {
          dataa.addAll(applicationMessages.data);
        }
      }

      totalPages =(applicationMessages.pagination.totalItems / 10).round();
      if ((totalPages * 10) < applicationMessages.pagination.totalItems) {
        totalPages=totalPages+1;
      }else{
        totalPages=1;
      }

      currentPage++;

      setState(() {});
      // setState(() {});
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

            SizedBox(height: MediaQuery.of(context).size.width*(8/375),),
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
                  color:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Colors.grey:Colors.white,
                  //Theme.of(context).textTheme.bodyText2!.color,
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

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)
                ),
                Container(

                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/5, maxWidth: MediaQuery.of(context).size.width*(70/100)),
                    child:
                    FittedBox(child:
                    Text("ownapplication.Application Messages".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),maxLines: 1,))),


              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.width *(10/375)),

            Expanded(
              child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () async {
                     result = await getmessages(isRefresh: true);
                    if (result) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },
                  onLoading: () async {
//           final result = await getPassengerData();

                     result = await getmessages(isRefresh: false);

//  await getNews();
                    if (result) {
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  },
                  child:

                    (!result&&dataa.length==0)? SizedBox(height: 10,):
                  (result&&dataa.length>0)?ListView.separated(
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (context, i) {
                      final dataaa = dataa[i];

                      var coloor =
                      (colorbool) ? Colors.blueAccent : Colors.grey;
                      return Padding(
                        padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                        child: Container(
                          // height:80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start ,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListTile(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                                visualDensity:
                                VisualDensity(horizontal: 4, vertical: 4),
                                dense: true,

                                hoverColor: Colors.red,
// minLeadingWidth: 120,
                                focusColor: Colors.amberAccent,
                                title: Text(
                                  dataaa.sender.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start ,

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataaa.createTime.date.toString().substring(0, 10)+" "+ dataaa.createTime.date.toString().substring(10, 16),
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.blueAccent),
                                    ),

                                    Text(dataaa.message.toString()),

                                  ],
                                ),

                                leading:Icon(Icons.message),


                                onTap: () {



                                },

                              ),
                            ],

                          ),
                        ),
                      );

                    },
                    separatorBuilder: (context, i) => Divider(),

                    itemCount: dataa.length,

                  ):
                  (result&&dataa.length==0)?
                  Center(child:Text("No messages here yet.."),)
                      :
                  SizedBox(height: 10,),

              ),
            ),
          ],
        )
    );
  }
}

