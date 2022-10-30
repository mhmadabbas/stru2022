import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Pages/Notifications/notificationsList.dart';
import '/Vars/globalss.dart' as globalss ;
class appbarnonimage extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
     // iconTheme: IconThemeData(color: Colors.white),

      // leading: IconButton(
      //   onPressed: (){},
      //   icon: Icon(Icons.menu,color: Colors.amberAccent),
      // ),

      actions: <Widget>[Container()],
      centerTitle: true,


      flexibleSpace: Container(


     //   color:Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
      //    crossAxisAlignment: CrossAxisAlignment.end,


          children: [
            IconButton(
              onPressed: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => notificationslist0()));
              },
              icon:SvgPicture.asset(
                'assets/svgicon/ringicon.svg',

                width: 25,
                //     color: Colors.black.withOpacity(0.3),
                fit: BoxFit.contain,

              ), color: globalss.cblue,),
            CircleAvatar(
              child: CachedNetworkImage(
                width:MediaQuery.of(context).size.width * (100/375) ,
                height: MediaQuery.of(context).size.width * (100/375) ,

                fit: BoxFit.cover,

                imageUrl: globalss.UrlImageposts +
                    globalss.profileimage,
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

              radius: 20,),



          IconButton(onPressed: (){ Scaffold.of(context).openEndDrawer();}, icon: Icon(Icons.menu,color:Colors.white,size: 35,)),



            // Row(
            //   children: [
            //
            //
            //   ],
            // )



          ],
        ),
      ),
      backgroundColor: Colors.transparent,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}








// import 'package:flutter/material.dart';
// import 'package:studyinrussia/Pages/searchePage.dart';
//
// class ApplicationToolbarnonimage extends StatelessWidget with PreferredSizeWidget{
//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//
//       preferredSize: Size.fromHeight(75.0),
//       child: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Color(0xFF170AEA)),
//
//
//         flexibleSpace: Container(
//
//           // decoration:
//           // BoxDecoration(
//           //   boxShadow: [
//           //     BoxShadow(
//           //       spreadRadius: 4,
//           //       color: Colors.black26,
//           //       offset: Offset(0, 0),
//           //       blurRadius: 5,
//           //     )
//           //   ],
//           //   image: DecorationImage(
//           //     image: AssetImage('assets/image/appbar.jpg'),
//           //     fit: BoxFit.fill,
//           //
//           //
//           //   ),
//           // ),
//         ),
//        backgroundColor: Colors.transparent,
//
//
//         leading: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//           children: <Widget>[
//             SizedBox(width: 10,),
//
//             Flexible(
//
//               child: CircleAvatar(
//                 backgroundColor: Color(0xFF170AEA),
//                 child: IconButton (
//                   icon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
//                   onPressed: () {
//                     // Navigator.push(
//                     //     context,MaterialPageRoute(builder: (context)=>SearchPage())
//                     // );
//                   },
//                 ),
//               )
//             ),
//
//           ],
//         ),
//
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(60.0);
// }