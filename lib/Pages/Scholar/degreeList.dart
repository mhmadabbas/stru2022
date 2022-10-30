import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:stru2022/Model/Degree.dart';

import 'package:stru2022/mywidget/drawer.dart';



import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'coursesList.dart';



class degreeList extends StatefulWidget {

  degreeList({Key? key}) : super(key: key);


  @override
  _degreeListState createState() => _degreeListState();
}



class _degreeListState extends State<degreeList> {
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




  Future<bool> getDegrees({required bool isRefresh}) async {
    searchvalue = searchvaluecontroller.text;


    if (isRefresh) {
      currentPage = 1;
    }
    String Url = '';

if(searchvalue!=''){
  Url = 'https://studyinrussia.app/api/scholar/degrees?lang=${context.locale.toString()}&page=$currentPage&name=${searchvaluecontroller.text}';

}else{
  Url = 'https://studyinrussia.app/api/scholar/degrees?lang=${context.locale.toString()}&page=$currentPage';

}




    print(Url);
    final response = await http.get(
      Uri.parse(Url),
    );


    GetDegreeList getDegreeListFromJson(String str) => GetDegreeList.fromJson(convert.json.decode(response.body));

    final getDegreeList = getDegreeListFromJson(response.body);

    print(getDegreeList.message);


    if (response.statusCode == 200) {
      GetDegreeList getDegreeListFromJson(String str) => GetDegreeList.fromJson(convert.json.decode(response.body));
      final getDegreeList = getDegreeListFromJson(response.body);

      if (isRefresh) {
        dataa = [];
        dataa = getDegreeList.data;
      }else {
        if(currentPage <= totalPages){
          dataa.addAll(getDegreeList.data);
        }
      }



      totalPages =(getDegreeList.pagination.totalItems / 10).round();
      if ((totalPages * 10) < getDegreeList.pagination.totalItems) {
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


                children: [

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


                                        SvgPicture.asset('assets/22images/scholar/icondegree.svg',color:  Theme.of(context).textTheme.headline1!.color ,fit:BoxFit.cover ,),
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
                                              child: FittedBox(
                                                  child: Text("processcourse.Course".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 30 ,fontWeight: FontWeight.bold ) )),
                                            ),
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
                          child: Image(
                            image: AssetImage(
                                "assets/22images/scholar/arrow2.png"),
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
                                            SvgPicture.asset('assets/22images/scholar/iconun.svg',color: Theme.of(context).textTheme.headline1!.color ,fit:BoxFit.cover ,),
                                            SizedBox(width: 2,),
                                            Container(
                                              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/6, maxWidth: MediaQuery.of(context).size.width*(60/100)),
                                            height: MediaQuery.of(context).size.width*(8/100),
                                              child: FittedBox(
                                                  child: Text("processcourse.University".tr(),style: TextStyle(color: Theme.of(context).textTheme.headline1!.color,fontSize: 25 ,fontWeight: FontWeight.bold ) )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Text("03",style: TextStyle(color:(Theme.of(context).textTheme.headline1!.color==globalss.cblue)?globalss.cblue.withOpacity(0.2):Colors.white.withOpacity(0.2),fontSize: 40 ,fontWeight: FontWeight.bold ),)
                                ],
                              ),
                            )
                        )

                      ],
                    ),
                  )


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

                  await getDegrees(isRefresh: true);

                }
            ),
          ),


          Expanded(
            child: SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () async {
                   result = await getDegrees(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },

                onLoading:() async {
                  //           final result = await getPassengerData();

                   result = await getDegrees(isRefresh: false);

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
                    return
                      GestureDetector(
                        onTap: (){
                          globalss.uncateforfilter="";
                          globalss.unids="";
                          globalss.Courseids="";
                          globalss.Degreeids=dataaa.id.toString();
                          print("Degreeids"+globalss.Degreeids.toString());

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => CoursesList()),
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
                                  imageUrl: globalss.UrlImagedegree+dataaa.icon.toString(),
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
                                width: MediaQuery.of(context).size.width*(167/375),
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
                  //separatorBuilder: (context, i) => Divider(),

                  itemCount: dataa.length,

                ):
                (result&&dataa.length==0)?
                Center(child:Image.asset("assets/nm/EMPTYPAGE.png",height: 200,width: 200,fit: BoxFit.fill,),)
                    :
                SizedBox(height: 10,),
            ),
          ),
        ],
      )
    );
  }
}

