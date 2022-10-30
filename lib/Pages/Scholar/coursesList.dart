import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/CourseList.dart';
import 'package:stru2022/Pages/Scholar/universities.dart';

import 'package:stru2022/mywidget/drawer.dart';



import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'degreeList.dart';



class CoursesList extends StatefulWidget {

  CoursesList({Key? key}) : super(key: key);


  @override
  _CoursesListState createState() => _CoursesListState();
}



class _CoursesListState extends State<CoursesList> {
  bool issearch = false;
  String searchvalue = '';
  TextEditingController searchvaluecontroller = new TextEditingController();

  Icon customIcon =  Icon(Icons.search,size: 60,);
  Widget customSearchBar = const Text('My Personal Journal');

  int currentPage = 1;
  late int totalPages;
  //GetNews gg= new GetNews(code: currentPage) ;
  List<Datum> dataa = [];
  //var completer =[] ;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;

  bool result = false;



  Future<bool> getCourses({required bool isRefresh}) async {

    searchvalue = searchvaluecontroller.text;


    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';
   // Url = 'https://studyinrussia.app/api/scholar/courses?lang=${context.locale.toString()}&page=$currentPage';
    if(searchvalue!=''){
      Url = 'https://studyinrussia.app/api/scholar/courses?lang=${context.locale.toString()}&page=$currentPage&name=${searchvaluecontroller.text}';
print(Url);
    }else{
      Url = 'https://studyinrussia.app/api/scholar/courses?lang=${context.locale.toString()}&page=$currentPage';
      print(Url);
    }
    final response = await http.get(
      Uri.parse(Url),
    );

    GetCorseList getCorseListFromJson(String str) => GetCorseList.fromJson(convert.json.decode(response.body));

    final getCoursesList = getCorseListFromJson(response.body);

    print(getCoursesList.message);


    if (response.statusCode == 200) {
      GetCorseList getCorseListFromJson(String str) => GetCorseList.fromJson(convert.json.decode(response.body));

      final getCoursesList = getCorseListFromJson(response.body);

      if (isRefresh) {
        dataa = [];
        dataa = getCoursesList.data;
      }else {
        if(currentPage <= totalPages){
          dataa.addAll(getCoursesList.data);
        }
      }



      totalPages =(getCoursesList.pagination.totalItems / 10).round();
      if ((totalPages * 10) < getCoursesList.pagination.totalItems) {
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


  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
      endDrawer:MyDrawer(),
      appBar:ApplicationToolbarnosearch(),



      bottomNavigationBar:myBottomAppBarnew(),
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
         crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: 10,),
            Container(
                height: (MediaQuery.of(context).size.width-40)/4,
                alignment: Alignment.centerLeft,

                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: ListView(



                    scrollDirection:Axis.horizontal,
                    reverse: true,

                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width-40,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image(
                                image: AssetImage(
                                    "assets/22images/scholar/arrow1.png"),
                                fit: BoxFit.fill,
                                matchTextDirection: true,
                              ),
                            ),
                            Positioned.fill(
                                child: Padding(
                                  padding:EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,



                                    children: [
                                      SizedBox(
                                        width:(MediaQuery.of(context).size.width-40)/2,
                                        height:(MediaQuery.of(context).size.width-40)/4 ,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,


                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 35,),
                                                Text("processcourse.select".tr()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                // Icon(Icons.grade,size: 15),
                                                SizedBox(width: 10,),
                                                SvgPicture.asset('assets/22images/scholar/iconcourse.svg',color: Theme.of(context).textTheme.headline1!.color ,fit:BoxFit.cover ,),
                                                SizedBox(width: 2,),
                                                Container(
                                                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/6, maxWidth: MediaQuery.of(context).size.width*(60/100)),
                                                    height: MediaQuery.of(context).size.width*(8/100),
                                                    child: FittedBox(child: Text("processcourse.Course".tr(),style: TextStyle(color:Theme.of(context).textTheme.headline1!.color,fontSize: 30 ,fontWeight: FontWeight.bold ) ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Text("02",style: TextStyle(color:(Theme.of(context).textTheme.headline1!.color==globalss.cblue)?globalss.cblue.withOpacity(0.2):Colors.white.withOpacity(0.2),fontSize: 40 ,fontWeight: FontWeight.bold ),)
                                    ],
                                  ),
                                )
                            )

                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-40,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child:
                              Image(
                                image: AssetImage(
                                    "assets/22images/scholar/arrow.png"),
                                fit: BoxFit.fill,
                                matchTextDirection: true,
                              ),

                            ),
                            Positioned.fill(
                                child: Padding(
                                  padding:EdgeInsets.only(left:MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,



                                    children: [
                                      SizedBox(
                                        width:(MediaQuery.of(context).size.width-40)/2,
                                        height:(MediaQuery.of(context).size.width-40)/4 ,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,


                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 35,),
                                                Text("processcourse.select".tr()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [


                                                SvgPicture.asset('assets/22images/scholar/icondegree.svg',color: Theme.of(context).textTheme.headline1!.color,fit:BoxFit.cover ,),
                                                SizedBox(width: 2,),
                                                Container(
                                                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/6, maxWidth: MediaQuery.of(context).size.width*(60/100)),
                                                  height: MediaQuery.of(context).size.width*(8/100),
                                                  child: FittedBox(
                                                      child: Text("processcourse.Degree".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 30 ,fontWeight: FontWeight.bold ) )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Text("01",style: TextStyle(color:(Theme.of(context).textTheme.headline1!.color==globalss.cblue)?globalss.cblue.withOpacity(0.2):Colors.white.withOpacity(0.2),fontSize: 40 ,fontWeight: FontWeight.bold ),)
                                    ],
                                  ),
                                )

                            )

                          ],
                        ),
                      ),




                    ],
                  ),
                )
            ),


            Padding(
              padding:  EdgeInsets.only(right: 20.0,left: 20,bottom: 5,top: 2),

              child:  TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: searchvaluecontroller,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("Search".tr()),
                      prefixIcon: Icon(Icons.search),
                      floatingLabelBehavior:FloatingLabelBehavior.never),

                  onFieldSubmitted: (value)async{

                    await getCourses(isRefresh: true);

                  }
              ),
            ),

            Expanded(
              child: SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () async {
                   result = await getCourses(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },

                onLoading:() async {
                  //           final result = await getPassengerData();

                   result = await getCourses(isRefresh: false);

                  //  await getNews();
                  if (result){
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadFailed();
                  }
                },
                child:

                (!result&&dataa.length==0)? SizedBox(height: 10,):
                (result&&dataa.length>0)?

                GridView.builder(
                  gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:MediaQuery.of(context).size.width/2,
                      //   childAspectRatio:5/4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                  ),
                  padding:EdgeInsets.all( 8),

                  itemBuilder: (context, i){
                    final dataaa = dataa[i];
                    return  GestureDetector(
                      onTap: (){
                        globalss.uncateforfilter="";
                        globalss.Courseids=dataaa.id.toString();
                        globalss.Fromprossbar='yes';
                        print("Degreeids"+globalss.Degreeids.toString());
                        print("Courseids"+globalss.Courseids.toString());

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => universitiesList()),
                        );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width*(140/375),
                              width: MediaQuery.of(context).size.width*(167/375),
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                //imageUrl: globalss.UrlImagedegree+dataaa.icon.toString(),
                                imageUrl: globalss.UrlImagecourse+dataaa.icon.toString(),
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight:  Radius.circular(10),
                                      topRight:  Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),

                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),


                                  ),
                                ),
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ) ,

                            SizedBox(
                                height: 30,
                                width: MediaQuery.of(context).size.width/2,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(dataaa.name,style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)
                                      ]
                                  ),
                                )
                            ),
                          ],
                        ),





                      )



                    );



                  },


                  itemCount: dataa.length,

                ):
                (result&&dataa.length==0)?
                Center(child:Image.asset("assets/nm/EMPTYPAGE.png",height: 200,width: 200,fit: BoxFit.fill,),)
                    :
                SizedBox(height: 10,),
              ),
            ),


          ],
        ),
    );
  }
}

/////////////////

// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'package:studyinrussia/Model/CourseList.dart';
//
//
//
// import '/Vars/globalss.dart' as globalss;
//
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// import 'package:cached_network_image/cached_network_image.dart';
//
//
//
// class CoursesList extends StatefulWidget {
//
//   CoursesList({Key? key}) : super(key: key);
//
//
//   @override
//   _CoursesListState createState() => _CoursesListState();
// }
//
//
//
// class _CoursesListState extends State<CoursesList> {
//
//   Icon customIcon =  Icon(Icons.search,size: 60,);
//   Widget customSearchBar = const Text('My Personal Journal');
//
//   int currentPage = 1;
//   late int totalPages;
//   //GetNews gg= new GetNews(code: currentPage) ;
//   List<Datum> dataa = [];
//   //var completer =[] ;
//
//   final RefreshController refreshController = RefreshController(initialRefresh: true);
//
//   String UrlImagenews = globalss.UrlImagenews;
//
//
//
//
//
//   Future<bool> getCourses({required bool isRefresh}) async {
//
//
//
//     if (isRefresh) {
//       currentPage = 1;
//     }
//     String Url = '';
//     Url = 'https://studyinrussia.app/api/scholar/courses?lang=${context.locale.toString()}&page=$currentPage';
//     print(Url);
//     final response = await http.get(
//       Uri.parse(Url),
//     );
//
//     GetCorseList getCorseListFromJson(String str) => GetCorseList.fromJson(convert.json.decode(response.body));
//
//     final getCoursesList = getCorseListFromJson(response.body);
//
//     print(getCoursesList.message);
//
//
//     if (response.statusCode == 200) {
//       GetCorseList getCorseListFromJson(String str) => GetCorseList.fromJson(convert.json.decode(response.body));
//
//       final getCoursesList = getCorseListFromJson(response.body);
//
//       if (isRefresh) {
//         dataa = [];
//         dataa = getCoursesList.data;
//       }else {
//         if(currentPage <= totalPages){
//           dataa.addAll(getCoursesList.data);
//         }
//       }
//
//
//
//       totalPages =(getCoursesList.pagination.totalItems / 10).round();
//       if ((totalPages * 10) < getCoursesList.pagination.totalItems) {
//         totalPages=totalPages+1;
//       }else{
//         totalPages=1;
//       }
//
//       if(currentPage <= totalPages){
//         currentPage++;
//       }
//
//
//       print(totalPages);
//       //dataa.addAll(getnews.data);
//       setState(() {});
//       return true;
//     }else{
//       print("some error not 200");
//       return false;
//
//     }
//
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       endDrawer:Drawer(
//
//         child: Container(
//
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   // colors: [Colors.blue, Colors.blueGrey])
//                   colors: [        Color(0xFF170AEA),
//                     Color(0xFF49A9EB),])
//
//           ),
//           child: ListView(
//             physics: BouncingScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//
//
//
//
//
//             children: [
//               //SizedBox(height: 20,),
//
//               CircleAvatar(
//                 // maxRadius: 50.2,
//                 radius: 50.1,
//                 backgroundImage: AssetImage('assets/image/appbar.jpg'),
//                 backgroundColor: Colors.transparent,
//
//               ),
//
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Profile',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/profile.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Applications',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/Applications.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Find Universities',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/university.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Find Courses',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/COURSES.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Broadcast',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/BROADCAST.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Forum',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/FORUM.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('News',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/NEWS.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Terms of Use',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/termsofnews.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               Divider(thickness:1,color: Colors.white,endIndent: 50,indent: 50,),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Favorites',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/Favorites.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('About Us',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/AboutUs.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Chat with team',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/chat.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Contact Us',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/contactus.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                   dense:true ,
//                   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//
//
//                   title: const Text('Logout',style: TextStyle(color: Colors.white)),
//                   leading: Container(
//                     // color: Colors.red,
//
//                       height: 40,
//                       width: 40,
//                       child: SvgPicture.asset('assets/SVG_ICONS/logout.svg',color: Colors.white ,fit:BoxFit.cover ,)),
//
//                   // Icon(Icons.access_alarm),
//
//                   onTap: () {
//                     // Update the state of the app.
//                     // ...
//                   },
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 child: Center(child: Column(children: [
//                   Text("Change Language",style: TextStyle(color: Colors.white,fontSize: 16 ),),
//                   Row(
//                     mainAxisAlignment:MainAxisAlignment.center ,
//                     children: [
//                       TextButton(onPressed:(){ context.locale = Locale('ar','');} , child: Text("عربي",style: TextStyle(color: Colors.white,fontSize: 10 ))),
//                       TextButton(onPressed:(){context.locale = Locale('en','');} , child: Text("English",style: TextStyle(color: Colors.white,fontSize: 10 ))),
//                     ],
//                   )
//
//                 ],)),
//               ),
//               Container(
//                 padding:  EdgeInsets.all(2.0),
//                 child: Center(child: Column(children: [
//                   Text("Please Pick Up a Theme",style: TextStyle(color: Colors.white,fontSize: 16 ),),
//                   Row(
//                     mainAxisAlignment:MainAxisAlignment.center ,
//                     children: [
//                       TextButton(onPressed:(){} , child: Text("Dark",style: TextStyle(color: Colors.white,fontSize: 10 ))),
//                       TextButton(onPressed:(){} , child: Text("light",style: TextStyle(color: Colors.white,fontSize: 10 ))),
//                     ],
//                   )
//
//                 ],)),
//               )
//
//
//
//
//
//             ],
//
//           ),
//         ),
//       ),
//       appBar:PreferredSize(
//
//         preferredSize: Size.fromHeight(75.0),
//         child: AppBar(
//           centerTitle: true,
//
//           flexibleSpace: Container(
//
//             decoration:
//             BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   spreadRadius: 4,
//                   color: Colors.black26,
//                   offset: Offset(0, 0),
//                   blurRadius: 5,
//                 )
//               ],
//               image: DecorationImage(
//                 image: AssetImage('assets/image/appbar.jpg'),
//                 fit: BoxFit.fill,
//
//
//               ),
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//
//           leading: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//             children: <Widget>[
//
//               Flexible(
//                 child: IconButton (
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//
//                   },
//                 ),
//               ),
//               // SizedBox(width: 15.0,),
//
//
//             ],
//           ),
//           title: Stack(
//             alignment: Alignment.center,
//             children: [
//               Column(
//                 children: [
//                   // TextFormField(
//                   //   // decoration: const InputDecoration(
//                   //   //    // border: UnderlineInputBorder(),
//                   //   //   //  labelText: 'Enter your username'
//                   //   // ),
//                   // ),
//                   // TextField(
//                   //   decoration: InputDecoration(
//                   //
//                   //       hintText: 'Search',
//                   //       prefixIcon: Icon(Icons.search)
//                   //   ),
//                   // ),
//                   Text("STUDY IN RUSSIA",)
//
//                 ],
//               )
//
//               // Positioned(child: Text("STUDY IN RUSSIA",)),
//             ],
//           ),
//
//
//
//
//
//
//         ),
//       ),
//       body: SmartRefresher(
//         controller: refreshController,
//         enablePullUp: true,
//         enablePullDown: true,
//         onRefresh: () async {
//           bool result = await getCourses(isRefresh: true);
//           if (result) {
//             refreshController.refreshCompleted();
//           } else {
//             refreshController.refreshFailed();
//           }
//         },
//
//         onLoading:() async {
//           //           final result = await getPassengerData();
//
//           bool result = await getCourses(isRefresh: false);
//
//           //  await getNews();
//           if (result){
//             refreshController.loadComplete();
//           } else {
//             refreshController.loadFailed();
//           }
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//
//           children: [
//             SizedBox(height: 10,),
//             Flex(direction: Axis.horizontal,
//               children: [
//                 Expanded(child:
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//
//
//                     Column(
//                       children: [
//                         Container(
//                           height: 20,
//                           width: 110,
//
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadiusDirectional.circular(12),
//                             color: Colors.black12,
//                           ),
//                           child: Center(child: Text("1",style: TextStyle(color: Color(0xFF170AEA),fontWeight: FontWeight.bold,fontSize: 17),)),
//                         ),
//                         SizedBox(height: 5,),
//                         Container(
//                           height: 50,
//                           width: 110,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadiusDirectional.circular(12),
//                             color: Colors.black12,
//                           ),
//                           child: Center(child: Text("1")),
//
//
//                         ),
//                         SizedBox(height: 10,),
//                       ],
//                     ),
//
//                     GestureDetector(
//                       onTap: (){print("ok clickeed");},
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 20,
//                             width: 110,
//
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadiusDirectional.circular(12),
//                               color:  Colors.black12,
//                             ),
//                             child: Center(child: Text("2")),
//                           ),
//                           SizedBox(height: 5,),
//                           Container(
//                             height: 50,
//                             width: 110,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadiusDirectional.circular(12),
//                               color: Colors.black12,
//                             ),
//                             child: Center(child: Column(
//                               //  crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//
//                                 Text("select"),
//                                 Text("un please")
//                               ],
//                             )),
//
//
//                           ),
//                           SizedBox(height: 10,),
//                         ],
//                       ),
//                     ),
//
//                     Column(
//                       children: [
//                         Container(
//                           height: 20,
//                           width: 110,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadiusDirectional.circular(12),
//                             color: Color(0xFFed1c24),
//                           ),
//                           child: Center(child: Text("1")),
//                         ),
//                         SizedBox(height: 5,),
//                         Container(
//                             height: 60,
//                             width: 110,
//                             child:Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 Image(
//                                   image: AssetImage(
//                                       "assets/SVG_ICONS/myarrow.png"),
//                                 ),
//                                 Column(
//                                   // crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//
//                                     Text("gcg"),
//                                     Text("gcjhvjg"),
//
//                                   ],
//                                 )
//
//                               ],
//
//                             )
//                         ),
//
//
//                       ],
//                     ),
//                   ],
//                 )
//                 ),
//               ],),
//             Expanded(
//               child: ListView.separated(
//                 padding:EdgeInsets.only(top: 10),
//
//                 itemBuilder: (context, i){
//                   final dataaa = dataa[i];
//                   return            Container(
//                     margin: EdgeInsets.only(right: 5,left: 5),
//                     height: 70,
//                     child: GestureDetector(
//                       onTap: (){
//                         print('clicked');
//                       },
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Positioned.fill(
//                             child:CachedNetworkImage(
//                               fit: BoxFit.contain,
//                               imageUrl: globalss.UrlImagecourse+dataaa.icon.toString(),
//                               imageBuilder: (context, imageProvider) => Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(20),
//                                     bottomRight:  Radius.circular(20),
//                                     topRight:  Radius.circular(20),
//                                     topLeft: Radius.circular(20),
//                                   ),
//
//                                   image: DecorationImage(
//                                     image: imageProvider,
//                                     fit: BoxFit.fill,
//                                   ),
//
//
//                                 ),
//                               ),
//                               placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//                               errorWidget: (context, url, error) => Icon(Icons.error),
//                             ) ,
//                           ),
//                           Positioned(
//                               bottom: 0,
//                               left: 0,
//                               right: 0,
//                               child:Container(
//                                 //  color:   Colors.grey.withOpacity(0.8),
//                                 height: 70,
//                                 decoration: BoxDecoration(
//
//                                     borderRadius: BorderRadius.only(
//
//
//                                       bottomLeft: Radius.circular(20),
//                                       bottomRight:  Radius.circular(20),
//                                       topRight:  Radius.circular(20),
//                                       topLeft: Radius.circular(20),
//
//                                     ),
//                                     gradient: LinearGradient(
//
//                                         begin: Alignment.bottomCenter,
//                                         end: Alignment.topCenter,
//                                         colors: [
//                                           Colors.grey.withOpacity(0.8),
//                                           Colors.grey.withOpacity(0.7),
//                                           // Colors.transparent,
//                                         ]
//                                     )
//                                 ),
//
//                               )
//                           ),
//                           Positioned.fill(
//                             //bottom: 70,
//                             //    top:50,
//
//                             child: Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   mainAxisAlignment:MainAxisAlignment.center ,
//
//                                   children: [
//
//                                     Container(
//                                       width: 250,
//
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.3),
//                                         borderRadius: BorderRadius.only(
//
//
//                                           bottomLeft: Radius.circular(20),
//                                           bottomRight:  Radius.circular(20),
//                                           topRight:  Radius.circular(20),
//                                           topLeft: Radius.circular(20),
//
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: Center(
//                                           child: Text(dataaa.name,
//                                             style: TextStyle(color: Color(0xFF2429F9),fontSize: 16 ,fontWeight: FontWeight.bold ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//
//                         ],
//                       ),
//                     ),
//                     // padding: EdgeInsets.all(0.0),
//
//                   );
//
//
//
//                 },
//                 separatorBuilder: (context, i) => Divider(),
//
//                 itemCount: dataa.length,
//
//               ),
//             ),
//             SizedBox(height: 20,)
//             // RaisedButton(
//             //
//             //   onPressed: ()async{
//             //     bool result = await getCourses(isRefresh: false);
//             //
//             //     //  await getNews();
//             //     if (result){
//             //       refreshController.loadComplete();
//             //     } else {
//             //       refreshController.loadFailed();
//             //     }
//             //
//             //   }
//             //
//             // ,child: Text("fgsf"),)
//
//           ],
//         ),
//
//       ),
//     );
//   }
// }
//
