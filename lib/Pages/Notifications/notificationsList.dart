import 'dart:async';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/drawer.dart';

import '../../mywidget/botombarnew.dart';
import '../home.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;
import '../../Model/notifications/notifications.dart';

class notificationslist0 extends StatefulWidget {
  const notificationslist0({Key? key}) : super(key: key);

  @override
  _notificationslist0State createState() => _notificationslist0State();
}

class _notificationslist0State extends State<notificationslist0> {
  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> dataa = [];
  bool result=false;

  Future<bool> getnoti({required bool isRefresh}) async {
   // print(context.locale);
    if (isRefresh) {
      currentPage = 1;
    }


    String Url = 'https://studyinrussia.app/api/notifications?page=$currentPage';
    var response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );


print(Url);

    if (response.statusCode == 200) {
      GetnotificationsList getnotificationsListFromJson(String str) => GetnotificationsList.fromJson(convert.json.decode(response.body));

      final notification0 = getnotificationsListFromJson(response.body);
    if (isRefresh) {
      dataa = [];
      dataa = notification0.data;
    }else {
      if(currentPage <= totalPages){
        dataa.addAll(notification0.data);
      }
    }



    totalPages =(notification0.pagination.totalItems / 10).round();
    if ((totalPages * 10) < notification0.pagination.totalItems) {
      totalPages=totalPages+1;
    }else{
      totalPages=1;
    }

    if(currentPage <= totalPages){
      currentPage++;
    }
    setState(() {});
    return true;
    }else{
      print("some error not 200");
      return false;
    }

  }
  final RefreshController refreshController = RefreshController(initialRefresh: true);
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
          children: [
            Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(27/375) ,left:MediaQuery.of(context).size.width*(11/375) ,right:MediaQuery.of(context).size.width*(11/375) ),
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

                    Text("newlandingPage.Notifications".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                  ],
                )
            ),
            Expanded(
              child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () async {
                     result = await getnoti(isRefresh: true);
                    if (result) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },
                  onLoading: () async {
                     result = await getnoti(isRefresh: false);

                    //  await getNews();
                    if (result) {
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  },
                  child:
                  (result&&dataa.length==0)? Text("empty"):

                  (result&&dataa.length>0)?ListView.separated(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, i) {
                      final dataaa = dataa[i];
                      return Container(
                        margin: EdgeInsets.only(right:  MediaQuery.of(context).size.width *(15/375), left:  MediaQuery.of(context).size.width *(15/375),),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              //offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 7.0),
                          focusColor: Colors.amberAccent,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataaa.time.date.toString().substring(0,16),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color,fontSize: 12 ),
                                maxLines: 1,
                              ),
                              Text(
                                dataaa.title.toString(),style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            dataaa.content.toString(),style: TextStyle(fontSize: 12,),
                          ),
                          onTap: () {},
                          isThreeLine: true,
                          leading:Image.asset("assets/22images/rlogo.png",fit: BoxFit.contain,
                              color:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue:Colors.white,

                              height:  MediaQuery.of(context).size.width*(60/375),
                            width: MediaQuery.of(context).size.width*(60/375),

                          ) ,
                        ),
                      );
                    },
                    separatorBuilder: (context, i) => Divider(),
                    itemCount: dataa.length,
                  )
                      :
SizedBox()


              ),
            )
          ],
        )

    );
  }
}
