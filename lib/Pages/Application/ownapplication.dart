import 'dart:async';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/mywidget/drawer.dart';
import '../../Model/OwnApplication.dart';
import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../Scholar/degreeList.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'appMessages.dart';
import 'applicationinfo.dart';





class ownapp extends StatefulWidget {

  ownapp({Key? key}) : super(key: key);


  @override
  _ownappState createState() => _ownappState();
}



class _ownappState extends State<ownapp> {

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


  Future cancelapp({required String idapp} ) async {

    String Urlf = 'https://studyinrussia.app/api/scholar/application/cancel';
    print(Urlf);
    final responsef = await http.post(
      Uri.parse(Urlf),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},
      body: {"application":idapp}

    );
    print(responsef.body);



  }


  Future<bool> getPosts({required bool isRefresh}) async {

    if (isRefresh) {
      currentPage = 1;
    }


    String Url = 'https://studyinrussia.app/api/scholar/applications/list?page=$currentPage';

    print(Url);
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},
    );

    OwnApplication ownApplicationFromJson(String str) => OwnApplication.fromJson(convert.json.decode(response.body));
    final ownApplication = ownApplicationFromJson(response.body);
    if (response.statusCode == 200) {
      OwnApplication ownApplicationFromJson(String str) => OwnApplication.fromJson(convert.json.decode(response.body));
      final ownApplication = ownApplicationFromJson(response.body);
      if (isRefresh) {
        dataa = [];
        dataa = ownApplication.data;
      }else{
        if(ownApplication.data.length > 0) {
          dataa.addAll(ownApplication.data);
        }
      }
      totalPages =(ownApplication.pagination.totalItems / 10).round();
      if ((totalPages * 10) < ownApplication.pagination.totalItems) {
        totalPages=totalPages+1;
      }else{
        totalPages=1;
      }
      currentPage++;

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


        body:Padding(
          padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width *(15/375) ,right:MediaQuery.of(context).size.width *(15/375),top:MediaQuery.of(context).size.width *(15/375)  ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:  EdgeInsets.only(bottom:MediaQuery.of(context).size.width*(15/375) ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)
                      ),
                      Text("ownapplication.My applications".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                    ],
                  )
              ),

              Expanded(
                child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: true,
                    enablePullDown: true,
                    onRefresh: () async {
                       result = await getPosts(isRefresh: true);
                      if (result) {
                        refreshController.refreshCompleted();
                      } else {
                        refreshController.refreshFailed();
                      }
                    },
                    onLoading: () async {

                       result = await getPosts(isRefresh: false);


                      if (result) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadFailed();
                      }
                    },
                    child:

                  (!result&&dataa.length==0)? SizedBox(height: 10,):
                  (result&&dataa.length>0)? ListView.separated(
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (context, i) {
                      final dataaa = dataa[i];
                      //colorbool = dataaa.subCourse.inCurrentUserFavorite;
                      //
                      // var coloor =
                      // (colorbool) ? Colors.blueAccent : Colors.grey;
                      return Dismissible(

                        key: Key(dataaa.id.toString()),
                        background: Container(
                          width: 50,
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          color: Colors.red
                      ),
                          child: Center(
                            child: Icon(Icons.delete),
                          ),


                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {

                      //    Alert(context: context, image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "Invalid Email Address.".tr()).show();
                        return;
                          // setState(() {
                          //   dataa.removeAt(i);
                          // });
                          // Scaffold
                          //     .of(context)
                          //     .showSnackBar(SnackBar(content: Text("dismissed")));
                        },
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            //final bool res =
                            await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(

                                    shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                                    title: Row(
                                      children: [
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                    content: Text(
                                        "ownapplication.Are you sure you want to delete this application?".tr(),
                                      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold),

                                    ),
                                    actions: <Widget>[

                                      SizedBox(
                                        height: MediaQuery.of(context).size.width*(30/375),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex:2,
                                              child: ElevatedButton(onPressed: ()async {
                                                //  print("hello");
                                                Navigator.of(context, rootNavigator: true).pop();
                                                //  print(dataaa.id.toString());
                                                await  cancelapp(idapp:dataaa.id.toString());
                                                await getPosts(isRefresh: true);

                                              },
                                                child:  SizedBox(
                                                    // width:
                                                    // MediaQuery.of(context).size.width *(144/375),
                                                    child: Center(child: Text("ownapplication.Delete".tr()))),

                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFF2429F9),//change background color of button
                                                  // onPrimary: Colors.yellow,//change text color of button
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  elevation: 0,

                                                ),


                                              ),
                                            ),
                                            SizedBox(width:MediaQuery.of(context).size.width*(10/375) ,),
                                            Flexible(
                                              flex:2,
                                              child: ElevatedButton(onPressed: () {
                                                Navigator.pop(context);


                                              },
                                                child:  SizedBox(
                                                    // width:
                                                    // MediaQuery.of(context).size.width *(144/375),
                                                    child: Center(child: Text("ownapplication.Cancel".tr(),style: TextStyle(color: Colors.black),))),

                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFFDFDFDF),//change background color of button
                                                  // onPrimary: Colors.yellow,//change text color of button
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  elevation: 0,

                                                ),


                                              ),
                                            ),
                                          ],
                                        ),
                                      )


                                    ],
                                  );
                                });
                           // return res;
                          } else {
                            // TODO: Navigate to edit page;
                          }
                        },



                        child: Container(
                          //height: 140,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),

                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(MediaQuery.of(context).size.width*(16/375)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    (dataaa.status.toString()=="0")?

                                        Container(
                                          height:  MediaQuery.of(context).size.width*(23/375),
                                          decoration: BoxDecoration(
                                            color:Colors.black.withOpacity(0.3),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),

                                            ),

                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 8.0,right: 8),
                                            child: Center(child: Text("ownapplication.new".tr(),style: TextStyle(fontSize: 16,color: Colors.white),)),
                                          ),

                                        )


                                        :


                                    (dataaa.status.toString()=="1")?
                                    Container(
                                      height:  MediaQuery.of(context).size.width*(23/375),
                                      decoration: BoxDecoration(
                                        color:globalss.cblue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),

                                        ),

                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 8.0,right: 8),
                                        child: Center(child: Text("ownapplication.seen".tr(),style: TextStyle(fontSize: 16,color: Colors.white),)),
                                      ),

                                    )
                                        :
                                    (dataaa.status.toString()=="2")?
                                    Container(
                                      height:  MediaQuery.of(context).size.width*(23/375),
                                      decoration: BoxDecoration(
                                        color:Colors.green,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),

                                        ),

                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 8.0,right: 8),
                                        child: Center(child: Text("ownapplication.under review".tr(),style: TextStyle(fontSize: 16,color: Colors.white),)),
                                      ),

                                    )
                                        :
                                    (dataaa.status.toString()=="3")?  Container(
                                      height:  MediaQuery.of(context).size.width*(23/375),
                                      decoration: BoxDecoration(
                                        color:Colors.purpleAccent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),

                                        ),

                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 8.0,right: 8),
                                        child: Center(child: Text("ownapplication.processed".tr(),style: TextStyle(fontSize: 16,color: Colors.white),)),
                                      ),

                                    ):
                                    SizedBox(),


                                    Text(dataaa.createTime.date.substring(0,16))




                                  ],
                                ),
                                SizedBox(height:MediaQuery.of(context).size.width*(16/375) ,),

                                Text("subCourse.name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyText1!.color)),

                                SizedBox(height:MediaQuery.of(context).size.width*(16/375) ,),






                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),

                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(3.0),
                                    child: Row(

                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [


                                        //more info
                                        Flexible(
                                          flex:2,
                                          child: ElevatedButton(onPressed: () {
                                            Map<String, dynamic> mapapp={
                                              "id": dataaa.id,
                                              "name": dataaa.subCourse.name,
                                              "content": dataaa.subCourse.content,
                                              "degree":dataaa.subCourse.degree.name,
                                              "university":dataaa.subCourse.university.name,
                                              "city":dataaa.subCourse.university.city.name,
                                              "fees":dataaa.subCourse.fees,
                                              "course":dataaa.subCourse.course.name,

                                              "language":dataaa.subCourse.language,
                                              "level":dataaa.subCourse.level,
                                              "documents":dataaa.documents,




                                            };
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => applicationinfo(mapapp:mapapp ,)),
                                            );

                                          },
                                            child:  SizedBox(
                                              // width:
                                              // MediaQuery.of(context).size.width *(144/375),
                                                child: Center(child: Text("Show more".tr()))),

                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFF2429F9),//change background color of button
                                              // onPrimary: Colors.yellow,//change text color of button
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              elevation: 0,

                                            ),


                                          ),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*(10/375) ,),


                                        //app messages

                                        Flexible(
                                          flex:2,
                                          child: ElevatedButton(onPressed: () {

                                            globalss.ownappids=dataaa.id.toString();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => appMessages()),
                                            );

                                          },
                                            child:  SizedBox(
                                              // width:
                                              // MediaQuery.of(context).size.width *(144/375),
                                                child: Center(child: Text("ownapplication.messages".tr()))),

                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFF2429F9),//change background color of button
                                              // onPrimary: Colors.yellow,//change text color of button
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              elevation: 0,

                                            ),


                                          ),
                                        ),





                                      ],
                                    ),
                                  ),
                                )
                              ],

                            ),
                          ),
                        ),
                      );

                    },
                    separatorBuilder: (context, i) => Divider(),

                    itemCount: dataa.length,

                  ):
                  (result&&dataa.length==0)?
                  Center(child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("home.Find out more".tr()),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => degreeList()));
                      }, child: Text('drawer.Find Courses'.tr()))
                    ],
                  ),

                  )
                      :
                  SizedBox(height: 10,),

                ),
              ),
            ],
          ),
        )
    );
  }
}

