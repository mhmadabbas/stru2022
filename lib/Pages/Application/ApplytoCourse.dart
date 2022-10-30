import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:stru2022/mywidget/drawer.dart';


import 'dart:convert' as convert;
import '../../Vars/globalss.dart' as globalss;
import '../../mywidget/appbarimagewithoutsearch.dart';
import '../../mywidget/botombarnew.dart';
import '../Siginin.dart';
import '../kommunicate/prechat.dart';
import 'ownapplication.dart';


class MyApp50 extends StatefulWidget {
  const MyApp50({Key? key}) : super(key: key);


  @override
  _MyApp50State createState() => _MyApp50State();
}

class _MyApp50State extends State<MyApp50> {

  //image camera
  final ImagePicker _picker = ImagePicker();
  //end image camera
  //for activate post button



  //for activate post button
//file neew

  File? filee;

  List<XFile> filesstore0 = [];
  List<XFile>? files0 = [];
  changeText0() {setState(() {textHolder0 = filesstore0!.length.toString();});}

  List<XFile> filesstore1 = [];
  List<XFile>? files1 = [];
  changeText1() {setState(() {textHolder1 = filesstore1!.length.toString();});}

  List<XFile> filesstore2 = [];
  List<XFile>? files2 = [];
  changeText2() {setState(() {textHolder2 = filesstore2!.length.toString();});}

  List<XFile> filesstore3 = [];
  List<XFile>? files3 = [];
  changeText3() {setState(() {textHolder3 = filesstore3!.length.toString();});}

  List<XFile> filesstore4 = [];
  List<XFile>? files4 = [];
  changeText4() {setState(() {textHolder4 = filesstore4!.length.toString();});}

  List<XFile> filesstore5 = [];
  List<XFile>? files5 = [];
  changeText5() {setState(() {textHolder5 = filesstore5!.length.toString();});}


  //
String textHolder0='0';
String textHolder1='0';
String textHolder2='0';
String textHolder3='0';
String textHolder4='0';
String textHolder5='0';
String textHolder6='0';

//changeText1() {setState(() {textHolder1 = filesstore1.length.toString();});}
//changeText2() {setState(() {textHolder2 = filesstore2.length.toString();});}
//changeText3() {setState(() {textHolder3 = filesstore3.length.toString();});}
//changeText4() {setState(() {textHolder4 = filesstore4.length.toString();});}
//changeText5() {setState(() {textHolder5 = filesstore5.length.toString();});}
changeText6() {setState(() {textHolder6 = filesstore6.length.toString();});}

 // List<File> files1 = [];
 // List<File> files2 = [];
 // List<File> files3 = [];
 // List<File> files4 = [];
 // List<File> files5 = [];
  List<File> files6 = [];

//List<File> filesstore1 = [];
//List<File> filesstore2 = [];
//List<File> filesstore3 = [];
//List<File> filesstore4 = [];
//List<File> filesstore5 = [];
List<File> filesstore6 = [];

   uploadFile() async {

     if(filesstore0.isEmpty || filesstore2.isEmpty ){

    //   Alert(context: context,   image:Image.asset("assets/nm/WARNING.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "ApplytoCourse.you should upload required document".tr()).show();
       showDialog(
         // barrierDismissible: false,
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
                 "ApplytoCourse.you should upload required document".tr(),
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

     }else{

       var request = http.MultipartRequest('POST', Uri.parse('https://studyinrussia.app/api/scholar/apply'));

       request.headers.addAll({"Authorization": "bearer "+globalss.tokenfromserver});

       request.fields['sub_course'] = globalss.SubCourseids.toString();

       for(int i = 0; i < filesstore0!.length; i++){
         request.files.add(await http.MultipartFile.fromPath('file_type_1[]',filesstore0![i].path));
       }
       for(int i = 0; i < filesstore1.length; i++){
         request.files.add(await http.MultipartFile.fromPath('file_type_2[]',filesstore1[i].path));
       }
       for(int i = 0; i < filesstore2.length; i++){
         request.files.add(await http.MultipartFile.fromPath('file_type_3[]',filesstore2[i].path));
       }
       for(int i = 0; i < filesstore3.length; i++){
         request.files.add(await http.MultipartFile.fromPath('file_type_4[]',filesstore3[i].path));
       }
       for(int i = 0; i < filesstore4.length; i++){
         request.files.add(await http.MultipartFile.fromPath('file_type_5[]',filesstore4[i].path));
       }
       for(int i = 0; i < filesstore5.length; i++){
         request.files.add(await http.MultipartFile.fromPath('file_type_6[]',filesstore5[i].path));
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
       final responseDatacode = convert.json.decode(responsed.body)["code"];
       print(responseData);
       if (responsed.statusCode==200) {

         print(responseData["code"]);
         if(responseData["code"]==200){
        //   Alert(context: context,   image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,), title: "ApplytoCourse.Success".tr(), desc: "").show();
           showDialog(
             // barrierDismissible: false,
               context: context,
               builder: (BuildContext context) {
                 return AlertDialog(

                   shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                   title: Row(
                     children: [
                       Icon(Icons.upload_file)
                     ],
                   ),
                   content: Text(
                     "Your application has been successfully sent to our team".tr(),
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
                               Navigator.pushReplacement(
                                 context,
                                 MaterialPageRoute(builder: (context) => ownapp()),
                               );

                             },
                               child:  SizedBox(
                                 // width:
                                 // MediaQuery.of(context).size.width *(144/375),
                                   child: Center(child: Text("intro.Continue".tr()))),

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
         if(responseData["code"]==400){
        //   Alert(context: context,   image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), title: "ApplytoCourse.Failed".tr(), desc: "ApplytoCourse.Already applied to this course".tr()).show();

           showDialog(
             // barrierDismissible: false,
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
                     "ApplytoCourse.Already applied to this course".tr(),
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

       else {

      //   Alert(context: context,   image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), title: "ApplytoCourse.ERROR".tr(), desc: "ApplytoCourse.check internet connection".tr()).show();
         showDialog(
            // barrierDismissible: false,
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
                   "ApplytoCourse.check internet connection".tr(),
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


      body: ListView(
        padding: EdgeInsets.only(
         bottom:  MediaQuery.of(context).size.width*(10/375), top: MediaQuery.of(context).size.width*(10/375),right:  MediaQuery.of(context).size.width*(15/375),left:  MediaQuery.of(context).size.width*(15/375)
        ),

        children: [
          //SizedBox(height: 10,),
//label
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)
              ),

              Text("ApplytoCourse.Documents upload".tr(),style:TextStyle(fontSize: 22,color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold),),

            ],
          ),



          // 1 High School Transcript
          (filesstore0.length == 0)?
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
                      child:
                      // (hh=="ok")?
                      // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                      //     :
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
                                    if (photo != null) {
                                      setState(() {
                                        filee = File(photo!.path);
                                        filesstore0.add(photo);
                                        changeText0();

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

                                   final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                   if (selectedImages!=null) {
                                      setState(() {
                                       filesstore0.addAll(selectedImages);
                                       changeText0();




                                     });
                                   //   files1 = result.paths.map((path) => File(path!)).toList();
                                    //  filesstore1.addAll(files1);
                                   //   changeText1();
                                    //  final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
                                  //    filesstore1.addAll(files1);
                                  //    changeText1();

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
                                      child: Text("ApplytoCourse.Reqired".tr(),
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

                          Text('ApplytoCourse.High School Transcript *'.tr()+' ['+textHolder0+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  filee =null;

                                });


                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),

          )
          :
          SizedBox(
            height:MediaQuery.of(context).size.width*(160/375),
            width:MediaQuery.of(context).size.width*(345/375) ,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: filesstore0.length,

                itemBuilder: (context, i){
                  return
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
                                child:
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filesstore0[i].path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                // (hh=="ok")?
                                // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                //     :
                               // SizedBox(),

                              )
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.width*(38/375),
                              right:MediaQuery.of(context).size.width*(150/375) ,
                              left:MediaQuery.of(context).size.width*(150/375) ,

                              child: IconButton(
                                icon:Icon(Icons.camera_alt_rounded,color:
                                  Colors.black,
                                //Color(0xff494949).withOpacity(0.2),
                                    size: MediaQuery.of(context).size.width*(38/375)) ,
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
                                              if (photo != null) {
                                                setState(() {
                                                  filee = File(photo!.path);
                                                  filesstore0.add(photo);
                                                  changeText0();

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

                                              final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                              if (selectedImages!=null) {
                                                setState(() {
                                                  filesstore0.addAll(selectedImages);
                                                  changeText0();




                                                });
                                                //   files1 = result.paths.map((path) => File(path!)).toList();
                                                //  filesstore1.addAll(files1);
                                                //   changeText1();
                                                //  final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
                                                //    filesstore1.addAll(files1);
                                                //    changeText1();

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
                                                child: Text("ApplytoCourse.Reqired".tr(),
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

                                    Text('ApplytoCourse.High School Transcript *'.tr()+' ['+textHolder0+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            filesstore0.removeAt(i);
                                            changeText0();

                                          });


                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    );



                }

            ),
          ),
          // end 1


          //2
          (filesstore1.length == 0)?
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
                      child:
                      // (hh=="ok")?
                      // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                      //     :
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
                                    if (photo != null) {
                                      setState(() {
                                        //filee = File(photo!.path);
                                        filesstore1.add(photo);
                                        changeText1();

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

                                    final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                    if (selectedImages!=null) {
                                      setState(() {
                                        filesstore1.addAll(selectedImages);
                                        changeText1();




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
                // Positioned(
                //     top: MediaQuery.of(context).size.width*(15/375),
                //     right:MediaQuery.of(context).size.width*(15/375) ,
                //     left:MediaQuery.of(context).size.width*(15/375) ,
                //
                //     child:Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         SizedBox(
                //           width: MediaQuery.of(context).size.width*(60/375),
                //           height: MediaQuery.of(context).size.width*(23/375),
                //
                //
                //           child: ElevatedButton(
                //
                //             style: ElevatedButton.styleFrom(
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(20.0),
                //
                //               ),
                //               shadowColor:Colors.transparent,
                //               elevation:0 ,
                //               primary: Color(0xff494949),
                //             ),
                //             onPressed: () {
                //
                //             },
                //             child: Center(
                //                 child: Padding(
                //                   padding: EdgeInsets.only(left: 1.0,right:1 ),
                //                   child: SizedBox(
                //                     width: MediaQuery.of(context).size.width*(60/375),
                //                     child: FittedBox(
                //                       child: Text("ApplytoCourse.Reqired".tr(),
                //                         style: TextStyle(
                //                             color: Colors.white,fontSize: 14),),
                //                     ),
                //                   ),
                //                 )
                //             ),
                //           ),
                //         ),
                //       ],
                //     )
                // ),
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

                          Text('ApplytoCourse.Recommendation Letters'.tr()+' ['+textHolder1+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  filee =null;

                                });


                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),

          )
              :
          SizedBox(
            height:MediaQuery.of(context).size.width*(160/375),
            width:MediaQuery.of(context).size.width*(345/375) ,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: filesstore1.length,

                itemBuilder: (context, i){
                  return
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
                                  child:
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filesstore1[i].path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                // (hh=="ok")?
                                // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                //     :
                                // SizedBox(),

                              )
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.width*(38/375),
                              right:MediaQuery.of(context).size.width*(150/375) ,
                              left:MediaQuery.of(context).size.width*(150/375) ,

                              child: IconButton(
                                icon:Icon(Icons.camera_alt_rounded,color:
                                Colors.black,
                                    //Color(0xff494949).withOpacity(0.2),
                                    size: MediaQuery.of(context).size.width*(38/375)) ,
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
                                              if (photo != null) {
                                                setState(() {
                                                 // filee = File(photo!.path);
                                                  filesstore1.add(photo);
                                                  changeText1();

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

                                              final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                              if (selectedImages!=null) {
                                                setState(() {

                                                  filesstore1.addAll(selectedImages);
                                                  changeText1();




                                                });


                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                          Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                          ElevatedButton(

                                            onPressed: () async{
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

                                    Text('ApplytoCourse.Recommendation Letters'.tr()+' ['+textHolder1+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            filesstore1.removeAt(i);
                                            changeText1();

                                          });


                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    );



                }

            ),
          ),

          //end 2

          // Padding(
          //   padding: EdgeInsets.only(right: 10,left: 10,bottom: 5),
          //
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(8),),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.5),
          //           spreadRadius: 4,
          //           blurRadius: 4,
          //           offset: Offset(0, 3), // changes position of shadow
          //         ),
          //       ],),
          //     child: ListTile(
          //       title:Text('ApplytoCourse.High School Transcript *'.tr(),style: TextStyle(color: Colors.red),) ,
          //       onTap: ()async{
          //         FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'],);
          //
          //
          //         if (result != null) {
          //           files1 = result.paths.map((path) => File(path!)).toList();
          //           filesstore1.addAll(files1);
          //           changeText1();
          //
          //         } else {
          //           // User canceled the picker
          //         }
          //       },
          //       subtitle:Text(textHolder1+"ApplytoCourse.Copies".tr(),style: TextStyle(color: Colors.lightBlueAccent),) ,
          //       leading:Container(
          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),   color:Colors.blue,),
          //         height: 50,
          //         width: 50,
          //         child:SvgPicture.asset('assets/SVG_ICONS/Applications.svg',color: Colors.white ,fit:BoxFit.cover ,),
          //       ),
          //
          //     ),
          //   ),
          // ),
          // (filesstore1.length==0)?SizedBox(height: 1,):
          // SizedBox(
          //   height: 60,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //
          //     itemCount: filesstore1.length,
          //
          //       itemBuilder: (context, i){
          //         return SizedBox(
          //           height: 50,
          //           width: 120,
          //           child: ListTile(
          //             leading: Image.file(File(filesstore1[i].path),height: 50,width: 50,fit:BoxFit.fill ,),
          //             trailing: IconButton(onPressed: (){
          //
          //
          //               setState((){
          //                 filesstore1.removeAt(i);
          //                 changeText1();
          //               });
          //               changeText1();
          //             },icon: Icon(Icons.close,color: Colors.red,),),
          //             dense: true,
          //           ),
          //         );
          //
          //       }
          //
          //   ),
          // ),
          //
          // Padding(
          //   padding: EdgeInsets.only(right: 10,left: 10,bottom: 5),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(8),),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.5),
          //           spreadRadius: 4,
          //           blurRadius: 4,
          //           offset: Offset(0, 3), // changes position of shadow
          //         ),
          //       ],),
          //     child: ListTile(
          //       title:Text('ApplytoCourse.Recommendation Letters'.tr()) ,
          //       onTap: ()async{
          //         FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'],);
          //
          //
          //         if (result != null) {
          //           files2 = result.paths.map((path) => File(path!)).toList();
          //           filesstore2.addAll(files2);
          //           //print(files2.toString());
          //           changeText2();
          //         } else {
          //           // User canceled the picker
          //         }
          //       },
          //       subtitle:Text(textHolder2+"ApplytoCourse.Copies".tr(),style: TextStyle(color: Colors.lightBlueAccent),) ,
          //       leading:Container(
          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),   color:Colors.blue,),
          //         height: 50,
          //         width: 50,
          //         child:SvgPicture.asset('assets/SVG_ICONS/Applications.svg',color: Colors.white ,fit:BoxFit.cover ,),
          //       ),
          //     ),
          //   ),
          // ),

          //3

          (filesstore2.length == 0)?
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
                      child:
                      // (hh=="ok")?
                      // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                      //     :
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
                                    if (photo != null) {
                                      setState(() {
                                        //filee = File(photo!.path);
                                        filesstore2.add(photo);
                                        changeText2();

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

                                    final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                    if (selectedImages!=null) {
                                      setState(() {
                                        filesstore2.addAll(selectedImages);
                                        changeText2();




                                      });


                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                ElevatedButton(

                                  onPressed: () async{    Navigator.pop(context);
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
                                      child: Text("ApplytoCourse.Reqired".tr(),
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

                          Text('ApplytoCourse.Passport Copy *'.tr()+' ['+textHolder2+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  filee =null;

                                });


                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),

          )
              :
          SizedBox(
            height:MediaQuery.of(context).size.width*(160/375),
            width:MediaQuery.of(context).size.width*(345/375) ,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: filesstore2.length,

                itemBuilder: (context, i){
                  return
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
                                  child:
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filesstore2[i].path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                // (hh=="ok")?
                                // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                //     :
                                // SizedBox(),

                              )
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.width*(38/375),
                              right:MediaQuery.of(context).size.width*(150/375) ,
                              left:MediaQuery.of(context).size.width*(150/375) ,

                              child: IconButton(
                                icon:Icon(Icons.camera_alt_rounded,color:
                                Colors.black,
                                    //Color(0xff494949).withOpacity(0.2),
                                    size: MediaQuery.of(context).size.width*(38/375)) ,
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
                                              if (photo != null) {
                                                setState(() {
                                                  // filee = File(photo!.path);
                                                  filesstore2.add(photo);
                                                  changeText2();

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

                                              final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                              if (selectedImages!=null) {
                                                setState(() {

                                                  filesstore2.addAll(selectedImages);
                                                  changeText2();




                                                });


                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                          Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                          ElevatedButton(

                                            onPressed: () async{
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
                                                child: Text("ApplytoCourse.Reqired".tr(),
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

                                    Text('ApplytoCourse.High School Transcript *'.tr()+' ['+textHolder2+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            filesstore2.removeAt(i);
                                            changeText2();

                                          });


                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    );



                }

            ),
          ),
          //end 3



          // (filesstore2.length==0)?SizedBox(height: 1,):
          // SizedBox(
          //   height: 60,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //
          //       itemCount: filesstore2.length,
          //
          //       itemBuilder: (context, i){
          //         return SizedBox(
          //           height: 50,
          //           width: 120,
          //           child: ListTile(
          //             leading: Image.file(File(filesstore2[i].path),height: 50,width: 50,fit:BoxFit.fill ,),
          //
          //             trailing: IconButton(onPressed: (){
          //
          //
          //               setState((){
          //                 filesstore2.removeAt(i);
          //                 changeText2();
          //               });
          //               changeText2();
          //             },icon: Icon(Icons.close,color: Colors.red),),
          //             dense: true,
          //           ),
          //         );
          //
          //       }
          //
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(right: 10,left: 10,bottom: 5),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(8),),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.5),
          //           spreadRadius: 4,
          //           blurRadius: 4,
          //           offset: Offset(0, 3), // changes position of shadow
          //         ),
          //       ],),
          //     child: ListTile(
          //       title:Text('ApplytoCourse.Passport Copy *'.tr(),style: TextStyle(color: Colors.red)) ,
          //       onTap: ()async{
          //         FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'],);
          //
          //         if (result != null) {
          //           files3 = result.paths.map((path) => File(path!)).toList();
          //           filesstore3.addAll(files3);
          //           print(files3.toString());
          //           changeText3();
          //         } else {
          //           // User canceled the picker
          //         }
          //       },
          //       subtitle:Text(textHolder3+"ApplytoCourse.Copies".tr(),style: TextStyle(color: Colors.lightBlueAccent),) ,
          //       leading:Container(
          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),   color:Colors.blue,),
          //         height: 50,
          //         width: 50,
          //         child:SvgPicture.asset('assets/SVG_ICONS/Applications.svg',color: Colors.white ,fit:BoxFit.cover ,),
          //       ),
          //     ),
          //   ),
          // ),

          //4


          (filesstore3.length == 0)?
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
                      child:
                      // (hh=="ok")?
                      // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                      //     :
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
                                    if (photo != null) {
                                      setState(() {
                                        //filee = File(photo!.path);
                                        filesstore3.add(photo);
                                        changeText3();

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

                                    final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                    if (selectedImages!=null) {
                                      setState(() {
                                        filesstore3.addAll(selectedImages);
                                        changeText3();




                                      });


                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                ElevatedButton(

                                  onPressed: () async{    Navigator.pop(context);
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

                          Text('ApplytoCourse.Personal Statement'.tr()+' ['+textHolder3+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  filee =null;

                                });


                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),

          )
              :
          SizedBox(
            height:MediaQuery.of(context).size.width*(160/375),
            width:MediaQuery.of(context).size.width*(345/375) ,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: filesstore3.length,

                itemBuilder: (context, i){
                  return
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
                                  child:
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filesstore3[i].path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                // (hh=="ok")?
                                // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                //     :
                                // SizedBox(),

                              )
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.width*(38/375),
                              right:MediaQuery.of(context).size.width*(150/375) ,
                              left:MediaQuery.of(context).size.width*(150/375) ,

                              child: IconButton(
                                icon:Icon(Icons.camera_alt_rounded,color:
                                Colors.black,
                                    //Color(0xff494949).withOpacity(0.2),
                                    size: MediaQuery.of(context).size.width*(38/375)) ,
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
                                              if (photo != null) {
                                                setState(() {
                                                  // filee = File(photo!.path);
                                                  filesstore3.add(photo);
                                                  changeText3();

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

                                              final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                              if (selectedImages!=null) {
                                                setState(() {

                                                  filesstore3.addAll(selectedImages);
                                                  changeText3();




                                                });


                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                          Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                          ElevatedButton(

                                            onPressed: () async{
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

                                    Text('ApplytoCourse.Personal Statement'.tr()+' ['+textHolder3+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            filesstore3.removeAt(i);
                                            changeText3();

                                          });


                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    );



                }

            ),
          ),
          //e
          // nd 4

          //
          // (filesstore3.length==0)?SizedBox(height: 1,):
          // SizedBox(
          //   height: 60,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //
          //       itemCount: filesstore3.length,
          //
          //       itemBuilder: (context, i){
          //         return SizedBox(
          //           height: 50,
          //           width: 120,
          //           child: ListTile(
          //             leading: Image.file(File(filesstore3[i].path),height: 50,width: 50,fit:BoxFit.fill ,),
          //
          //             trailing: IconButton(onPressed: (){
          //
          //
          //               setState((){
          //                 filesstore3.removeAt(i);
          //                 changeText3();
          //               });
          //               changeText3();
          //             },icon: Icon(Icons.close,color: Colors.red),),
          //             dense: true,
          //
          //           ),
          //         );
          //
          //       }
          //
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(right: 10,left: 10,bottom: 5),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(8),),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.5),
          //           spreadRadius: 4,
          //           blurRadius: 4,
          //           offset: Offset(0, 3), // changes position of shadow
          //         ),
          //       ],),
          //     child: ListTile(
          //       title:Text('ApplytoCourse.Personal Statement'.tr()) ,
          //       onTap: ()async{
          //         FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'],);
          //
          //         if (result != null) {
          //           files4 = result.paths.map((path) => File(path!)).toList();
          //           filesstore4.addAll(files4);
          //           changeText4();
          //         } else {
          //           // User canceled the picker
          //         }
          //       },
          //       subtitle:Text(textHolder4+"ApplytoCourse.Copies".tr(),style: TextStyle(color: Colors.lightBlueAccent),) ,
          //       leading:Container(
          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),   color:Colors.blue,),
          //         height: 50,
          //         width: 50,
          //         child:SvgPicture.asset('assets/SVG_ICONS/Applications.svg',color: Colors.white ,fit:BoxFit.cover ,),
          //       ),
          //     ),
          //   ),
          // ),


          //5


          (filesstore4.length == 0)?
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
                      child:
                      // (hh=="ok")?
                      // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                      //     :
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
                                    if (photo != null) {
                                      setState(() {
                                        //filee = File(photo!.path);
                                        filesstore4.add(photo);
                                        changeText4();

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

                                    final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                    if (selectedImages!=null) {
                                      setState(() {
                                        filesstore4.addAll(selectedImages);
                                        changeText4();




                                      });


                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                ElevatedButton(

                                  onPressed: () async{    Navigator.pop(context);
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

                          Text('ApplytoCourse.English Proficiency Test'.tr()+' ['+textHolder4+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  filee =null;

                                });


                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),

          )
              :
          SizedBox(
            height:MediaQuery.of(context).size.width*(160/375),
            width:MediaQuery.of(context).size.width*(345/375) ,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: filesstore4.length,

                itemBuilder: (context, i){
                  return
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
                                  child:
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filesstore4[i].path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                // (hh=="ok")?
                                // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                //     :
                                // SizedBox(),

                              )
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.width*(38/375),
                              right:MediaQuery.of(context).size.width*(150/375) ,
                              left:MediaQuery.of(context).size.width*(150/375) ,

                              child: IconButton(
                                icon:Icon(Icons.camera_alt_rounded,color:
                                Colors.black,
                                    //Color(0xff494949).withOpacity(0.2),
                                    size: MediaQuery.of(context).size.width*(38/375)) ,
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
                                              if (photo != null) {
                                                setState(() {
                                                  // filee = File(photo!.path);
                                                  filesstore4.add(photo);
                                                  changeText4();

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

                                              final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                              if (selectedImages!=null) {
                                                setState(() {

                                                  filesstore4.addAll(selectedImages);
                                                  changeText4();




                                                });


                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                          Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                          ElevatedButton(

                                            onPressed: () async{
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

                                    Text('ApplytoCourse.English Proficiency Test'.tr()+' ['+textHolder4+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            filesstore4.removeAt(i);
                                            changeText4();

                                          });


                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    );



                }

            ),
          ),


         // end 5

          //6

          (filesstore5.length == 0)?
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
                      child:
                      // (hh=="ok")?
                      // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                      //     :
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
                                    if (photo != null) {
                                      setState(() {
                                        //filee = File(photo!.path);
                                        filesstore5.add(photo);
                                        changeText5();

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

                                    final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                    if (selectedImages!=null) {
                                      setState(() {
                                        filesstore5.addAll(selectedImages);
                                        changeText5();




                                      });


                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                ElevatedButton(

                                  onPressed: () async{    Navigator.pop(context);
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

                          Text('ApplytoCourse.Extra Documents'.tr()+' ['+textHolder5+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  filee =null;

                                });


                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),

          )
              :
          SizedBox(
            height:MediaQuery.of(context).size.width*(160/375),
            width:MediaQuery.of(context).size.width*(345/375) ,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: filesstore5.length,

                itemBuilder: (context, i){
                  return
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
                                  child:
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filesstore5[i].path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                // (hh=="ok")?
                                // ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(filee!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,))
                                //     :
                                // SizedBox(),

                              )
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.width*(38/375),
                              right:MediaQuery.of(context).size.width*(150/375) ,
                              left:MediaQuery.of(context).size.width*(150/375) ,

                              child: IconButton(
                                icon:Icon(Icons.camera_alt_rounded,color:
                                Colors.black,
                                    //Color(0xff494949).withOpacity(0.2),
                                    size: MediaQuery.of(context).size.width*(38/375)) ,
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
                                              if (photo != null) {
                                                setState(() {
                                                  // filee = File(photo!.path);
                                                  filesstore5.add(photo);
                                                  changeText5();

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

                                              final List<XFile>? selectedImages = await _picker.pickMultiImage();
                                              if (selectedImages!=null) {
                                                setState(() {

                                                  filesstore5.addAll(selectedImages);
                                                  changeText5();




                                                });


                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                          Divider(thickness : 1,color: Colors.black.withOpacity(0.1)),



                                          ElevatedButton(

                                            onPressed: () async{
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

                                    Text('ApplytoCourse.Extra Documents'.tr()+' ['+textHolder5+"]",style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 16,fontWeight: FontWeight.bold ),) ,
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            filesstore5.removeAt(i);
                                            changeText5();

                                          });


                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    );



                }

            ),
          ),


          //end 6





          //button
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom:40 ),

            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),


                  ),



                  primary: Color(0xFF170AEA),),

                onPressed: ()async{
                  await uploadFile();
                },
                child:  Text('ApplytoCourse.submit for review'.tr(),style:TextStyle(color: Colors.white), ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

