import 'dart:async';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';

import '../../Model/Posts/AllPosts.dart';


import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../Siginin.dart';
import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss;

import 'package:pull_to_refresh/pull_to_refresh.dart';


import 'package:cached_network_image/cached_network_image.dart';

import 'createComment.dart';
import 'createPost.dart';
import 'ownPosts.dart';
import 'dart:ui' as ui;


class allPosts extends StatefulWidget {

  allPosts({Key? key}) : super(key: key);


  @override
  _allPostsState createState() => _allPostsState();
}




class _allPostsState extends State<allPosts> {
  bool issearch = false;
  String searchvalue = '';
  TextEditingController searchvaluecontroller = new TextEditingController();


  bool colorbool = false;


  Icon customIcon =  Icon(Icons.search,size: 60,);

  int currentPage = 1;
  late int totalPages;
  List<Datum> dataa = [];

  List<GetAllPostsList> alpostclass = [];


  final RefreshController refreshController = RefreshController(initialRefresh: true);

  String UrlImagenews = globalss.UrlImagenews;

  bool result=false;


  Future likepost({required String idun} ) async {
    if(!globalss.userverified){
      Alert(
        context: context,
        image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,),
        desc: "You must be logged in to complete the process".tr(),
        buttons: [

          DialogButton(
            child: Text(
              "Login".tr(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            width: 120,
          ),
          DialogButton(
            child: Text(
              "Cancel".tr(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            onPressed: () => Navigator.pop(context),

            width: 120,
          )
        ],
      ).show();
      return;
    }

    String Urlf = 'https://studyinrussia.app/api/like/${idun}';
    final responsef = await http.post(
      Uri.parse(Urlf),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );




  }


  Future<bool> getPosts({required bool isRefresh}) async {
    searchvalue = searchvaluecontroller.text;

    if (isRefresh) {
      currentPage = 1;
    }


    String Url = '';
    if(searchvalue!=''){
      Url = 'https://studyinrussia.app/api/posts?page=$currentPage&title=${searchvaluecontroller.text}';
      print(Url);
    }else{
      Url = 'https://studyinrussia.app/api/posts?page=$currentPage';
      print(Url);
    }
    print(Url);
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},
    );


    GetAllPostsList getAllPostsListFromJson(String str) => GetAllPostsList.fromJson(convert.json.decode(response.body));
    final getposts = getAllPostsListFromJson(response.body);


   // print(getposts.message);


    if (response.statusCode == 200) {
      GetAllPostsList getAllPostsListFromJson(String str) => GetAllPostsList.fromJson(convert.json.decode(response.body));
      final getposts = getAllPostsListFromJson(response.body);


      if (isRefresh) {
        dataa = [];
        dataa = getposts.data;
      }else{
        if(getposts.data.length>0) {
          dataa.addAll(getposts.data);
        }
      }

      totalPages =(getposts.pagination.totalItems / 10).round();
      if ((totalPages * 10) < getposts.pagination.totalItems) {
        totalPages=totalPages+1;
      }else{
        totalPages=1;
      }

        currentPage++;



      setState(() {});
     // setState(() {});
      return true;
    }else{
     // print("some error not 200");
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
              child:ElevatedButton.icon(
                icon: Icon(Icons.create,size: 14,color: Colors.white),
                label: Text("post.Write a post".tr(),
                    style: TextStyle(
                        color: Colors.white,fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: globalss.cblue,
                ),

                onPressed:(){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => createpost()),
                  );
                },

              ) ,
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
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  fit: BoxFit.contain,
                )

              // Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
            )
          ],
        )
            : null,


      body:Padding(
        padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375)  ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*(15/375) ),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text("post.Forum".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                  ],
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.width*(10/375) ,),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *(172/375),
                      child: ElevatedButton.icon(
                        icon:   Container(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/22images/forum/allpostsicon.svg',
                              //color:Theme.of(context).textTheme.headline4!.color,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            )
                        ),
                        //FaIcon(FontAwesomeIcons.,color: Colors.deepOrange),
                        label:FittedBox(child: Text('post.All Posts'.tr(),style:TextStyle(color: Colors.white),maxLines: 1, )),
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                          //  fixedSize:Size(150, 40) ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight:  Radius.circular(0),
                              topRight:  Radius.circular(0),
                              topLeft: Radius.circular(20),

                            ),
                          ),
                          primary:globalss.cblue),

                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => allPosts()),
                          );
                        },
                      //  child:  Text('post.All Posts'.tr(),style:TextStyle(color: Colors.white), ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *(172/375),

                      child: ElevatedButton.icon(
                        icon:
                        Container(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/22images/forum/yourpostsicon.svg',
                              //color:Theme.of(context).textTheme.headline4!.color,
                              fit: BoxFit.contain,
                              color: Colors.grey,
                            )
                        ),
                     //   Icon(Icons.messenger),
                        label:  FittedBox(child: Text('post.Your Posts'.tr(),style:TextStyle(color: Colors.grey), )),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          //   fixedSize:Size(150, 40) ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight:  Radius.circular(20),
                              topRight:  Radius.circular(20),
                              topLeft: Radius.circular(0),

                            ),

                            // side: BorderSide(color: Colors.red)
                          ),
                          primary: Color(0xFFEEEEEE)

                         ),

                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => OwnPosts()),
                          );

                        },
                      //  child:  Text('post.Your Posts'.tr(),style:TextStyle(color: Colors.grey), ),
                      ),
                    ),



                  ],
                ),
              ),

              TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: searchvaluecontroller,
                  decoration: InputDecoration(
                      isDense: true,
                      label: Text("Search".tr()),
                      prefixIcon: Icon(Icons.search),
                      floatingLabelBehavior:FloatingLabelBehavior.never),

                  onFieldSubmitted: (value)async{

                    await getPosts(isRefresh: true);

                  }
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

                      (!result&&dataa.length==0)? SizedBox(height: 10,)
                          :
                    (result&&dataa.length>0)?ListView.separated(
                      padding: EdgeInsets.only(top: 10),
                      itemBuilder: (context, i) {
                        final dataaa = dataa[i];
                        colorbool = dataaa.likedByCurrentUser;

                        var coloor =
                        (colorbool) ? Colors.blueAccent : Colors.grey;
                        return Container(

                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),

                          ),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start ,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              CachedNetworkImage(
                                height: MediaQuery.of(context).size.width*(185/375),
                                width: MediaQuery.of(context).size.width*(345/375),
                                // fit: BoxFit.fitHeight,

                                imageUrl: globalss.UrlImageposts+dataaa.media.toString(),
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


                              // Container(
                              //   height: 20,
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       //  SizedBox(width: 16,),
                              //       Icon(Icons.location_on_outlined ,size: 15,),
                              //       Text(dataaa.city.name.toString(),style: TextStyle(fontSize: 10),)
                              //     ],
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.width*(14/375),),
                                  Text(dataaa.publishTime.date.toString().substring(0, 16) ,style: TextStyle(color:Theme.of(context).textTheme.headline1!.color,fontSize:12 ),),
                                  SizedBox(height: MediaQuery.of(context).size.width*(5/375),),
                                  Text(dataaa.title.toString() ,style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 16),maxLines: 2),
                                  SizedBox(height: MediaQuery.of(context).size.width*(5/375),),
                                  Text(dataaa.content.toString() ,style: TextStyle(fontSize: 12),maxLines: 2),
                                  SizedBox(height: MediaQuery.of(context).size.width*(8/375),),

                                ],
                              ),

                              Container(
                                height: 40,

                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*(84/375),
                                        height: MediaQuery.of(context).size.width*(29/375),


                                        child: ElevatedButton(

                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),

                                            ),
                                            shadowColor:Colors.transparent,
                                            elevation:0 ,
                                            primary: globalss.cblue.withOpacity(0.1),
                                          ),
                                          onPressed: () {
                                            Map<String, String> postinfo ={
                                              "id":dataaa.id.toString(),
                                              "title":dataaa.title.toString(),
                                              "content":dataaa.content.toString(),
                                              "createdBy":dataaa.createdBy.toString(),
                                              "likes":dataaa.likes.toString(),
                                              "comments":dataaa.comments.toString(),
                                              "likedByCurrentUser":dataaa.likedByCurrentUser.toString(),
                                              "media":dataaa.media.toString(),
                                              "publishTime":dataaa.publishTime.date.toString(),
                                              "featured":dataaa.featured.toString(),


                                            };
                                            globalss.Postids=dataaa.id.toString();

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => createComment(postinfo:postinfo)),
                                            );
                                          },
                                          child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 1.0,right:1 ),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width*(84/375),
                                                  child: FittedBox(
                                                    child: Text("Show more".tr(),
                                                      style: TextStyle(
                                                          color: Theme.of(context).textTheme.headline1!.color,fontSize: 12),),
                                                  ),
                                                ),
                                              )
                                          ),
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          SizedBox(
                                            height:MediaQuery.of(context).size.width*29/375 ,
                                            child:
                                            GestureDetector(
                                              onTap:()async{
                                                            print("fgfg");

                                                            await likepost(idun: dataaa.id.toString());
                                                            setState(() {
                                                            if (dataaa.likedByCurrentUser) {
                                                            dataaa.likedByCurrentUser =
                                                            false;
                                                            dataaa.likes =
                                                            dataaa.likes - 1;
                                                            } else {
                                                            dataaa.likedByCurrentUser =
                                                            true;
                                                            dataaa.likes =
                                                            dataaa.likes + 1;
                                                            }
                                                            });
                                                            },

                                              child: Container(

                                                decoration: BoxDecoration(


                                                  borderRadius:BorderRadius.circular(20) ,
                                                  color:
                                                  (Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),


                                                ),


                                                child: TextButton.icon(
                                                  icon:
                                                  (dataaa.likedByCurrentUser)?
                                                  Icon(Icons.favorite,color:Theme.of(context).textTheme.headline5!.color  ,size: 16)
                                                  :Icon(Icons.favorite_border,color:Theme.of(context).textTheme.headline5!.color ,size: 16),
                                               //   Icon(Icons.favorite_border,color:Theme.of(context).textTheme.headline5!.color ,size: 16),
                                                  label: Text(dataaa.likes.toString(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color,fontSize: 12 )),
                                                  onPressed: null,

                                                ),
                                              ),
                                            ),

                                          ),
                                          SizedBox(
                                            height:MediaQuery.of(context).size.width*29/375 ,
                                            child:
                                            Container(

                                              decoration: BoxDecoration(


                                                borderRadius:BorderRadius.circular(20) ,
                                                color:
                                                (Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)? globalss.cblue.withOpacity(0.1):Color(0xff383838),


                                              ),


                                              child: TextButton.icon(
                                                icon: Icon(Icons.mode_comment_outlined,color:Theme.of(context).textTheme.headline5!.color ,size: 16),
                                                label: Text(dataaa.comments.toString(),style: TextStyle(color:Theme.of(context).textTheme.headline5!.color,fontSize: 12 )),
                                                onPressed: null,

                                              ),
                                            ),

                                          ),
                                        ],
                                      )





                                    ],
                                  ),
                                ),

                              )


                            ],

                          ),
                        );

                      },
                      separatorBuilder: (context, i) => Divider(),

                      itemCount: dataa.length,

                    )
                        :
                    (result&&dataa.length==0)?
                    Center(child:Text("coming soon.."),)
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
