import 'dart:convert';



import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/mywidget/botombar.dart';
import 'package:stru2022/mywidget/drawer.dart';




import '../../Vars/globalss.dart' as globalss;
import 'dart:io';
import 'dart:convert' as convert;

import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';

import '../kommunicate/prechat.dart';
import 'ownPosts.dart';


class createpost extends StatefulWidget {
  const createpost({Key? key}) : super(key: key);

  @override
  _createpostState createState() => _createpostState();
}

class _createpostState extends State<createpost> {


  //image camera
  final ImagePicker _picker = ImagePicker();
  //end image camera
  //for activate post button
  bool eimg = false;
  bool et = false;
  bool ec = false;
  //for activate post button

  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();


  File? filee;
String hh = '';

  final _formKeyup = GlobalKey<FormState>();

createpost() async {



    var request = http.MultipartRequest('POST', Uri.parse('https://studyinrussia.app/api/posts'));

    request.headers.addAll({"Authorization": "bearer "+globalss.tokenfromserver});

    request.fields['title'] = title.text.toString();
    request.fields['content'] = content.text.toString();
if(hh == 'ok'){
  request.files.add(await http.MultipartFile.fromPath('media',filee!.path.toString()));
}


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
    var response =await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = convert.json.decode(responsed.body);

    if (response.statusCode==200) {
      // print("SUCCESS");
      // print(responseData);
      if(jsonDecode(responsed.body)["code"]==200){
        Navigator.pop(context);
      //  Alert(context: context, image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "post.your post published succussfuly".tr()).show();
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
                  "post.your post published succussfuly".tr(),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OwnPosts()),
                            );

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


        title.clear();
        content.clear();
      }else{
       // Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "post.you cannot post".tr()).show();

        Navigator.pop(context);
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
                  "post.you cannot post".tr(),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OwnPosts()),
                            );

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
    else {

     // Alert(context: context, title: "", desc: "").show();
      Navigator.pop(context);

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

                                Text("post.New post".tr(),style:TextStyle(fontSize: 30,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

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
                                                    ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
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
                                                                    filee = File(photo!.path);
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
                                                                    filee = File(photo!.path);
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
                                                                          filee =null;
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
                        icon: Icon(Icons.post_add),
                        label:Text('post.post'.tr()),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),

                          ),
                          primary: globalss.cblue,
                        ),

                        onPressed:(eimg && et && ec )?
                            () async{
                          if(hh == 'ok'){
                            await createpost();
                          }
                          else{
                            Alert(context: context,

                                desc:'post.you should select image file'.tr()).show();

                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text('post.you should select image file'.tr()),
                            // ));
                          }
                          }
                          :
                        null,

                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*(20/375),)
                  ],
                ),

              ],
            ),
          ),
        )

    );
  }
}
