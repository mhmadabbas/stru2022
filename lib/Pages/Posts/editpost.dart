


import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/mywidget/drawer.dart';




import '../../Vars/globalss.dart' as globalss;
import 'dart:io';
import 'dart:convert' as convert;

import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';
import 'ownPosts.dart';


class editpost extends StatefulWidget {
  Map<String, String> postinfo;
   editpost({Key? key,required this.postinfo}) : super(key: key);

  @override
  _editpostState createState() => _editpostState();
}

class _editpostState extends State<editpost> {

  //image camera
  final ImagePicker _picker = ImagePicker();
  //end image camera
  //for activate post button
  bool eimg = false;
  bool et = false;
  bool ec = false;
  //for activate post button


  File? file;
  String hh = '';

  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();


  // PlatformFile? file;
  // String hh = '';
  //String gh = globalss.ghj;
  final _formKeyup = GlobalKey<FormState>();

  editpost() async {
    // if(!globalss.userverified){
    //   Alert(
    //     context: context,
    //     type: AlertType.warning,
    //     title: "",
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

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });

    var request = http.MultipartRequest('POST', Uri.parse('https://studyinrussia.app/api/posts/${widget.postinfo["id"]}'));

    request.headers.addAll({"Authorization": "bearer "+globalss.tokenfromserver});

    request.fields['title'] = title.text.toString();
    request.fields['content'] = content.text.toString();
    if(hh == 'ok'){
      request.files.add(await http.MultipartFile.fromPath('media',file!.path.toString()));
    }



    var response =await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = convert.json.decode(responsed.body);

    if (response.statusCode==200) {
      Navigator.pop(context);
      Alert(context: context, title: "SUCCESS", desc: "your post published succussfuly").show();
      title.clear();
      content.clear();

    }
    else {
      Navigator.pop(context);
      Alert(context: context, title: "ERROR", desc: "ERROR").show();
    }

  }

  @override
  void initState() {
    super.initState();
    content = new TextEditingController(text: widget.postinfo["content"].toString());
    title = new TextEditingController(text: widget.postinfo["title"].toString());

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

    body:Padding(
      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width*(15/375),left: MediaQuery.of(context).size.width*(15/375)),
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,


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
                                      MaterialPageRoute(builder: (context) => OwnPosts()),
                                    );
                                  },
                                  icon: Icon(Icons.arrow_back)
                              ),

                              Text("post.Edit Post".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

                            ],
                          )
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width*(25/375),),


                      SizedBox(
                        height:MediaQuery.of(context).size.width*(160/375),
                        width:MediaQuery.of(context).size.width*(345/375) ,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: Container(

                                  decoration: BoxDecoration(
                                    color: Color(0xffF1F1F1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),

                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        color: Color(0xff8D8D8D0D).withOpacity(0.05),
                                        offset: Offset(0, 0),
                                        blurRadius: 2,
                                      )
                                    ],



                                  ),
                                  child:(hh=="ok")?

                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),

                                      child: Image.file(File(file!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))

                                      :
                                  SizedBox(),

                                )
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.width*(38/375),
                                right:MediaQuery.of(context).size.width*(150/375) ,
                                left:MediaQuery.of(context).size.width*(150/375) ,

                                child: IconButton(
                                  icon:Icon(Icons.camera_alt_rounded,color: Color(0xff494949).withOpacity(0.2),size: MediaQuery.of(context).size.width*(38/375)) ,
                                  onPressed: (){
                                    var alertStyle = AlertStyle(
                                      alertPadding: EdgeInsets.only(right: 0,left: 0),
                                      animationType: AnimationType.fromBottom,
                                      isCloseButton: false,
                                      isOverlayTapDismiss: true,
                                      descStyle: TextStyle(fontWeight: FontWeight.bold),
                                      descTextAlign: TextAlign.start,
                                      animationDuration: Duration(milliseconds: 400),
                                      alertBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        side: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      titleStyle: TextStyle(
                                        color: Colors.red,

                                      ),
                                      alertAlignment: Alignment.bottomCenter,
                                    );

                                    Alert(

                                      //width: MediaQuery.of(context).size.width ,
                                        style: alertStyle,
                                        context: context,
                                        // title: "chose language plas uah",
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            Text("ApplytoCourse.Choose upload method".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 24,fontWeight: FontWeight.bold)),

                                            Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),
                                            TextButton.icon(
                                              icon: CircleAvatar(
                                                backgroundColor:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Color(0xffDFDFDF): Color(0xff575757),
                                                radius:MediaQuery.of(context).size.width*(15/375),
                                                child: Icon(FontAwesomeIcons.camera,size:MediaQuery.of(context).size.width*(14/375),color: Colors.black.withOpacity(0.3), ),
                                              ),
                                              label: Text('ApplytoCourse.Take Photo'.tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold)),
                                              onPressed: () async{

                                                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                                if (photo == null) {
                                                  eimg=false;
                                                  hh = "";
                                                  return;
                                                }
                                                if (photo != null) {
                                                  setState(() {
                                                    file = File(photo!.path);
                                                    hh = "ok";
                                                    eimg=true;
                                                  });
                                                  Navigator.pop(context);
                                                }


                                              },
                                            ),
                                            Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),
                                            TextButton.icon(

                                              icon: CircleAvatar(
                                                backgroundColor:(Theme.of(context).textTheme.bodyText1!.color==globalss.cblack)?Color(0xffDFDFDF): Color(0xff575757),
                                                radius:MediaQuery.of(context).size.width*(15/375),
                                                child: Icon(FontAwesomeIcons.images,size:MediaQuery.of(context).size.width*(14/375),color: Colors.black.withOpacity(0.3), ),
                                              ),


                                              label: Text('ApplytoCourse.Photo Library'.tr(),style:TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold)),
                                              onPressed: () async{

                                                final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                                                if (photo == null) {
                                                  hh = "";
                                                  eimg=false;
                                                  return;
                                                }
                                                if (photo!=null) {
                                                  setState(() {
                                                    file = File(photo!.path);
                                                    hh = "ok";
                                                    eimg=true;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                            Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                            ElevatedButton(

                                              onPressed: () async{
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                                primary: globalss.cblue,
                                              ),
                                              child: SizedBox(
                                                  width:
                                                  MediaQuery.of(context).size.width,
                                                  child: Center(
                                                      child: Text("ApplytoCourse.close".tr(),
                                                          style: TextStyle(
                                                              color: Colors.white)))),
                                            ),
                                            SizedBox(height: 50,)

                                          ],
                                        ),
                                        buttons: [

                                        ]).show();
                                  },
                                )
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.width*(15/375),
                                right:MediaQuery.of(context).size.width*(15/375) ,
                                left:MediaQuery.of(context).size.width*(15/375) ,

                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*(60/375),
                                      height: MediaQuery.of(context).size.width*(23/375),


                                      child: ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),

                                          ),
                                          shadowColor:Colors.transparent,
                                          elevation:0 ,
                                          primary: Color(0xff494949),
                                        ),
                                        onPressed: () {

                                        },
                                        child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 1.0,right:1 ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width*(60/375),
                                                child: FittedBox(
                                                  child: Text("post.Reqired".tr(),
                                                    style: TextStyle(
                                                        color: Colors.white,fontSize: 14),),
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Positioned(
                              bottom: 0,

                              child: Container(
                                height:MediaQuery.of(context).size.width*(53/375) ,
                                width: MediaQuery.of(context).size.width*(345/375),
                                decoration: BoxDecoration(
                                  color:( Theme.of(context).textTheme.bodyText1!.color == globalss.cblack)?Colors.white :globalss.cblack,

                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft:  Radius.circular(10),

                                  ),


                                ),
                                child: Padding(
                                  padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*(16/375) ,right:MediaQuery.of(context).size.width*(16/375) ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text("post.Post preview picture".tr(),style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                                      IconButton(
                                          onPressed: (){
                                            setState(() {
                                              file =null;
                                              hh='';
                                              eimg=false;
                                            });


                                          },
                                          icon: Icon(Icons.refresh))
                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),

                      ),

                      SizedBox(height: MediaQuery.of(context).size.width*(25/375),),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                            label: Text("post.Type a post title".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                            floatingLabelBehavior:
                            FloatingLabelBehavior.auto),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              // 2
                              et = false;
                            });
                            return 'post.Please enter a title'.tr();
                          }
                          else{
                            setState(() {
                              // 2
                              et = true;
                            });
                          }

                          return null;
                        },
                        onChanged: (value){
                          if (value == null || value.isEmpty||value.length < 2) {
                            setState(() {
                              // 2
                              et = false;
                            });

                          }else{
                            setState(() {
                              // 2
                              et = true;
                            });
                          }

                        },

                      ),
                      SizedBox(height: MediaQuery.of(context).size.width*(25/375),),
                      TextFormField(
                          controller: content,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              label: Text("post.Type a post text".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.auto),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                // 2
                                ec = false;
                              });
                              return 'post.Please enter a text'.tr();
                            }
                            else{
                              setState(() {
                                // 2
                                ec = true;
                              });
                            }

                            return null;
                          },
                          onChanged: (value) {
                            if (value == null || value.isEmpty || value.length < 2) {
                              setState(() {
                                // 2
                                ec = false;
                              });
                            } else {
                              setState(() {
                                // 2
                                ec = true;
                              });
                            }
                          }

                      ),
                    ]

                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*(345/375),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit_outlined),
                    label:Text('post.Edit Post'.tr()),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),

                      ),
                      primary: globalss.cblue,
                    ),

                    onPressed:
                        () async{

                        await editpost();


                    }


                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width*(20/375),)
              ],
            ),

          ],
        ),
      ),
    )

    // SingleChildScrollView(
    //       child: Form(
    //           key: _formKeyup,
    //           child: Padding(
    //             padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/10 ,bottom:MediaQuery.of(context).size.height/10 , ),
    //
    //             child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //
    //                 children: [
    //
    //
    //                   Padding(
    //                     padding: const EdgeInsets.only(right: 20,left: 20,top: 20 ,bottom: 5),
    //
    //                     child: Text("Enter Title :",style: TextStyle(color: Color(0xFF2429F9),fontWeight: FontWeight.bold),),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(right: 20,left: 20),
    //
    //                     child: TextFormField(
    //                       controller: title,
    //                       decoration: InputDecoration(
    //                         hintText: 'title',
    //                         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
    //                         border:
    //                         OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    //                       ),
    //                       validator:(value) {
    //                         if (value == null || value.isEmpty) {
    //                           return 'Please enter some text';
    //                         }
    //                         return null;
    //                       },
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(right: 20,left: 20,top: 20 ,bottom: 5),
    //
    //                     child: Text("Enter Content :",style: TextStyle(color: Color(0xFF2429F9),fontWeight: FontWeight.bold),),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(right: 20,left: 20),
    //
    //                     child: TextFormField(
    //                       keyboardType: TextInputType.multiline,
    //                       maxLines: null,
    //                       controller: content,
    //                       decoration: InputDecoration(
    //                         hintText: 'content',
    //                         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
    //                         border:
    //                         OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    //                       ),
    //                       validator:(value) {
    //                         if (value == null || value.isEmpty) {
    //                           return 'Please enter some text';
    //                         }
    //                         return null;
    //                       },
    //                     ),
    //                   ),
    //
    //                   SizedBox(height: 20,),
    //                   Padding(
    //                       padding: const EdgeInsets.only(right: 30,left: 30,top: 20 ,bottom: 5),
    //                       child: Row(
    //                         children: [
    //                           TextButton.icon(
    //                             label: Text("Upload Image"),
    //                             onPressed: ()async{
    //                               FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'] );
    //
    //                               if (result != null) {
    //                                 file = result.files.first;
    //                                 hh = 'oky';
    //                                 setState(() {});
    //
    //                               } else {
    //                                 hh = '';
    //                                 // User canceled the picker
    //                               }
    //                             },
    //                             icon: Icon(Icons.upload),
    //
    //                           ),
    //                           SizedBox(width: 2,),
    //                           (hh != 'oky')?SizedBox()
    //                               :
    //                           Row(
    //                             children: [
    //                               Image.file(File(file!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,),
    //                               IconButton(onPressed: (){
    //                                 file=null;
    //                                 hh ="";
    //                                 setState(() {});
    //
    //                               }, icon: Icon(Icons.delete,color: Colors.red,))
    //                             ],
    //                           )
    //                         ],
    //                       )
    //                   ),
    //
    //
    //
    //
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 30,left: 30,right: 30),
    //                     child: SizedBox(
    //
    //                       width: MediaQuery.of(context).size.width,
    //                       child: ElevatedButton(
    //                         style: ElevatedButton.styleFrom(
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10.0),
    //                             // side: BorderSide(color: Colors.red)
    //                           ),
    //                           primary: Colors.red,),
    //                         onPressed: () async{
    //
    //                             await editpost();
    //
    //
    //
    //
    //                         },
    //                         child: const Text('post'),
    //                       ),
    //                     ),
    //                   ),
    //
    //
    //
    //
    //                 ]
    //
    //             ),
    //           )
    //       ),
    //     )

    );
  }
}
