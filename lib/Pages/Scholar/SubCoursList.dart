import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/SubCourses.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';



import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';




class subcoursesList extends StatefulWidget {

  subcoursesList({Key? key}) : super(key: key);


  @override
  _subcoursesListState createState() => _subcoursesListState();
}



class _subcoursesListState extends State<subcoursesList> {

  bool colorbool = false;

  Icon customIcon =  Icon(Icons.search,size: 60,);
  Widget customSearchBar = const Text('My Personal Journal');

  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> dataa = [];
  //var completer =[] ;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;





  Future<bool> getSubCourses({required bool isRefresh}) async {



    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';

    if(globalss.unids.isNotEmpty && globalss.Degreeids.isNotEmpty  && globalss.Courseids.isNotEmpty){
      Url = 'https://studyinrussia.app/api/scholar/sub_courses?course=${globalss.Courseids}&university=${globalss.unids}&degree=${globalss.Degreeids}&lang=${context.locale.toString()}&page=$currentPage';
      print(Url);
    }
    else if(globalss.unids.isNotEmpty && globalss.Degreeids.isEmpty&& globalss.Courseids.isEmpty ){
      Url = 'https://studyinrussia.app/api/scholar/sub_courses?university=${globalss.unids.toString()}&lang=${context.locale.toString()}&page=$currentPage';
    print(Url);
    }else{
Url = 'url  null';
print(Url);
    }






    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},
    );


    GetSubCorseList getSubCorseListFromJson(String str) => GetSubCorseList.fromJson(convert.json.decode(response.body));
    final getSubCorseList = getSubCorseListFromJson(response.body);
    print(getSubCorseList.message);


    if (response.statusCode == 200) {
      GetSubCorseList getSubCorseListFromJson(String str) => GetSubCorseList.fromJson(convert.json.decode(response.body));
      final getSubCorseList = getSubCorseListFromJson(response.body);

      if (isRefresh) {
        dataa = [];
        dataa = getSubCorseList.data;
      }else {
        if(currentPage <= totalPages){
          dataa.addAll(getSubCorseList.data);
        }
      }



      totalPages =(getSubCorseList.pagination.totalItems / 10).round();
      if ((totalPages * 10) < getSubCorseList.pagination.totalItems) {
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

  Future favorite({required String idsc} ) async {
    var map = new Map<String, dynamic>();
    map['subcourse'] = idsc;
    String Urlf = 'https://studyinrussia.app/api/scholar/favorite/add/subcourse';
    final responsef = await http.post(
        Uri.parse(Urlf),
        headers: {"Authorization": "bearer "+globalss.tokenfromserver},
        body: map
    );
    print(convert.jsonDecode(responsef.body));
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
      endDrawer:MyDrawer(),
      appBar:PreferredSize(

        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          centerTitle: true,

          flexibleSpace: Container(

            decoration:
            BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 4,
                  color: Colors.black26,
                  offset: Offset(0, 0),
                  blurRadius: 5,
                )
              ],
              image: DecorationImage(
                image: AssetImage('assets/image/appbar.jpg'),
                fit: BoxFit.fill,


              ),
            ),
          ),
          backgroundColor: Colors.transparent,

          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[

              Flexible(
                child: IconButton (
                  icon: Icon(Icons.search),
                  onPressed: () {

                  },
                ),
              ),
              // SizedBox(width: 15.0,),


            ],
          ),
          title: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  // TextFormField(
                  //   // decoration: const InputDecoration(
                  //   //    // border: UnderlineInputBorder(),
                  //   //   //  labelText: 'Enter your username'
                  //   // ),
                  // ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //
                  //       hintText: 'Search',
                  //       prefixIcon: Icon(Icons.search)
                  //   ),
                  // ),
                  Text("STUDY IN RUSSIA",)

                ],
              )

              // Positioned(child: Text("STUDY IN RUSSIA",)),
            ],
          ),






        ),
      ),
      bottomNavigationBar:myBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab? new FloatingActionButton(
        backgroundColor:Theme.of(context).primaryColor,
        shape:  BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PreChatPage()));
        },
        child:Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
      ):null,
      body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: true,
          onRefresh: () async {
            bool result = await getSubCourses(isRefresh: true);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },

          onLoading:() async {
            //           final result = await getPassengerData();

            bool result = await getSubCourses(isRefresh: false);

            //  await getNews();
            if (result){
              refreshController.loadComplete();
            } else {
              refreshController.loadFailed();
            }
          },
          child:(dataa.isNotEmpty)? ListView.separated(

            padding: const EdgeInsets.only(top: 15.0),

            itemBuilder: (context, i){
              var dataaa = dataa[i];

              colorbool = dataa[i].inCurrentUserFavorite;

              var coloor =(colorbool)?Colors.red : Colors.grey;

              return Padding(
                padding: const EdgeInsets.only(left:30 ,right: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                   color:  Theme.of(context).primaryColor,
                    boxShadow:[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]
                  ),


                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: 100,
                                height: 40,
                                child: Text(dataaa.name.toString(),style: TextStyle( fontWeight: FontWeight.bold),)),
                             SizedBox(height: 30,child: VerticalDivider(color: Colors.red,thickness: 1,),),

                            Container(
                              width: 100,
                              //height: 50,
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF170AEA)
                              ) ,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(dataaa.language,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),maxLines:4,),
                              ),
                            )
                            // SizedBox(
                            //     height: 30,
                            //     width: 60,
                            //     child: ColoredBox(color: Colors.blue)),
                            // SizedBox(
                            //     height: 30,
                            //     width: 99,
                            //     child: ColoredBox(color: Colors.red)),
                          ],
                        ),
                       // Padding(padding: Padding.)
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15 ,top: 10,bottom: 2),
                          child: Container(
                            height: 20,
                            child: Text("Total Course Fees",),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15 ,top: 1,bottom: 5),
                          child: Container(

                            height: 40,
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                             color: Colors.white,
                               boxShadow:[
                               BoxShadow(
                               color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                            ],
                           ),
                            child: Center(child: Text(dataaa.fees.toString(),style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap:(){
//new un line
                                  // globalss.SubCourseids=dataaa.id.toString();
                                  //
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => MyApp50()),
                                  // );

                                },
                                child: Container(
                                  height: 30,
                                 // width: 150,

                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue,
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(" APPLY ",style: TextStyle(color: Colors.white),),
                                  ) ,
                                ),
                              ),

                              Container(
                                height: 30,
                               // width: 150,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                  color: Colors.black12,
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("More Information"),
                                ) ,
                              ),
                              IconButton(
                                onPressed: ()async{
                                  await favorite(idsc: dataaa.id.toString());

                                  // setState((){
                                  //   if(dataaa.inCurrentUserFavorite){
                                  //     dataaa.inCurrentUserFavorite  = false;
                                  //   }else{
                                  //     dataaa.inCurrentUserFavorite  = true;
                                  //   }
                                  // });
                                  setState((){
                                    if(dataaa.inCurrentUserFavorite){
                                      dataaa.inCurrentUserFavorite  = false;
                                    }else{
                                      dataaa.inCurrentUserFavorite  = true;
                                    }
                                  });


                                },
                                icon:Icon(Icons.favorite,color:coloor,),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),


                ),
              );



              //   ListTile(
              //   focusColor: Colors.amberAccent,
              //   title: Text(dataaa.name.toString()),
              //   subtitle:Text(dataaa.id.toString()+dataaa.content.toString()) ,
              //   isThreeLine: true,
              //
              //
              //   onTap: (){
              //
              //   },
              // );
            },
            separatorBuilder: (context, i) => Divider(),

            itemCount: dataa.length,

          ) : Center(child: Text("there is no sub courses now",style: TextStyle(fontSize:25 ),))
      ),
    );
  }
}

