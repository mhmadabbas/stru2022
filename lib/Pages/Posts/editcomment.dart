import 'dart:async';
import 'package:easy_localization/easy_localization.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/mywidget/drawer.dart';




import '../../Vars/globalss.dart' as globalss;
import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../kommunicate/prechat.dart';




class Editcomment extends StatefulWidget {
  Map<String, String> pp;
  Editcomment({Key? key,required this.pp}) : super(key: key);

  @override
  _EditcommentState createState() => _EditcommentState();
}

class _EditcommentState extends State<Editcomment> {


  String hh = '';

  TextEditingController comment = new TextEditingController();




  Future editcomment() async {

    var request = http.MultipartRequest('POST', Uri.parse('https://studyinrussia.app/api/comments/${widget.pp["commentid"]}'));

    request.headers.addAll({"Authorization": "bearer "+globalss.tokenfromserver});

    request.fields['comment'] = comment.text.toString();




    var response =await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = convert.json.decode(responsed.body);

    if (response.statusCode==200) {

      if(responseData["code"] == 200){
        Alert(context: context, image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "ApplytoCourse.Success".tr()).show();



      }
      if(responseData["code"] != 200){
        Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "cannot update this comment".tr()).show();

      }

      // print("SUCCESS");
      // print(responseData);
  //    Alert(context: context, title: "SUCCESS", desc: "update succussfull").show();



    }
    else {

      Alert(context: context, title: "ERROR", desc: "ERROR").show();

    }

  }

  @override
  void initState() {
    super.initState();
    comment = new TextEditingController(text: widget.pp["commentbody"].toString());

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
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  fit: BoxFit.contain,
                )

              // Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
            )
          ],
        )
            : null,

        body:Padding(
            padding:  EdgeInsets.all(MediaQuery.of(context).size.width*(31/375)  ),
            child: Container(
              //   height:MediaQuery.of(context).size.width*(156/375) ,
              width:MediaQuery.of(context).size.width*(345/375) ,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                //   color: Colors.red,

              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:MediaQuery.of(context).size.width*(150/375) ,),
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
                          hintText:'post.What do you think about? Type something'.tr(),
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
                          await editcomment();
                        },
                        child:  Text('Edit Comment'.tr()),

                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.width*(100/375) ,),



                  ],
                ),
              ),

            )
        ),

        // Container(
        //   child: SingleChildScrollView(
        //     child: Padding(
        //       padding:  EdgeInsets.only(left: 20,right: 20),
        //       child:
        //
        //       Column(
        //         children: [
        //           SizedBox(height: MediaQuery.of(context).size.height/5 ,),
        //           TextFormField(
        //             controller: comment,
        //             keyboardType: TextInputType.multiline,
        //             maxLines: null,
        //             decoration: InputDecoration(
        //              // hintText: 'comment',
        //               labelText: 'your Comment'.tr(),
        //
        //               floatingLabelBehavior: FloatingLabelBehavior.always,
        //               contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        //               border:
        //               OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        //             ),
        //             validator:(value) {
        //               if (value == null || value.isEmpty) {
        //                 return 'Please enter some text';
        //               }
        //               return null;
        //             },
        //           ),
        //
        //           SizedBox(height: 20 ,),
        //
        //
        //           Container(
        //             width: MediaQuery.of(context).size.width-40,
        //             child: ElevatedButton.icon(
        //               icon: Icon(Icons.save),
        //               onPressed: () async{
        //               await editcomment();
        //             },
        //               label:  Text("Edit comment".tr()),
        //              // child: Text("Edit comment"),
        //               style: ElevatedButton.styleFrom(
        //                 primary: Color(0xFF2429F9),//change background color of button
        //                 // onPrimary: Colors.yellow,//change text color of button
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(15),
        //                 ),
        //                 elevation: 15.0,
        //
        //               ),
        //             ),
        //           ),
        //
        //           SizedBox(height: MediaQuery.of(context).size.height/5 ,),
        //
        //         ],
        //       ),
        //     ),
        //   ),
        //
        // )
    );
  }
}
