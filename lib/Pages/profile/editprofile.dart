import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';


import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:stru2022/Pages/profile/profileInfo.dart';




import '../../Vars/globalss.dart' as globalss;
import 'changpassword.dart';
import 'package:intl/intl.dart';


class Editprofile extends StatefulWidget {
  Map<String, dynamic> pp;
   Editprofile({Key? key,required this.pp}) : super(key: key);

  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {


  //image camera
  final ImagePicker _picker = ImagePicker();
  //end image camera

  File? file;
  String hh = '';
 // late final date = DateTime.now();
  TextEditingController first_name = new TextEditingController();
  TextEditingController last_name = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController whatsapp = new TextEditingController();
  TextEditingController countryy = new TextEditingController();
  TextEditingController Gender = new TextEditingController();
  TextEditingController bd = new TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  Future editProfileimage() async {



    if(first_name.text.isEmpty ||last_name.text.isEmpty ||mobile.text.isEmpty ||whatsapp.text.isEmpty ){
   //   Alert(context: context,image:Image.asset("assets/nm/WRONG.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "profile.All fields required".tr()).show();
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
                  "profile.All fields required".tr(),
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

      return;
    }

    var request = http.MultipartRequest('POST', Uri.parse('https://studyinrussia.app/api/profile/edit'));

    request.headers.addAll({"Authorization": "bearer "+globalss.tokenfromserver});

    request.fields['first_name'] = first_name.text.toString();
    request.fields['last_name'] = last_name.text.toString();
    request.fields['mobile'] = mobile.text.toString();
    request.fields['whatsapp'] = whatsapp.text.toString();
   // "profile.Male".tr()


    if(Gender.value.text.toString() == "profile.Male".tr() ){
      request.fields['gender'] = "0";
    }
    if(Gender.value.text.toString() == "profile.Female".tr()){
      request.fields['gender'] = "1";
    }
    if(Gender.value.text.toString() == "profile.Other".tr()){
      request.fields['gender'] = "2";
    }
    if(Gender.value.text.toString() == "profile.I prefer not to say".tr()){
      request.fields['gender'] = "3";
    }

    request.fields['country'] = countryy.text.toString();

 //   request.fields['birthdate'] = bd.text;

//    print(bd.text);




    if(hh == 'ok'){
      request.files.add(await http.MultipartFile.fromPath('image',file!.path.toString()));
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
      if(convert.json.decode(responsed.body)["code"]==200){
      //  Alert(context: context,image:Image.asset("assets/nm/SUCCESSMESSAGE.png",height: 200,width: 200,fit: BoxFit.fill,), desc: "profile.updated succussfull".tr()).show();
        showDialog(

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
                  "profile.updated succussfull".tr(),
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
                                child: Center(child: Text('ok'.tr()))),

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

        await getnewinfo();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => profileInfoP()));
      }else{
        Alert(context: context, desc: "not updated ").show();

      }




    }
    else {

      Alert(context: context, desc: "ERROR from server").show();

    }

  }

  Future getnewinfo() async {
      var map = new Map<String, dynamic>();
      map['_username'] =  globalss.email;
      map['_password'] = globalss.password;


      final response = await http.post(
          Uri.parse('https://studyinrussia.app/api/login_check'),
          body: map
      );

      if (response.statusCode == 200) {
        if(convert.json.decode(response.body)["code"]==200){
          globalss.tokenfromserver=convert.jsonDecode(response.body)["token"].toString();
          globalss.fname=convert.jsonDecode(response.body)["user"]["firstName"].toString();
          globalss.lname=convert.jsonDecode(response.body)["user"]["lastName"].toString();
          globalss.email=convert.jsonDecode(response.body)["user"]["email"].toString();
          globalss.id=convert.jsonDecode(response.body)["user"]["id"].toString();
          globalss.profileimage=convert.jsonDecode(response.body)["user"]["image"].toString();
        }
      }
      return true;
  }

  @override
  void initState() {
    super.initState();
    first_name = new TextEditingController(text: widget.pp["firstName"]);
    last_name = new TextEditingController(text: widget.pp["lastName"]);
    mobile = new TextEditingController(text: widget.pp["mobile"]);
    whatsapp = new TextEditingController(text: widget.pp["whatsapp"]);
    if(widget.pp["gender"]!=null){
      if(widget.pp["gender"]==0){
        Gender = new TextEditingController(text: "profile.Male".tr());
      }
      if(widget.pp["gender"]==1){
        Gender = new TextEditingController(text: "profile.Female".tr());
      }
      if(widget.pp["gender"]==2){
        Gender = new TextEditingController(text: "profile.Other".tr());
      }
      if(widget.pp["gender"]==3){
        Gender = new TextEditingController(text: "profile.I prefer not to say".tr());
      }

    }
    countryy = new TextEditingController(text: widget.pp["country"]);
  }





  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(

        extendBodyBehindAppBar: true,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            showFab ? SizedBox(
              height: MediaQuery.of(context).size.width *(244/375),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/22images/home/home.png',
                      // color:Theme.of(context).textTheme.headline1!.color,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.width * (244/375),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                      child: Center(
                        child:(hh == "ok")?
                        Container(
                            width:MediaQuery.of(context).size.width * (100/375) ,
                            height: MediaQuery.of(context).size.width * (100/375) ,
                            decoration:BoxDecoration(
                              shape: BoxShape.circle,


                            ),
                            child: ClipRRect(

                              borderRadius: BorderRadius.circular(100),
                                child: Image.file(File(file!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,)),


                        )


                            : CachedNetworkImage(
                          width:MediaQuery.of(context).size.width * (100/375) ,
                          height: MediaQuery.of(context).size.width * (100/375) ,

                          fit: BoxFit.cover,

                          imageUrl:globalss.UrlImageposts +
                              widget.pp["imageurll"],
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // borderRadius: BorderRadius.circular(30),

                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width *(135/375),
                  //  right: 0,
                    top: MediaQuery.of(context).size.width *(150/375),
                   // bottom: 0,
                    child: GestureDetector(
                      onTap: ()async{
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

                                      hh = "";
                                      return;
                                    }
                                    if (photo != null) {
                                      setState(() {
                                        file = File(photo!.path);
                                        hh = "ok";


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

                                      return;
                                    }
                                    if (photo!=null) {
                                      setState(() {
                                        file = File(photo!.path);
                                        hh = "ok";

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
                        // FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'] );
                        //
                        // if (result != null) {
                        //   file = result.files.first;
                        //   hh = 'oky';
                        //   setState(() {});
                        //
                        // } else {
                        //   hh = '';
                        // }

                      },
                      child: Container(

                        width:MediaQuery.of(context).size.width*(24/375),
                        height: MediaQuery.of(context).size.width*(24/375),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffDFDFDF),
                        ),
                        child:
                        Center(
                          child:Icon(Icons.camera_alt_rounded,size: MediaQuery.of(context).size.width*(20/375),color: Color(0xff494949).withOpacity(0.5) )
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,

                    bottom:   MediaQuery.of(context).size.width * (20/375),
                    child: SizedBox(
                      child: Center(
                          child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text(globalss.fname+" "+globalss.lname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),maxLines:1 ,),
                          )
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,color: Colors.white,size: 25),
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => profileInfoP()));
                            },
                  ),
                        ],
                      ))


                ],
              ),
            ) : SizedBox(),


         Padding(
           padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width *(15/375) ,right:MediaQuery.of(context).size.width *(15/375) ),
           child:   Column(
             mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,

             children: [

Column(

  children: [

    TextFormField(

        controller: first_name,

        //enableInteractiveSelection: true,

        decoration: InputDecoration(



        labelText: 'profile.first_name'.tr(),



        floatingLabelBehavior: FloatingLabelBehavior.always,



        //   contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),

        // border:

        // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),

        ),

        validator:(value) {

        if (value == null || value.isEmpty) {

          return 'Please enter some text';

        }

        return null;

        },

    ),



    TextFormField(

        controller: last_name,

        // initialValue:"dfd",

        decoration: InputDecoration(

        // hintText: '',

        labelText: 'profile.last_name'.tr(),



        floatingLabelBehavior: FloatingLabelBehavior.always,

        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),

        // border:

        // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),

        ),

        validator:(value) {

        if (value == null || value.isEmpty) {

          return 'Please enter some text';

        }

        return null;

        },

    ),





    TextFormField(

        controller: mobile,

        decoration: InputDecoration(

        //  hintText: 'mobile',

        labelText: 'profile.mobile'.tr(),



        floatingLabelBehavior: FloatingLabelBehavior.always,

        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),

        // border:

        // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),

        ),

        validator:(value) {

        if (value == null || value.isEmpty) {

          return 'Please enter some text';

        }

        return null;

        },

    ),





    TextFormField(

        controller: whatsapp,

        decoration: InputDecoration(

        //    hintText: 'whatsapp',

        labelText: 'profile.whatsapp'.tr(),



        floatingLabelBehavior: FloatingLabelBehavior.always,

        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),

        // border:

        // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),

        ),

        validator:(value) {

        if (value == null || value.isEmpty) {

          return 'Please enter some text';

        }

        return null;

        },

    ),

    //country

    TextFormField(
      controller: countryy,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'profile.Country'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.arrow_drop_down_outlined),

      ),
      onTap: (){
        showDialog(
          // barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                  content:ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              countryy = TextEditingController(text:countries[index].name);
                            });
                            Navigator.pop(context);

                          },
                          child: Container(


                              child: Text(countries[index].name,style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color  ),)
                          ),
                        ),
                      );
                    },
                  )
              );
            });
      },

      validator:(value) {

        if (value == null || value.isEmpty) {

          return 'Please enter some text';

        }

        return null;

      },

    ),
//gender
    TextFormField(

      controller: Gender,
     readOnly: true,
      decoration: InputDecoration(
        labelText: 'profile.Gender'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.arrow_drop_down_outlined),

      ),

      validator:(value) {

        if (value == null || value.isEmpty) {

          return 'Please enter some text';

        }
        return null;
      },
      onTap: (){
        showDialog(
          // barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                  content:SizedBox(
                    height: MediaQuery.of(context).size.height/3,
                    child: ListView(

                      children: [

                        TextButton(onPressed: (){
                          setState(() {
                            Gender = TextEditingController(text:"profile.Male".tr());
                          });
                          Navigator.pop(context);
                        }, child: Text("profile.Male".tr()) ,),
                        TextButton(onPressed: (){
                          setState(() {
                            Gender = TextEditingController(text:"profile.Female".tr());
                          });
                          Navigator.pop(context);
                        }, child: Text("profile.Female".tr()) ,),
                        TextButton(onPressed: (){
                          setState(() {
                            Gender = TextEditingController(text:"profile.Other".tr());
                          });
                          Navigator.pop(context);
                        }, child: Text("profile.Other".tr()) ,),
                        TextButton(onPressed: (){
                          setState(() {
                            Gender = TextEditingController(text:"profile.I prefer not to say".tr());
                          });
                          Navigator.pop(context);

                        }, child: Text("profile.I prefer not to say".tr()) ,),

                      ],
                    ),
                  )
              );
            });
      },

    ),


    //BIRTHDATE

    DateTimeField(

        format: format,
        controller: bd,

        decoration: InputDecoration(

          //  hintText: 'mobile',

          labelText: 'profile.Date of birth'.tr(),
      //    icon:FaIcon(FontAwesomeIcons.birthdayCake,size: MediaQuery.of(context).size.width * (25/375) ),
        //  prefixIcon: FaIcon(FontAwesomeIcons.birthdayCake,size: MediaQuery.of(context).size.width * (25/375) ),
          suffixIcon: Icon(Icons.arrow_drop_down_outlined),




          floatingLabelBehavior: FloatingLabelBehavior.always,

          // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),

          // border:

          // OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),

        ),


        onShowPicker: (context, currentValue) async {
         final date = await showDatePicker(
            context: context,


            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),

            lastDate: DateTime(2100),
          );
          return date;
        }

    ),




  ],

),


             ],
           ),
         ),


         Column(

           children: [
             Padding(
               padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width *(15/375) ,right:MediaQuery.of(context).size.width *(15/375) ),
               child: Row(
                 children: [
                   Text("profile.I want to".tr()),
                   TextButton(
                       onPressed: (){
                         Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => ChangPassword()));
                       },
                       child: Text("profile.Change my passowrd".tr())
                   )
                 ],
               ),
             ),
             Padding(
               padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width *(15/375) ,right:MediaQuery.of(context).size.width *(15/375),bottom:MediaQuery.of(context).size.width *(5/375)  ),
               child: Container(
                 width: MediaQuery.of(context).size.width*(345/375),
                 height:MediaQuery.of(context).size.width*(38/375),
                 child: ElevatedButton.icon(onPressed: () async{await editProfileimage();},
                   label:  Text("profile.Save Changes".tr()),
                   icon: Icon(Icons.save),
                   style: ElevatedButton.styleFrom(
                     primary: Color(0xFF2429F9),//change background color of button
                     // onPrimary: Colors.yellow,//change text color of button
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                     elevation:0,

                   ),


                 ),
               ),
             ),
           ],
         ),


SizedBox(height: 30,)


            //old

//              SizedBox(height: MediaQuery.of(context).size.height/15,),
// //             Center(
// //               child: Container(
// //                 height: 150,
// //                 width: 150,
// //
// //                 decoration: BoxDecoration(
// //                   color: Theme.of(context).primaryColor,
// //                   borderRadius: BorderRadius.all(Radius.circular(40) ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.grey.withOpacity(0.5),
// //                       spreadRadius: 4,
// //                       blurRadius: 4,
// //                       offset: Offset(0, 3), // changes position of shadow
// //                     ),
// //                   ],),
// //                 //width: 60,
// //                 child: CachedNetworkImage(
// //
// //                   fit: BoxFit.cover,
// //                   imageUrl: globalss.UrlImageposts +
// //                       widget.pp["imageurll"],
// //                   imageBuilder: (context, imageProvider) =>
// //                       Container(
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.rectangle,
// //                           borderRadius: BorderRadius.circular(30),
// //
// //                           image: DecorationImage(
// //                             image: imageProvider,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                       ),
// //                   placeholder: (context, url) => Center(
// //                       child: CircularProgressIndicator()),
// //                   errorWidget: (context, url, error) =>
// //                       Icon(Icons.error),
// //                 ),
// //               ),
// //             ),
// // SizedBox(height: 5,),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 TextButton.icon(
// //                   label: Text("profile.Change photo".tr()),
// //                   onPressed: ()async{
// //                     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'] );
// //
// //                     if (result != null) {
// //                       file = result.files.first;
// //                       hh = 'oky';
// //                       setState(() {});
// //                       //file = result.files.single.path;
// //                       //print(files2[0].toString());
// //                     } else {
// //                       hh = '';
// //                       // User canceled the picker
// //                     }
// //                   },
// //                   icon: Icon(Icons.edit),
// //
// //                 ),
// //                 SizedBox(width: 2,),
// //                 (hh != 'oky')?SizedBox()
// //                     :
// //                 Row(
// //                   children: [
// //                     Image.file(File(file!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,),
// //                     IconButton(onPressed: (){
// //                       file=null;
// //                       hh ="";
// //                       setState(() {});
// //
// //                     }, icon: Icon(Icons.delete,color: Colors.red,))
// //                   ],
// //                 )
// //               ],
// //             ),
//             // Padding(
//             //   padding: const EdgeInsets.only(bottom: 5,top: 5),
//             //   child: Text("first name :",style: TextStyle(color: Color(0xFF2429F9),fontWeight: FontWeight.bold),),
//             // ),
//             SizedBox(height: 10,),
//             TextFormField(
//               controller: first_name,
//               //enableInteractiveSelection: true,
//               decoration: InputDecoration(
//
//                 labelText: 'profile.first_name'.tr(),
//
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//                 border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
//               ),
//               validator:(value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//
//             SizedBox(height: 20,),
//             TextFormField(
//               controller: last_name,
//             // initialValue:"dfd",
//               decoration: InputDecoration(
//                // hintText: '',
//                 labelText: 'profile.last_name'.tr(),
//
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//                 border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
//               ),
//               validator:(value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.only(bottom: 5,top: 5),
//             //   child: Text("mobile :",style: TextStyle(color: Color(0xFF2429F9),fontWeight: FontWeight.bold),),
//             // ),
//             SizedBox(height: 20,),
//             TextFormField(
//               controller: mobile,
//               decoration: InputDecoration(
//               //  hintText: 'mobile',
//                 labelText: 'profile.mobile'.tr(),
//
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//                 border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
//               ),
//               validator:(value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.only(bottom: 5,top: 5),
//             //   child: Text("whatsapp :",style: TextStyle(color: Color(0xFF2429F9),fontWeight: FontWeight.bold),),
//             // ),
//             SizedBox(height: 20,),
//             TextFormField(
//               controller: whatsapp,
//               decoration: InputDecoration(
//             //    hintText: 'whatsapp',
//                 labelText: 'profile.whatsapp'.tr(),
//
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//                 border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
//               ),
//               validator:(value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20,),
//             // Padding(
//             //     padding: const EdgeInsets.only(right: 30,left: 30,top: 20 ,bottom: 5),
//             //     child: Row(
//             //       children: [
//             //         TextButton.icon(
//             //           label: Text("profile.Change photo".tr()),
//             //           onPressed: ()async{
//             //             FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom ,allowedExtensions:['jpg', 'png', 'jpeg','gif'] );
//             //
//             //             if (result != null) {
//             //               file = result.files.first;
//             //               hh = 'oky';
//             //               setState(() {});
//             //               //file = result.files.single.path;
//             //               //print(files2[0].toString());
//             //             } else {
//             //               hh = '';
//             //               // User canceled the picker
//             //             }
//             //           },
//             //           icon: Icon(Icons.upload),
//             //
//             //         ),
//             //         SizedBox(width: 2,),
//             //         (hh != 'oky')?SizedBox()
//             //             :
//             //         Row(
//             //           children: [
//             //             Image.file(File(file!.path.toString(),),height: 50,width: 50,fit:BoxFit.fill ,),
//             //             IconButton(onPressed: (){
//             //               file=null;
//             //               hh ="";
//             //               setState(() {});
//             //
//             //             }, icon: Icon(Icons.delete,color: Colors.red,))
//             //           ],
//             //         )
//             //       ],
//             //     )
//             // ),
//
//             SizedBox(height: 10,),
//             Center(
//               child: Container(
//                 width: MediaQuery.of(context).size.width-60,
//                 child: ElevatedButton.icon(onPressed: () async{await editProfileimage();},
//                   label:  Text("profile.Save Changes".tr()),
//                   icon: Icon(Icons.save),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xFF2429F9),//change background color of button
//                    // onPrimary: Colors.yellow,//change text color of button
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 15.0,
//
//                   ),
//
//
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height/10,),
//           //  SizedBox(height: 30,)

          ],
        ),
      )
    );
  }



}


