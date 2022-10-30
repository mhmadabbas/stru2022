
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stru2022/Pages/introduction/wellcome1.dart';

import '/Pages/auth/login.dart';
import '/Vars/globalss.dart' as globalss;

class wellcomepage3 extends StatefulWidget {
  const wellcomepage3({Key? key}) : super(key: key);

  @override
  State<wellcomepage3> createState() => _wellcomepage3State();
}

class _wellcomepage3State extends State<wellcomepage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SafeArea(
        child: Container(
          height:MediaQuery.of(context).size.height ,
          width:MediaQuery.of(context).size.width ,
          //   color: Colors.amber,
          // height:812 ,
          // width: 100,
          child: Padding(
            padding:EdgeInsets.only(left: 8.0,right: 8,top: 5,bottom: 10),
            child:Stack(
              alignment: Alignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //  mainAxisSize: MainAxisSize.max,
              children: [
                Positioned(
                  top:0,
                  right: 0,
                  left: 0,


                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width *(31/375),

                          width: MediaQuery.of(context).size.width *(102/375),
                          child: Image.asset(
                            'assets/22images/logo22.png',
                            color:Theme.of(context).textTheme.headline1!.color,
                            fit: BoxFit.fill,
                          ),
                        ),
                        TextButton(onPressed: (){}, child: Text("",style: TextStyle(color: Color(0xFF000000).withOpacity(0.3)),))
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      AspectRatio(
                        aspectRatio: 1,

                        child: SizedBox(
                          //  height:900,
                          // //425,
                          // MediaQuery.of(context).size.height/2,
                          child: SvgPicture.asset(
                            'assets/22images/w4.svg',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          CircleAvatar(radius: 5,backgroundColor:Color(0xFFC4C4C4) ),
                          SizedBox(width: 5,height: 30),
                          CircleAvatar(radius: 5,backgroundColor: Color(0xFFC4C4C4)),
                          SizedBox(width: 5,),

                          CircleAvatar(radius: 5,backgroundColor:globalss.cblue ),
                        ],
                      ),
                      SizedBox(
                   //     width:MediaQuery.of(context).size.width-40,
                        width:MediaQuery.of(context).size.width-40,
                        height:MediaQuery.of(context).size.height*(20/100) ,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text("intro.Forum, the excellent venue".tr()+"\n"+ "intro.for study discussion and".tr()+"\n"+"intro.social interaction".tr(),style: TextStyle(fontWeight: FontWeight.w600,color:Theme.of(context).textTheme.bodyText1!.color,), textAlign: TextAlign.center,)),
                      ),

                      SizedBox(
                          width:MediaQuery.of(context).size.width-40,
                          child: Text("intro.Forum, the outstanding and designated space created with the intention for you to join, share and post the brilliant ideas in your mind to interact with each other".tr(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Color(0xFF8D8D8D)), textAlign: TextAlign.center,)),
                      SizedBox(height:140,)

                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width-40,

                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          primary: Color(0xFF002BFF)

                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child:  Text("intro.Get started!".tr(),style: TextStyle(color:Colors.white),),
                    ),
                  ),
                ),
                // SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
