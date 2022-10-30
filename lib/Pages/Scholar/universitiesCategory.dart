import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/Pages/Scholar/universities.dart';
import 'package:stru2022/Pages/Scholar/universitiesInfo.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/drawer.dart';
import '../../Model/UnCategores.dart';
import '../../Model/universities.dart';
import '../../mywidget/botombarnew.dart';
import '../Siginin.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;
import 'SubCoursList.dart';


class uncategory extends StatefulWidget {
  const uncategory({Key? key}) : super(key: key);

  @override
  _uncategoryState createState() => _uncategoryState();
}

class _uncategoryState extends State<uncategory> {

  final RefreshController refreshController = RefreshController();
  final String assetName = 'assets/SVG_ICONS/AboutUs.svg';

  int currentPage = 1;
  late int totalPages;
  List<Datumcu> datac = [];

  List<Datumun> dataun = [];

  String catnumber='notnumber' ;
  String passcatnumber='notnumber' ;
  String selectedcate='' ;
  int selectedtocolored = 200;
  bool colorbool = false;


  Future<UnCategores> getuncategory() async {
    print(context.locale);
    //     String Url = 'https://studyinrussia.app/api/scholar/universities/categories?lang='+context.locale.toString();

    String Url = 'https://studyinrussia.app/api/scholar/universities/categories?lang='+context.locale.toString();
    var response = await http.get(
      Uri.parse(Url),
    );
    UnCategores unCategoresFromJson(String str) => UnCategores.fromJson(convert.json.decode(response.body));
    // String getcatToJson(Getcat data) => convert.json.encode(data.toJson());

    final getuncat = unCategoresFromJson(response.body);


    // catnumber = getcat.data![0].id.toString();





    print(getuncat.message);
    return getuncat;

  }

  Future<GetUniversities> getUN() async {



    currentPage = 1;


    String Url;
    if(catnumber=='notnumber'){


      Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&page=$currentPage';

    }else{


      Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&category=$catnumber&page=$currentPage';


    }


    print(Url);
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );
    GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));


    final getun = getUniversitiesFromJson(response.body);

    print(getun.message);


    if (response.statusCode == 200) {
      GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));


      final getun = getUniversitiesFromJson(response.body);


      dataun = [];
      dataun = getun.data;



      return getun;
    }else{
      print("some error not 200");
      return getun;

    }



  }

  Future favorite({required String idun} ) async {

    var map = new Map<String, dynamic>();
    map['university'] = idun;
    String Urlf = 'https://studyinrussia.app/api/scholar/favorite/add/university';
    final responsef = await http.post(
        Uri.parse(Urlf),
        headers: {"Authorization": "bearer "+globalss.tokenfromserver},
        body: map
    );




  }
  bool isSwitched = false;
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
      body: Padding(
        padding:
        EdgeInsets.only(top:8.0,),
       // EdgeInsets.only(top:8.0,bottom:20.0 ,right:20 ,left:20 ),
        child: Column(

          children: [
            Padding(
                padding:  EdgeInsets.only(right: 20.0,left: 20,bottom: 1,top: 10),
                child:Row(
                  //crossAxisAlignment: CrossAxisAlignment.,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("home.Universities".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 30),),
                    TextButton(
                      style: TextButton.  styleFrom(
                        textStyle: const TextStyle(fontSize: 15,color: Colors.red),

                        primary: Colors.blue,


                      ),
                      onPressed: (){
                        // Map<String, dynamic> ppp={
                        //   "idd": catnumber,
                        //   "title": selectedcate,
                        // };
                        //
                        //
                        //
                        // if(catnumber=='notnumber'){
                        //   // Navigator.push(
                        //   //     context,
                        //   //     MaterialPageRoute(builder: (context) => newnewsall(pp: ppp,))
                        //   // );
                        //   //  Alert(context: context, title: "", desc: "select category first.").show();
                        //
                        // }else{
                        //   // Navigator.push(
                        //   //     context,
                        //   //     MaterialPageRoute(builder: (context) => newnewsall(pp: ppp,))
                        //   // );
                        // }
                        //

                        Map<String, dynamic> ppp={
                          "idd": catnumber,
                          "title": selectedcate,
                        };

                        print(ppp);

                        if(catnumber=='notnumber'){
                          globalss.uncateforfilter = "";
                          globalss.Fromprossbar='';
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => universitiesList())
                          );
                        }
                        else
                        {
                          globalss.Fromprossbar='';
                          globalss.uncateforfilter = catnumber;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => universitiesList())
                          );
                        }

                      },
                      child:  Text('View All..'.tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 13,),),

                    ),
                  ],
                )
            ),
            FutureBuilder(
              future:
              getuncategory(),
              builder: (context,AsyncSnapshot snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(child: SizedBox(),);
                    }
                  case ConnectionState.done:
                    if (snapshot.hasData) {

                      return Row(
                        mainAxisAlignment:MainAxisAlignment.start ,
                        children: [
                          SizedBox(height: 60,),

                          Expanded(
                            child:Padding(
                              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right:MediaQuery.of(context).size.width*(15/375) ),
                              child: Container(
                              decoration:
                              BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                //color:Colors.grey.withOpacity(0.3),
                              ),
                              height: 40,


                              // width: 300,
                              child: ListView.builder(

                                shrinkWrap: false,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (context, i){
                                  var coloor =(selectedtocolored == i)?globalss.cblue : (Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Color(0xFFDFDFDF):Color(0xFF383838);
                                  //globalss.cgray;
                                //  var coloor =(selectedtocolored == i)?Colors.blue : Colors.red;
                                  return Padding(
                                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(1/375) , right: MediaQuery.of(context).size.width*(1/375)),
                                    child: GestureDetector(
                                      onTap: (){
                                    //    print("clicked");
                                        setState(() {
                                          catnumber = snapshot.data.data[i].id.toString();
                                          selectedcate = snapshot.data.data[i].name.toString();
                                          selectedtocolored=i;
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
                                            child: Text(snapshot.data.data[i].name,
                                              style: TextStyle(
                                                //  color: Colors.white,fontWeight: FontWeight.bold
                                                  color:(coloor==globalss.cblue)?Colors.white:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? Color(0xFF505050):Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },


                              ),
                          ),
                            ),),
                          SizedBox(width:6,),
                        ],

                      );

                    }
                }
                return Center(child: SizedBox(),);


              },
            ),

            FutureBuilder(
              future: getUN(),
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
                            children: [

                              Expanded(
                                child:(snapshot.data.data.length>0)? ListView.builder(
                                  itemBuilder: (context, i){

                                    final dataaa =snapshot.data.data[i];

                                    colorbool = snapshot.data.data[i].inCurrentUserFavorite;

                                    var coloor =(colorbool)?globalss.cblue : Colors.grey;


                                    return Padding(
                                      padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*(15/375) ,left: MediaQuery.of(context).size.width*(15/375),top: MediaQuery.of(context).size.width*(15/375)),
                                      child: Container(

                                        child:

                                        Column(
                                          //crossAxisAlignment:CrossAxisAlignment.stretch ,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [




                                            CachedNetworkImage(
                                              height: MediaQuery.of(context).size.width/2.2,
                                              width: MediaQuery.of(context).size.width,
                                              // fit: BoxFit.fitHeight,

                                              imageUrl: globalss.UrlImageuniversity+dataaa.logo.toString(),
                                              imageBuilder: (context, imageProvider) =>
                                              // CircleAvatar(
                                              //   radius: 200,
                                              //   backgroundImage: imageProvider,
                                              // ),
                                              Container(

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10),),


                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),



                                                ),
                                              ),
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Icon(Icons.error),


                                            ) ,


                                            Container(
                                              height: 20,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  //  SizedBox(width: 16,),
                                                  Icon(Icons.location_on_outlined ,size: 15,),
                                                  Text(dataaa.city.name.toString(),style: TextStyle(fontSize: 10),)
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(dataaa.name.toString() ,style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),
                                              ],
                                            ),

                                            Container(
                                              height: MediaQuery.of(context).size.width*(45/375),

                                              child: Padding(
                                                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375) ),
                                                child: Row(
                                                  // crossAxisAlignment:CrossAxisAlignment.center ,
                                                  mainAxisAlignment:MainAxisAlignment.start ,
                                                  children: [
                                                    SizedBox(
                                                      height:MediaQuery.of(context).size.width*(29/375),
                                                      width:MediaQuery.of(context).size.width*(84/375) ,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(

                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20.0),
                                                          ),
                                                         // shadowColor:Colors.transparent,
                                                          elevation: 0,
                                                          primary: globalss.cblue.withOpacity(0.1),
                                                        ),
                                                        onPressed: () {
                                                          Map<String, dynamic> Mapnews={
                                                            "id": dataaa.id,
                                                            "title": dataaa.name,
                                                            "description": dataaa.description,
                                                            "creator":dataaa.logo,
                                                          };

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => UnversityDetails(mapun: Mapnews))
                                                          );
                                                        },
                                                        child: Center(
                                                            child: Padding(
                                                              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(1/375),right:MediaQuery.of(context).size.width*(1/375)),
                                                              child: SizedBox(
                                                            width: MediaQuery.of(context).size.width*(84/375),
                                                                child: FittedBox(
                                                                  child: Text("Show more".tr(),
                                                                    style: TextStyle(
                                                                        color: Theme.of(context).textTheme.headline1!.color,fontWeight: FontWeight.bold),),
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                    ),

                                                    CircleAvatar(
                                                      backgroundColor:globalss.cblue.withOpacity(0.1) ,
                                                      radius: MediaQuery.of(context).size.width*(29/375),
                                                      child:
                                                      Center(
                                                        child: IconButton(
                                                          onPressed: ()async{
                                                            await favorite(idun: dataaa.id.toString());

                                                            setState((){
                                                              if(dataaa.inCurrentUserFavorite){
                                                                dataaa.inCurrentUserFavorite  = false;
                                                              }else{
                                                                dataaa.inCurrentUserFavorite  = true;
                                                              }
                                                            });



                                                          },
                                                          icon:Icon(Icons.favorite,color:coloor,size: MediaQuery.of(context).size.width*(18/375)),
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
                                    );
                                  },

                                  itemCount: snapshot.data.data.length,

                                )
                                    :
                                Center(child:Text("coming soon.."),)

                              ),

                              // Center(
                              //   child:TextButton(
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
                              //     print(ppp);
                              //
                              //     if(catnumber=='notnumber'){
                              //      // Alert(context: context, title: "", desc: "select category first.").show();
                              //       globalss.uncateforfilter = "";
                              //       globalss.Fromprossbar='';
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(builder: (context) => universitiesList())
                              //       );
                              //     }else{
                              //       globalss.Fromprossbar='';
                              //       globalss.uncateforfilter = catnumber;
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(builder: (context) => universitiesList())
                              //       );
                              //     }
                              //
                              //
                              //   },
                              //   child:  Text('View All..'.tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color),),
                              //
                              // ),),
                            //  SizedBox(height: 10,)
                            ],
                          )
                      );


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























// import 'dart:async';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'dart:convert' as convert;
//
//
// import 'package:http/http.dart' as http;
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:studyinrussia/Pages/Scholar/universities.dart';
// import 'package:studyinrussia/Pages/Scholar/universitiesInfo.dart';
//
//
// import '../../Model/UnCategores.dart';
// import '../../Model/universities.dart';
// import '/Vars/globalss.dart' as globalss;
//
//
// class uncategory extends StatefulWidget {
//   const uncategory({Key? key}) : super(key: key);
//
//   @override
//   _uncategoryState createState() => _uncategoryState();
// }
//
// class _uncategoryState extends State<uncategory> {
//
//   final RefreshController refreshController = RefreshController();
//   final String assetName = 'assets/SVG_ICONS/AboutUs.svg';
//
//   int currentPage = 1;
//   late int totalPages;
//   List<Datumcu> datac = [];
//
//   List<Datumun> dataun = [];
//
//   String catnumber='notnumber' ;
//   String passcatnumber='notnumber' ;
//   String selectedcate='' ;
//
//
//
//   Future<UnCategores> getuncategory() async {
//     print(context.locale);
//     //     String Url = 'https://studyinrussia.app/api/scholar/universities/categories?lang='+context.locale.toString();
//
//     String Url = 'https://studyinrussia.app/api/scholar/universities/categories?lang='+context.locale.toString();
//     var response = await http.get(
//       Uri.parse(Url),
//     );
//     UnCategores unCategoresFromJson(String str) => UnCategores.fromJson(convert.json.decode(response.body));
//    // String getcatToJson(Getcat data) => convert.json.encode(data.toJson());
//
//     final getuncat = unCategoresFromJson(response.body);
//
//
//     // catnumber = getcat.data![0].id.toString();
//
//
//
//
//
//     print(getuncat.message);
//     return getuncat;
//
//   }
//
//   Future<GetUniversities> getUN() async {
//
//
//
//     currentPage = 1;
//
//
//     String Url;
//     if(catnumber=='notnumber'){
//
//
//       Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&page=$currentPage';
//
//     }else{
//
//
//       Url = 'https://studyinrussia.app/api/scholar/universities?lang=${context.locale.toString()}&category=$catnumber&page=$currentPage';
//
//
//     }
//
//
//     print(Url);
//     final response = await http.get(
//       Uri.parse(Url),
//     );
//     GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));
//
//
//     final getun = getUniversitiesFromJson(response.body);
//
//     print(getun.message);
//
//
//     if (response.statusCode == 200) {
//       GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(convert.json.decode(response.body));
//
//
//       final getun = getUniversitiesFromJson(response.body);
//
//
//       dataun = [];
//       dataun = getun.data;
//
//
//
//       return getun;
//     }else{
//       print("some error not 200");
//       return getun;
//
//     }
//
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//
//           children: [
//             FutureBuilder(
//               future:
//               getuncategory(),
//               builder: (context,AsyncSnapshot snapshot){
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     {
//                       return Center(child: CircularProgressIndicator(),);
//                     }
//                   case ConnectionState.done:
//                     if (snapshot.hasData) {
//
//                       return Row(
//                         mainAxisAlignment:MainAxisAlignment.start ,
//                         children: [
//                           SizedBox(height: 70,),
//                           Container(
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),   color:Colors.blue,),
//                             height: 50,
//                             width: 50,
//
//
//
//                             child:SvgPicture.asset('assets/SVG_ICONS/university.svg',color: Colors.white ,fit:BoxFit.cover ,),
//
//                             //Icon(Icons.ten_mp,size: 50,)
//                           ),
//                           SizedBox(width: 2,),
//                           Expanded(child:Container(
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color:Colors.grey.withOpacity(0.3),),
//                             height: 50,
//
//
//                             // width: 300,
//                             child: ListView.builder(
//
//                               shrinkWrap: false,
//                               physics: ClampingScrollPhysics(),
//                               scrollDirection: Axis.horizontal,
//                               itemCount: snapshot.data.data.length,
//                               itemBuilder: (context, i){
//                                 return Padding(
//                                   padding: const EdgeInsets.only(left: 5.0 , right: 5.0),
//                                   child: Container(
//                                     //  height: 90,
//                                     width: 100,
//
//
//
//
//                                     child: GestureDetector(
//                                       onTap: (){
//                                         print("clicked");
//                                         setState(() {
//                                           catnumber = snapshot.data.data[i].id.toString();
//                                           selectedcate = snapshot.data.data[i].name.toString();
//                                         });
//                                       },
//                                       child: Container(
//
//
//
//                                         decoration: new BoxDecoration(
//                                             color: Colors.red,
//                                             shape:BoxShape.rectangle,
//                                             borderRadius: BorderRadius.all(Radius.circular(8.0))
//                                         ),
//                                         child: Center(
//                                           child: Text(snapshot.data.data[i].name,style: TextStyle(color: Colors.white),),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//
//
//                             ),
//                           ),)
//                         ],
//
//                       );
//
//                     }
//                 }
//                 return Center(child: CircularProgressIndicator(),);
//
//
//               },
//             ),
//
//             FutureBuilder(
//               future: getUN(),
//               builder: (context,AsyncSnapshot snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     {
//                       return Center(child: CircularProgressIndicator(),);
//                     }
//                   case ConnectionState.done:
//                     if (snapshot.hasData) {
//
//                       return Expanded(
//                           child: Column(
//
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: Center(child:(selectedcate=='')?Text("please select category.",style: TextStyle(fontSize:12),):Text(selectedcate.toString(),style: TextStyle(fontSize: 12),),),
//                               ),
//                               Expanded(
//                                 child: ListView.builder(
//                                   itemBuilder: (context, i){
//                                     final dataaa =snapshot.data.data[i];
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.all(Radius.circular(8),),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey.withOpacity(0.5),
//                                               spreadRadius: 4,
//                                               blurRadius: 4,
//                                               offset: Offset(0, 3), // changes position of shadow
//                                             ),
//                                           ],),
//                                         child: ListTile(
//                                           contentPadding: EdgeInsets.symmetric(horizontal: 7.0),
//                                           focusColor: Colors.amberAccent,
//                                           title: Text(dataaa.name.toString()),
//                                           subtitle:Text(dataaa.description.toString()) ,
//                                           leading:
//
//                                           SizedBox(
//                                             height: 60,
//                                             width: 60,
//                                             child: CachedNetworkImage(
//                                               imageUrl: globalss.UrlImageuniversity+snapshot.data.data[i].logo.toString(),
//                                               imageBuilder: (context, imageProvider) => Container(
//                                                 decoration: BoxDecoration(
//
//                                                   borderRadius:BorderRadius.circular(8) ,
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.grey.withOpacity(0.5),
//                                                       spreadRadius: 4,
//                                                       blurRadius: 4,
//                                                       offset: Offset(0, 3), // changes position of shadow
//                                                     ),
//                                                   ],
//                                                   image: DecorationImage(
//                                                     image: imageProvider,
//                                                     fit: BoxFit.cover,
//                                                   ),
//
//                                                 ),
//                                               ),
//                                               placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//                                               errorWidget: (context, url, error) => Icon(Icons.error),
//                                             ),
//
//                                           ) ,
//                                           onTap: (){
//                                             Map<String, dynamic> Mapnews={
//                                               "id": dataaa.id,
//                                               "title": dataaa.name,
//                                               "description": dataaa.description,
//                                               "creator":dataaa.logo,
//
//                                             };
//
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(builder: (context) => UnversityDetails(mapun: Mapnews))
//                                             );
//
//                                           },
//                                           isThreeLine: true,
//
//                                         ),
//                                       ),
//                                     );
//                                   },
//
//                                   itemCount: snapshot.data.data.length,
//
//                                 ),
//                               ),
//
//                               Center(child:TextButton(
//                                 style: TextButton.  styleFrom(
//                                   textStyle: const TextStyle(fontSize: 15,color: Colors.red),
//
//                                   primary: Colors.blue,
//
//
//                                 ),
//                                 onPressed: (){
//                                   Map<String, dynamic> ppp={
//                                     "idd": catnumber,
//                                     "title": selectedcate,
//                                   };
//
//                                   print(ppp);
//
//                                   if(catnumber=='notnumber'){
//                                     Alert(context: context, title: "", desc: "select category first.").show();
//
//                                   }else{
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(builder: (context) => universitiesList(mapunc: ppp,))
//                                     );
//                                   }
//
//
//                                 },
//                                 child: const Text('View All..'),
//
//                               ),)
//                             ],
//                           ));
//
//
//                     }
//
//                 }
//                 return Center(child: CircularProgressIndicator(),);
//
//
//               },
//             ),
//
//
//
//
//
//
//
//           ],
//
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'dart:async';
// // import 'package:easy_localization/easy_localization.dart';
// //
// //
// // import 'package:flutter/material.dart';
// // import 'dart:convert' as convert;
// //
// //
// // import 'package:http/http.dart' as http;
// // import 'package:studyinrussia/Pages/Scholar/universities.dart';
// //
// //
// // import '../../Model/UnCategores.dart';
// //
// // import 'package:studyinrussia/Vars/globalss.dart' as globalss;
// //
// // class uncategory extends StatefulWidget {
// //   const uncategory({Key? key}) : super(key: key);
// //
// //   @override
// //   _uncategoryState createState() => _uncategoryState();
// // }
// //
// // class _uncategoryState extends State<uncategory> {
// //
// //   Future<UnCategores> getnewscategory() async {
// //     print(context.locale);
// //     String Url = 'https://studyinrussia.app/api/scholar/universities/categories?lang='+context.locale.toString();
// //     var response = await http.get(
// //       Uri.parse(Url),
// //     );
// //     UnCategores unCategoresFromJson(String str) => UnCategores.fromJson(convert.json.decode(response.body));
// //     String unCategoresToJson(UnCategores data) => convert.json.encode(data.toJson());
// //
// //
// //
// //     final unCategores = unCategoresFromJson(response.body);
// //
// //     print(unCategores.message);
// //     return unCategores;
// //
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: FutureBuilder(
// //         future:getnewscategory(),
// //         builder: (context,AsyncSnapshot snapshot){
// //           switch (snapshot.connectionState) {
// //             case ConnectionState.waiting:
// //               {
// //                 return Center(child: CircularProgressIndicator(),);
// //               }
// //             case ConnectionState.done:
// //               if (snapshot.hasData) {
// //
// //                 return ListView.builder(
// //                     itemCount: snapshot.data.data.length,
// //                     itemBuilder: (context, i){
// //                       return ListTile(
// //                         focusColor: Colors.amberAccent,
// //                         title: Text(snapshot.data.data[i].name.toString()),
// //
// //                         onTap: (){
// //                           //  final String xx = snapshot.data.data[i].id.toString();
// //                           //  final List xxx = snapshot.data.data[i];
// //                           //  List<Datum> xxxx =   snapshot.data.data[i];
// //                           Map<String, dynamic> xxxx={
// //                             "id": snapshot.data.data[i].id,
// //                             "name": snapshot.data.data[i].name
// //                           };
// //
// //                           globalss.uncateforfilter = snapshot.data.data[i].id.toString();
// //                           // final Datum xc =snapshot.data.data[i] ;
// //                           Navigator.push(
// //                               context,
// //                               MaterialPageRoute(builder: (context) => universitiesList())
// //                           );
// //
// //                         },
// //                       );
// //                     }
// //
// //                 );
// //
// //               }
// //           }
// //           return Center(child: CircularProgressIndicator(),);
// //
// //
// //         },
// //       ),
// //     );
// //   }
// // }
