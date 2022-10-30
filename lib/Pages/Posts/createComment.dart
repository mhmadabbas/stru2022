







import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/Model/Posts/PostComment.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';




import '../../Vars/globalss.dart' as globalss;


import 'dart:convert' as convert;

import '../../mywidget/botombarnew.dart';
import '../Siginin.dart';
import '../kommunicate/prechat.dart';
import 'editcomment.dart';
import 'dart:ui' as ui;

class createComment extends StatefulWidget {
  Map<String, String> postinfo;

   createComment({Key? key,required this.postinfo}) : super(key: key);

  @override
  _createCommentState createState() => _createCommentState();
}

class _createCommentState extends State<createComment> {
  bool colorbool = false;
  int currentPage = 1;
  late int totalPages;
  //   int currentPage = 0;
//   late int totalPages;
  List<Datum> dataapost = [];
  TextEditingController comment = new TextEditingController();
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  bool result=false;



  Future likepost({required String idun} ) async {
    // if(!globalss.userverified){
    //   Alert(
    //     context: context,
    //     image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,),
    //     desc: "You must be logged in to complete the process".tr(),
    //     buttons: [
    //
    //       DialogButton(
    //         child: Text(
    //           "Login".tr(),
    //           style: TextStyle(color: Colors.white, fontSize: 10),
    //         ),
    //         onPressed: () {
    //           Navigator.pushReplacement(
    //             context,
    //             MaterialPageRoute(builder: (context) => LoginPage()),
    //           );
    //         },
    //         width: 120,
    //       ),
    //       DialogButton(
    //         child: Text(
    //           "Cancel".tr(),
    //           style: TextStyle(color: Colors.white, fontSize: 10),
    //         ),
    //         onPressed: () => Navigator.pop(context),
    //
    //         width: 120,
    //       )
    //     ],
    //   ).show();
    //   return;
    // }

    String Urlf = 'https://studyinrussia.app/api/like/${idun}';
    final responsef = await http.post(
      Uri.parse(Urlf),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );




  }



  createComment() async {
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

if(comment.text.isEmpty){
  Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "post.you cannot post null comment".tr()).show();
}
else{
  var request = http.MultipartRequest('POST', Uri.parse('https://studyinrussia.app/api/comments'));

  request.headers.addAll({"Authorization": "bearer "+globalss.tokenfromserver});

  request.fields['post_id'] = widget.postinfo["id"].toString();// globalss.Postids.toString();
  request.fields['comment'] = comment.text.toString();



  var response =await request.send();
  var responsed = await http.Response.fromStream(response);
  final responseData = convert.json.decode(responsed.body);

  if (response.statusCode==200) {
   // Alert(context: context, image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "post.Comment posted successfully".tr()).show();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
            title: Row(
              children: [
                Icon(Icons.check)
              ],
            ),
            content: Text(
              "post.Comment posted successfully".tr(),
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
                        Navigator.pop(context);

                      },
                        child:  SizedBox(
                          // width:
                          // MediaQuery.of(context).size.width *(144/375),
                            child: Center(child: Text("ok".tr()))),

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
    comment.clear();


  }
  else {
    Alert(context: context, title: "", desc: "post.something went wrong".tr()).show();
  }
}



  }

  deleteComment(String commentid) async {



    var request = http.MultipartRequest('POST', Uri.parse('https://studyinrussia.app/api/comments/${commentid}/delete'));

    request.headers.addAll({"Authorization": "bearer "+globalss.tokenfromserver});





    var response =await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = convert.json.decode(responsed.body);

    if (response.statusCode==200) {
    //  Alert(context: context,     image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "post.Comment deleted successfully".tr()).show();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(

              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(Icons.check)
                ],
              ),
              content: Text(
                "post.Comment deleted successfully".tr(),
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
                          Navigator.pop(context);

                        },
                          child:  SizedBox(
                            // width:
                            // MediaQuery.of(context).size.width *(144/375),
                              child: Center(child: Text("ok".tr()))),

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


    }
    else {
    //  Alert(context: context,     image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "post.something went wrong".tr()).show();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(

              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(Icons.error_outline)
                ],
              ),
              content: Text(
                "post.something went wrong".tr(),
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
                          Navigator.pop(context);

                        },
                          child:  SizedBox(
                            // width:
                            // MediaQuery.of(context).size.width *(144/375),
                              child: Center(child: Text("ok".tr()))),

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
    }




  }




Future<bool> getcomment({required bool isRefresh}) async {
  bool run = true;


  if (isRefresh) {
    currentPage = 1;
    run = true;
  }else{
    if(currentPage <= totalPages){
      currentPage++;
      run = true;
    }
    else{
      run = false;
    }
  }
  if(run){
    String Url = '';

    Url = 'https://studyinrussia.app/api/post/comments/${widget.postinfo["id"].toString()}?page=$currentPage';



    print(Url);
    if(run){

    }
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "bearer "+globalss.tokenfromserver},

    );

    PostComment postCommentFromJson(String str) => PostComment.fromJson(convert.json.decode(response.body));

    final postComment = postCommentFromJson(response.body);



    if (response.statusCode == 200) {
      PostComment postCommentFromJson(String str) => PostComment.fromJson(convert.json.decode(response.body));

      final postComment = postCommentFromJson(response.body);



      if (isRefresh) {
        dataapost = [];
        dataapost = postComment.data;

      }else {

        if(currentPage <= totalPages){
          dataapost.addAll(postComment.data);
        }
      }


      totalPages =(postComment.pagination.totalItems / 10).round();
      if ((totalPages * 10) < postComment.pagination.totalItems) {
        totalPages=totalPages+1;
      }else{
        totalPages=1;
      }

      setState(() {});
      return true;
    }else{
      return false;

    }
  }
  return true;




  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    String colorbool = widget.postinfo["likedByCurrentUser"].toString();

    var coloor =(colorbool=="true") ? Colors.blueAccent : Colors.grey;
    return Scaffold(
        extendBodyBehindAppBar: true,

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

        body:SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                GestureDetector(
                  onTap: ()async{
                    print("fgfg");
                    await likepost(idun: widget.postinfo["id"].toString());
                    setState(() {
                      if (widget.postinfo["likedByCurrentUser"].toString()=="true") {
                        widget.postinfo["likedByCurrentUser"] =
                        "false";
                        widget.postinfo["likes"] =(int.parse(widget.postinfo["likes"].toString())-1).toString();
                      } else{
                        widget.postinfo["likedByCurrentUser"] =
                        "true";
                        widget.postinfo["likes"] =(int.parse(widget.postinfo["likes"].toString())+1).toString();

                      }
                    }
                    );
                  },
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        height: MediaQuery.of(context).size.width*231/375,
                        imageUrl: globalss.UrlImageposts +widget.postinfo["media"].toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(

                            borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:  Radius.circular(20)) ,
                            // gradient: LinearGradient(
                            //     colors: [Colors.green, Colors.blue]),

                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),

                          ),
                        ),
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width*231/375,
                        decoration: BoxDecoration(

                          borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:  Radius.circular(20)) ,
                          gradient: LinearGradient(
                              colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.2)]),



                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: Text(widget.postinfo["title"].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),maxLines: 3),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: Padding(
                          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                          child: SizedBox(
                            height:MediaQuery.of(context).size.width*(18/375) ,
                            width:MediaQuery.of(context).size.width*(345/375) ,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.postinfo["createdBy"].toString(),style: TextStyle(color:Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                Text(widget.postinfo["publishTime"].toString().substring(0, 10),style: TextStyle(color:Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(

                        right:MediaQuery.of(context).size.width*(31/375) ,
                    //    left:MediaQuery.of(context).size.width*(31/375) ,
                        top:MediaQuery.of(context).size.width*(31/375) ,
                        child:
                        (widget.postinfo["likedByCurrentUser"] == "true")

                            ?
                            SizedBox(
                              height: MediaQuery.of(context).size.width*(31/375),
                              width: MediaQuery.of(context).size.width*(160/375),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.width*(31/375),
                                    width: MediaQuery.of(context).size.width*(122/375),
                                    decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                      color: Colors.white

                                    ),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width:MediaQuery.of(context).size.width*(20/375) ,
                                          height:MediaQuery.of(context).size.width*(31/375) ,
                                          child: IconButton(
                                        icon:(Icon(Icons.favorite,color: Colors.red,size:10,)),
                                          onPressed: () {}


                                            ),
                                        ),


                                        SizedBox(
                                          width:MediaQuery.of(context).size.width*(100/375) ,
                                          height:MediaQuery.of(context).size.width*(31/375) ,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                              child: Text("Added to Favorites",style: TextStyle(color: Colors.black),)),
                                        )
                                      ],
                                    )
                                  ),
                                  SizedBox(
                                      height:MediaQuery.of(context).size.width*(31/375) ,
                                      width:MediaQuery.of(context).size.width*(31/375) ,
                                      child: IconButton(
                                        icon:Icon(Icons.favorite,color: Colors.white,size: MediaQuery.of(context).size.width*(20/375)) ,
                                        onPressed: ()async{

                                        },
                                      )
                                  ),

                                ],
                              ),
                            )
                            :
                            SizedBox(
                          height:MediaQuery.of(context).size.width*(31/375) ,
                          width:MediaQuery.of(context).size.width*(31/375) ,


                          child: IconButton(
                            icon:Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*(20/375)) ,
                                onPressed: () async{
                                },
                          )
                        ),
                      ),
                      Positioned(

                      //  right:MediaQuery.of(context).size.width*(31/375) ,
                           left:MediaQuery.of(context).size.width*(15/375) ,
                        top:MediaQuery.of(context).size.width*(31/375) ,
                        child:

                        SizedBox(
                          height: MediaQuery.of(context).size.width*(31/375),
                          width: MediaQuery.of(context).size.width*(31/375),
                          child: Directionality(
                            textDirection: ui.TextDirection.ltr,
                            child: BackButton(
                              color: Colors.white,
                            ),
                          )
                        )

                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375)  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height:MediaQuery.of(context).size.width*(15/375) ,),
                      Text(widget.postinfo["content"].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400), ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375) ,top:MediaQuery.of(context).size.width*(20/375) ,bottom: MediaQuery.of(context).size.width*(20/375) ),
child: Row(
  children: [
    Text("post.Comments".tr(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyText1!.color),)
  ],
),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: true,
                    enablePullDown: true,
                    onRefresh: () async {
                      result = await getcomment(isRefresh: true);
                      if (result) {
                        refreshController.refreshCompleted();
                      } else {
                        refreshController.refreshFailed();
                      }
                    },
                    onLoading: () async {
                      result = await getcomment(isRefresh: false);
                      if (result) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadFailed();
                      }
                    },
                    child:

                    (!result&&dataapost.length==0)? SizedBox(height: 10,)
                        :
                    (result&&dataapost.length>0)?
                    ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, i) {
                        var dataaa = dataapost[i];
                        return Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*(4/375)),
                          child: Container(
                            child: ListTile(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 6.0,vertical: 10),
                                dense: true,
                                title:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dataaa.createdBy.firstName.toString()+" "+dataaa.createdBy.lastName.toString(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 14,fontWeight: FontWeight.bold),) ,
                                    Text(dataaa.createTime.date.toString().substring(0, 19),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),) ,

                                  ],
                                ),

                                subtitle:Text(dataaa.comment.toString(),style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 14,fontWeight: FontWeight.w400 ),),
                                leading:SizedBox(
                                  height: MediaQuery.of(context).size.width*(48/375),
                                  width: MediaQuery.of(context).size.width*(48/375),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fitHeight,
                                    imageUrl: globalss.UrlImageposts +
                                        dataaa.createdBy.image.toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),

                                trailing:(dataaa.createdBy.firstName.toString()==globalss.fname && dataaa.createdBy.lastName.toString()==globalss.lname)?
                                PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child:TextButton.icon(onPressed: (){
                                        Map<String,String> cominfo = {
                                          "commentid":dataaa.id.toString(),
                                          "commentbody":dataaa.comment.toString(),
                                        };
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Editcomment(pp:cominfo)),
                                        );
                                      },
                                          // icon: Icon(Icons.edit),
                                          // label: Text("post.edit".tr())

                              icon: Icon(Icons.edit,color:Theme.of(context).textTheme.bodyText2!.color ),
                            label: Text("post.edit".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),)

                        ),

                                      value: 3,

                                    ),
                                    PopupMenuItem(
                                      child:TextButton.icon(onPressed: ()async{
                                        await deleteComment(dataaa.id.toString());
                                        await getcomment(isRefresh: true);
                                      },
                                          // icon: Icon(Icons.delete,color: Colors.red,),
                                          // label: Text("post.delete".tr(),style: TextStyle(color: Colors.red),)

                        icon: Icon(Icons.delete,color:Theme.of(context).textTheme.bodyText2!.color),
                        label: Text("post.delete".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),)

                        ),

                                      value: 4,

                                    ),

                                  ],

                                )
                                :SizedBox()

                            ),
                          ),
                        );
                      },

                      separatorBuilder: (context, i) => Divider(),

                      itemCount: dataapost.length,
                    ):
                    (result&&dataapost.length==0)?
                    Center(child:Text("Be the first to comment on this post "),)
                        :
                    SizedBox(height: 10,),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375) ,right:MediaQuery.of(context).size.width*(15/375) ,top:MediaQuery.of(context).size.width*(20/375) ,bottom: MediaQuery.of(context).size.width*(20/375) ),
                  child: Row(
                    children: [
                      Container(
                          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/5, maxWidth: MediaQuery.of(context).size.width*(70/100)),

                          child: FittedBox(child: Text("post.Write a comment".tr(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyText1!.color),)))
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.all(MediaQuery.of(context).size.width*(31/375)  ),
                  child: Container(
                 //   height:MediaQuery.of(context).size.width*(156/375) ,
                    width:MediaQuery.of(context).size.width*(345/375) ,
                    decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                   borderRadius: BorderRadius.circular(20),
                   //   color: Colors.red,

                    ),
                    child: Column(
                      children: [

                        TextFormField(
                          cursorColor: globalss.cblue,

                          controller:comment ,
                          maxLines: null,
                          decoration: InputDecoration(
                              focusColor:
                              Theme.of(context).textTheme.headline1!.color,
                              hoverColor:
                              Theme.of(context).textTheme.headline1!.color,
                              fillColor:
                              Theme.of(context).textTheme.headline1!.color,




                              label: Text("post.Your comment".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                              hintText:'post.What do you think about? Type something'.tr()+"...",
                             hintStyle: TextStyle(fontSize: 15,color: globalss.cgray),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always),



                        ),
                        SizedBox(height:MediaQuery.of(context).size.width*(24/375) ,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*(345/375),
                          child: ElevatedButton(


                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),

                              ),
                              primary: globalss.cblue,
                            ),

                            onPressed:()async{
                              await createComment();
                            },
                            child:  Text("post.Write a comment".tr()),

                          ),
                        ),

                      ],
                    ),

                  )
                ),

                // Padding(
                //   padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(31/375) ,right:MediaQuery.of(context).size.width*(31/375)  ),
                //   child: TextFormField(
                //     controller: comment,
                //     keyboardType: TextInputType.multiline,
                //     maxLines: null,
                //     decoration: InputDecoration(
                //       hintText: 'Your comment',
                //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                //       border:
                //       OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                //     ),
                //     validator:(value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter some text';
                //       }
                //       return null;
                //     },
                //   ),
                // ),

                // Padding(
                //   padding: EdgeInsets.only(right: 20,left: 20),
                //   child: Stack(
                //     children: [
                //
                //
                //       Positioned.directional(textDirection:Directionality.of(context) ,
                //         end: 2,
                //         child: IconButton(
                //           onPressed: ()
                //           async{
                //             await createComment();
                //             await getcomment(isRefresh: true);
                //             // print (context.locale);
                //           },
                //           icon: Icon(Icons.send),
                //         ),
                //
                //       )],
                //   ),
                // ),



                //old
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: CachedNetworkImage(
//                     height: MediaQuery.of(context).size.height/3,
//                     width: MediaQuery.of(context).size.width,
//                     fit: BoxFit.fitHeight,
//                     imageUrl: globalss.UrlImageposts +
//                         widget.postinfo["media"].toString(),
//                     imageBuilder: (context, imageProvider) =>
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 4,
//                                 blurRadius: 4,
//                                 offset: Offset(0,
//                                     3), // changes position of shadow
//                               ),
//                             ],
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                     placeholder: (context, url) => Center(
//                         child: CircularProgressIndicator()),
//                     errorWidget: (context, url, error) =>
//                         Icon(Icons.error),
//                   ),
//                 ),
//
//                 Padding(
//                   padding:  EdgeInsets.only(left: 20.0,right: 20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                      Text(widget.postinfo["createdBy"].toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2!.color),maxLines: 1,overflow: TextOverflow.ellipsis,),
//                       Text(widget.postinfo["publishTime"].toString().substring(0, 10))
//                     ],
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20,left: 20,top: 5),
//                   child:RichText(
//                     text: TextSpan(
//                      style:TextStyle(color:Theme.of(context).textTheme.bodyText1!.color ),// DefaultTextStyle.of(context).style,
//
//                       children:  <TextSpan>[
//                         TextSpan(text: widget.postinfo["title"].toString()+'\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,)),
//                         TextSpan(text:widget.postinfo["content"].toString()+'\n',),
//
//                       ],
//                     ),
//                   ),
//
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20,left: 20,top: 5),
//                   child: Row(
//
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.start,
//                         children: [
//
//                           TextButton.icon(
//                             onPressed: () async {
//                               await likepost(
//                                  // idun: dataaa.id.toString());
//                                   idun: widget.postinfo["id"].toString());
//
//                               setState(() {
//                                 if (widget.postinfo["likedByCurrentUser"].toString()=="true") {
//                                   widget.postinfo["likedByCurrentUser"] =
//                                   "false";
//                                   widget.postinfo["likes"] =(int.parse(widget.postinfo["likes"].toString())-1).toString();
//                                 } else{
//                                   widget.postinfo["likedByCurrentUser"] =
//                                   "true";
//                                   widget.postinfo["likes"] =(int.parse(widget.postinfo["likes"].toString())+1).toString();
//
//                                 }
//                               }
//                               );
//                             },
//                             label: Text(
//
//     widget.postinfo["likes"].toString(),
//                               style:
//                               TextStyle(color: Colors.grey),
//                             ),
//                             icon: Icon(
//                               Icons.thumb_up_alt_sharp,
//                               color: coloor,
//                             ),
//
//                           ),
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20,left: 20),
//                   child: Stack(
//                     children: [
//                       TextFormField(
//                         controller: comment,
//                         keyboardType: TextInputType.multiline,
//                         maxLines: null,
//                         decoration: InputDecoration(
//                           hintText: 'post.enter comment'.tr(),
//                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//                           border:
//                           OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//                         ),
//                         validator:(value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter some text';
//                           }
//                           return null;
//                         },
//                       ),
//
//                   Positioned.directional(textDirection:Directionality.of(context) ,
//                         end: 2,
//                         child: IconButton(
//                           onPressed: ()
//                       async{
//                             await createComment();
//                             await getcomment(isRefresh: true);
//                           // print (context.locale);
//                           },
//                           icon: Icon(Icons.send),
//                         ),
//
//                   )],
//                   ),
//                 ),
//
//                 Container(
//                   height: MediaQuery.of(context).size.height/3,
//                   child: SmartRefresher(
//                     controller: refreshController,
//                     enablePullUp: true,
//                     enablePullDown: true,
//                     onRefresh: () async {
//                        result = await getcomment(isRefresh: true);
//                       if (result) {
//                         refreshController.refreshCompleted();
//                       } else {
//                         refreshController.refreshFailed();
//                       }
//                     },
//                     onLoading: () async {
//                        result = await getcomment(isRefresh: false);
//                       if (result) {
//                         refreshController.loadComplete();
//                       } else {
//                         refreshController.loadFailed();
//                       }
//                     },
//                     child:
//
//                       (!result&&dataapost.length==0)? SizedBox(height: 10,):
//                     (result&&dataapost.length>0)?ListView.separated(
//                       padding: const EdgeInsets.all(8),
//                       itemBuilder: (context, i) {
//                         var dataaa = dataapost[i];
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               color: Theme.of(context).primaryColor,
//                               boxShadow: [
//                                 BoxShadow(
//                                   spreadRadius: 4,
//                                   color: Colors.black26,
//                                   offset: Offset(0, 0),
//                                   blurRadius: 5,
//                                 )
//                               ],
//                             ),
//                             child: Center(
//                               child: ListTile(
//                                   contentPadding:
//                                   EdgeInsets.symmetric(horizontal: 6.0,vertical: 10),
//                                   dense: true,
//                                   title:Text(dataaa.createdBy.firstName.toString()+" "+dataaa.createdBy.lastName.toString(),style: TextStyle(color: Theme.of(context).textTheme.headline2!.color),) ,
//                                   subtitle:Text(dataaa.comment.toString()),
//                                   leading: SizedBox(
//                                       height: 60,
//                                       width: 80,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           SizedBox(
//                                             height: 60,
//                                             width: 60,
//                                             child: CachedNetworkImage(
//                                               fit: BoxFit.fitHeight,
//                                               imageUrl: globalss.UrlImageposts +
//                                                   dataaa.createdBy.image.toString(),
//                                               imageBuilder: (context, imageProvider) =>
//                                                   Container(
//                                                     decoration: BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       //borderRadius: BorderRadius.circular(10),
//
// // borderRadius:BorderRadius.circular(40) ,
// //                                                               boxShadow: [
// //                                                                 BoxShadow(
// //                                                                   color: Colors.grey.withOpacity(0.5),
// //                                                                   spreadRadius: 4,
// //                                                                   blurRadius: 4,
// //                                                                   offset: Offset(0,
// //                                                                       3), // changes position of shadow
// //                                                                 ),
// //                                                               ],
//                                                       image: DecorationImage(
//                                                         image: imageProvider,
//                                                         fit: BoxFit.fill,
//                                                       ),
//                                                     ),
//                                                   ),
//                                               placeholder: (context, url) => Center(
//                                                   child: CircularProgressIndicator()),
//                                               errorWidget: (context, url, error) =>
//                                                   Icon(Icons.error),
//                                             ),
//                                           ),
//                                           VerticalDivider(thickness: 1,)
//                                         ],
//                                       )
//                                   ),
//
//                                   trailing:(dataaa.createdBy.firstName.toString()==globalss.fname && dataaa.createdBy.lastName.toString()==globalss.lname)?
//                                   PopupMenuButton(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     itemBuilder: (context) => [
//                                       PopupMenuItem(
//                                         child:TextButton.icon(onPressed: (){
//                                           Map<String,String> cominfo = {
//                                             "commentid":dataaa.id.toString(),
//                                             "commentbody":dataaa.comment.toString(),
//                                           };
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(builder: (context) => Editcomment(pp:cominfo)),
//                                           );
//                                         },
//                                             icon: Icon(Icons.edit),
//                                             label: Text("post.edit".tr())
//                                         ),
//
//                                         value: 3,
//
//                                       ),
//                                       PopupMenuItem(
//                                         child:TextButton.icon(onPressed: ()async{
//                                           await deleteComment(dataaa.id.toString());
//                                           await getcomment(isRefresh: true);
//                                         },
//                                             icon: Icon(Icons.delete,color: Colors.red,),
//                                             label: Text("post.delete".tr(),style: TextStyle(color: Colors.red),)
//                                         ),
//
//                                         value: 4,
//
//                                       ),
//
//                                     ],
//
//                                   )
//
//                                       :SizedBox()
//
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//
//                       separatorBuilder: (context, i) => Divider(),
//
//                       itemCount: dataapost.length,
//                     ):
//                     (result&&dataapost.length==0)?
//                     Center(child:Image.asset("assets/nm/EMPTYPAGE.png",height: 200,width: 200,fit: BoxFit.fill,),)
//                         :
//                     SizedBox(height: 10,),
//                   ),
//                 ),
              ]

          ),
        )

    );
  }
}
