

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stru2022/mywidget/appbarimagewithoutsearch.dart';
import 'package:stru2022/mywidget/drawer.dart';
import '../../Model/alumni/alumniintro.dart';
import '../../mywidget/botombarnew.dart';

import '../kommunicate/prechat.dart';
import '/Vars/globalss.dart' as globalss ;

class consultation extends StatefulWidget {


  consultation({Key? key}) : super(key: key);

  @override
  _consultationState createState() => _consultationState();
}

class _consultationState extends State<consultation> {
  List<Datum> dataa = [];

  TextEditingController phone = new TextEditingController();
  TextEditingController Last = new TextEditingController();
  TextEditingController Number = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController study = new TextEditingController();
  TextEditingController studyfor = new TextEditingController();
  TextEditingController work = new TextEditingController();
  TextEditingController workfor = new TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm");

  String cc="7";
  DateTime dt = DateTime.now();

  Future Consultation() async {
    var alertStyle = AlertStyle(
      titleStyle:
      TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      descStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      isCloseButton: false,
    );


    // if(subject.text.isEmpty||message.text.isEmpty){
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('ContactUs.All fields required'.tr()),
    //   ));
    //   return;
    // }



    //  else{
    var map = new Map<String, dynamic>();


    map['country'] = "46";
    map['phone'] =  "76543";
    map['date'] =DateTime.now();
  //  var parsedDate =DateTime.tryParse('1922-06-06 00:00:00.000Z');

  //  map['date'] =  DateTime.utc(1969, 7, 20, 20, 18, 04);
 //   final moonLanding = DateTime.utc(1969, 7, 20, 20, 18, 04);
  //  map['date'] = moonLanding;


    String Url = 'https://studyinrussia.app/api/consult';
    var response = await http.post(
        Uri.parse(Url),
        headers: {"Authorization": "bearer "+globalss.tokenfromserver},
        body: map
    );
    print(response.body.toString());
    if(response.statusCode == 200){
      //  String message = convert.json.decode(response.body)['message'].toString();
      String code = convert.json.decode(response.body)['code'].toString();
      if(code == "400"){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("ContactUs.some error happend".tr()),
        ));
      }
      if(code == "200"){
        String message = convert.json.decode(response.body)['message'].toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
        Alert(
          context: context,
          type: AlertType.success,
          //   title: "RFLUTTER ALERT3",
          desc: "Message sent successfully!.",
          buttons: [
            DialogButton(
              child: Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            ),
            DialogButton(
              child: Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            ),

          ],
        ).show();

      }
      return null;

    }else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('ContactUs.Check internet connection'.tr()),
      ));
      return null;
    }


    //   }



  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
        endDrawer: MyDrawer(),
        appBar: ApplicationToolbarnosearch(),
        bottomNavigationBar: myBottomAppBarnew(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab?
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 25,),
            FloatingActionButton(
                elevation: 0,



                backgroundColor:Theme.of(context).textTheme.headline6!.color,

                // shape: BoxShape.circle,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PreChatPage()));
                },
                child:
                SvgPicture.asset(
                  'assets/svgicon/chatlastsvg.svg',
                  // width: 20,
                  color:Theme.of(context).textTheme.bodyText2!.color,
                  fit: BoxFit.contain,

                )

              // Image.asset('assets/image/studyinrussialogopng2.png',fit: BoxFit.fill,),
            )
          ],
        )

            :null,

        body:Padding(
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375),top:MediaQuery.of(context).size.width*(15/375) ,bottom:MediaQuery.of(context).size.width*(15/375)),
          child: SingleChildScrollView(

            child: Container(
         decoration: BoxDecoration(
           color: Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius:
              BorderRadius.all(
                Radius.circular(20),
              ),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.5),
               spreadRadius: 1,
               blurRadius: 1,

             ),
           ],

            ),
              child: Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),

                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
SizedBox(height: MediaQuery.of(context).size.width*(26/375),),

                    Image.asset("assets/22images/consultation.png",color: Theme.of(context).textTheme.headline1!.color,),
                    SizedBox(height: MediaQuery.of(context).size.width*(15/375),),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,

                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: "phone".tr(),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        //initialCountryCode: 'ru',
                        initialCountryCode: 'RU',

                        onChanged: (phone) {
                          cc = phone.toString();
                          print(phone);
                        },
                        onCountryChanged:  (phone) {
                          cc = phone.dialCode.toString();
                          print(phone.dialCode);
                        },
                      ),
                    ),
                    // TextFormField(
                    //   controller: phone,
                    //   decoration: InputDecoration(
                    //       label: Text("phone".tr(),style: TextStyle(color: (Theme.of(context).textTheme.bodyText2!.color)),),
                    //       floatingLabelBehavior:
                    //       FloatingLabelBehavior.auto),
                    //
                    // ),

                    SizedBox(height: MediaQuery.of(context).size.width*(15/375),),
                    DateTimeField(
                      format: format,
                      decoration: InputDecoration(

                        //  hintText: 'mobile',

                        labelText: 'Сonvenient time to call'.tr(),
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
                            firstDate: DateTime(2022),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime:
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          print(DateTimeField.combine(date, time));
                          dt = DateTimeField.combine(date, time);
                          return DateTimeField.combine(date, time);
                        } else {
print(currentValue);
                          return currentValue;
                        }
                      },
                    ),

                    Text("Key in the phone number which you registered in your country and we will call you".tr()),


                    SizedBox(height: 10,),
                    Padding(
                      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*(15/375),right: MediaQuery.of(context).size.width*(15/375)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),

                            ),
                            primary: globalss.cblue),
                        onPressed: () async {
                       //   await  Consultation();

                        },
                        child: Center(
                            child: Text(
                              "Call me",
                              style:
                              TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    SizedBox(height: 20,)

                  ],
                ),
              ),
            ),
          ),
        )

    );
  }
}
