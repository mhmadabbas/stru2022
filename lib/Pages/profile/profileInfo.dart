import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:convert' as convert;


import 'package:http/http.dart' as http;
import 'package:stru2022/Model/ProfileInfo.dart';




import '../../Vars/globalss.dart' as globalss;
import '../home.dart';
import 'changpassword.dart';
import 'editprofile.dart';



class profileInfoP extends StatefulWidget {
  const profileInfoP({Key? key}) : super(key: key);

  @override
  _profileInfoPState createState() => _profileInfoPState();
}

class _profileInfoPState extends State<profileInfoP> {


  Future<ProfileInfo> getProfileInfo() async {
    print(context.locale);

    String Url = 'https://studyinrussia.app/api/profile/get';
    var response = await http.get(
      Uri.parse(Url),
        headers: {"Authorization": "bearer "+globalss.tokenfromserver}
    );
    ProfileInfo profileInfoFromJson(String str) => ProfileInfo.fromJson(convert.json.decode(response.body));



    final profileInfo = profileInfoFromJson(response.body);

   // print(profileInfo.user.firstName);
    return profileInfo;

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
 //resizeToAvoidBottomInset: true,
     // appBar: AppBar(
     //   // elevation: 0,
     //   // backgroundColor: Colors.transparent,
     //     automaticallyImplyLeading: false
     // ),
      extendBodyBehindAppBar: true,
        body: SafeArea(

          child: FutureBuilder(
          future:getProfileInfo(),
          builder: (context,AsyncSnapshot snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return Center(child: CircularProgressIndicator(),);
                }
              case ConnectionState.done:
                if (snapshot.hasData) {

                  return  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,

                    children: [

                      SizedBox(
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
                                  child: CachedNetworkImage(
                                    width:MediaQuery.of(context).size.width * (100/375) ,
                                    height: MediaQuery.of(context).size.width * (100/375) ,

                                    fit: BoxFit.cover,

                                    imageUrl: globalss.UrlImageposts +
                                        snapshot.data.user.image.toString(),
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
                                            MaterialPageRoute(builder: (context) => HomeLand()));
                                      },
                                    ),
                                  ],
                                ))

                          ],
                        ),
                      ),



                   // SizedBox(height: MediaQuery.of(context).size.width*(18/100), ),

Expanded(
    child: Column(
  children: [
    Flexible(
      flex:8,
      child: Padding(
        padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * (15/375) ,right: MediaQuery.of(context).size.width * (15/375),top: MediaQuery.of(context).size.width * (15/375) ),
        child:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  SizedBox(height: 20,),

            SizedBox(
            width: MediaQuery.of(context).size.width * (350/375),
            child: Row(
              children: [
                Icon(Icons.person, size: MediaQuery.of(context).size.width * (25/375),color: Theme.of(context).textTheme.headline1!.color,),
                SizedBox(width: MediaQuery.of(context).size.width * (310/375),
                    child: Text(("  "+(snapshot.data.user.firstName.toString()?? "")+" "+(snapshot.data.user.lastName?.toString()?? "")),style: TextStyle(fontSize: MediaQuery.of(context).size.width * (14/375),fontWeight: FontWeight.bold),))
              ],
            ),
            ),
            Divider(),
            SizedBox(
            width: MediaQuery.of(context).size.width * (350/375),
            child: Row(
              children: [
                Icon(Icons.email, size: MediaQuery.of(context).size.width * (25/375),color: Theme.of(context).textTheme.headline1!.color,),
                SizedBox(
                    width: MediaQuery.of(context).size.width * (310/375),
                    child: Text("  "+(snapshot.data.user.email?.toString()?? ""),style: TextStyle(fontSize: MediaQuery.of(context).size.width * (14/375),fontWeight: FontWeight.bold),))
              ],
            ),
            ),
            Divider(),
            SizedBox(
            width: MediaQuery.of(context).size.width * (350/375),
            child: Row(
              children: [
                Icon(Icons.local_phone_outlined, size: MediaQuery.of(context).size.width * (25/375),color: Theme.of(context).textTheme.headline1!.color,),
                SizedBox(
                    width: MediaQuery.of(context).size.width * (310/375),
                    child: Text("  "+(snapshot.data.user.mobile?.toString() ?? ""),style: TextStyle(fontSize: MediaQuery.of(context).size.width * (14/375),fontWeight: FontWeight.bold),))
              ],
            ),
            ),
            Divider(),
            SizedBox(
            width: MediaQuery.of(context).size.width * (350/375),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.whatsapp,size: MediaQuery.of(context).size.width * (25/375),color:Theme.of(context).textTheme.headline1!.color ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * (310/375),
                    child: Text("  "+(snapshot.data.user.whatsapp?.toString() ?? ""),style: TextStyle(fontSize: MediaQuery.of(context).size.width * (14/375),fontWeight: FontWeight.bold),maxLines: 3,))
              ],
            ),
            ),
            Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width * (350/375),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.globe,size: MediaQuery.of(context).size.width * (25/375),color:Theme.of(context).textTheme.headline1!.color ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * (310/375),
                      child: Text("  "+(snapshot.data.user.country?.toString() ?? "") ,style: TextStyle(fontSize: MediaQuery.of(context).size.width * (14/375),fontWeight: FontWeight.bold),maxLines: 3,))
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width * (350/375),
              child: Row(
                children: [


                FaIcon(FontAwesomeIcons.female,size: MediaQuery.of(context).size.width * (19/375),color:Theme.of(context).textTheme.headline1!.color ),
                  FaIcon(FontAwesomeIcons.male,size: MediaQuery.of(context).size.width * (19/375),color:Theme.of(context).textTheme.headline1!.color ),

                  SizedBox(
                      width: MediaQuery.of(context).size.width * (310/375),
                      child:
                      Text("  "+(
                          (snapshot.data.user.gender?.toString() == "0")? "profile.Male".tr() :
                          (snapshot.data.user.gender?.toString() == "1")? "profile.Female".tr() :
                          (snapshot.data.user.gender?.toString() == "2")? "profile.Other".tr() :
                          (snapshot.data.user.gender?.toString() == "3")? "profile.I prefer not to say".tr() :
                              " "
                      ) ,

                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * (14/375),fontWeight: FontWeight.bold),maxLines: 3,))
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width * (350/375),
              child: Row(
                children: [


                  FaIcon(FontAwesomeIcons.birthdayCake,size: MediaQuery.of(context).size.width * (25/375),color:Theme.of(context).textTheme.headline1!.color ),

                  SizedBox(
                      width: MediaQuery.of(context).size.width * (310/375),
                      child: Text("  "+(snapshot.data.user.birthdate?.toString() ?? "") ,style: TextStyle(fontSize: MediaQuery.of(context).size.width * (14/375),fontWeight: FontWeight.bold),maxLines: 3,))
                ],
              ),
            ),




          ],
        ),
      ),
    ),
    Flexible(
flex: 1,
      child: Padding(
        padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * (15/375) ,right: MediaQuery.of(context).size.width * (15/375),bottom: MediaQuery.of(context).size.width * (10/375)  ),

        child: SizedBox(
          height: MediaQuery.of(context).size.width*(30/375),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Flexible(
              flex: 2,
              child: ElevatedButton(onPressed: () {
                Map<String, dynamic> xxxx={
                  "firstName": snapshot.data.user.firstName,
                  "lastName": snapshot.data.user.lastName,
                  "mobile": snapshot.data.user.mobile,
                  "whatsapp": snapshot.data.user.whatsapp,
                  "imageurll":snapshot.data.user.image,
                  "gender":snapshot.data.user.gender,
                  "country":snapshot.data.user.country,




                };

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Editprofile(pp: xxxx)));
              },
                child:  SizedBox(
                    width:
                    MediaQuery.of(context).size.width / 2.7,
                    child: Center(child: Text("profile.edit".tr()))),

                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2429F9),//change background color of button
                  // onPrimary: Colors.yellow,//change text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,

                ),


              ),
            ),

            Flexible(
              flex: 2,
              child: ElevatedButton(onPressed: () {
                Map<String, dynamic> xxxx={
                  "firstName": snapshot.data.user.firstName,
                  "lastName": snapshot.data.user.lastName,
                  "mobile": snapshot.data.user.mobile,
                  "whatsapp": snapshot.data.user.whatsapp

                };

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangPassword()));
              },
                child:  SizedBox(
                    width:
                    MediaQuery.of(context).size.width / 2.7,
                    child: Center(child: Text("profile.change password".tr()))),

                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2429F9),//change background color of button
                  // onPrimary: Colors.yellow,//change text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,

                ),


              ),
            ),

            ],
          ),
        ),
      ),
    ),
  ],
)
),





                 //     SizedBox(height: MediaQuery.of(context).size.height*(18/100), ),






                   //   SizedBox(height: 20,),


                    ],
                  );


                }
            }
            return Center(child: CircularProgressIndicator(),);


          },
      ),
        ),
    );
  }
}
