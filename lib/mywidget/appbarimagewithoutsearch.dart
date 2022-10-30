import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Pages/Notifications/notificationsList.dart';
import '/Vars/globalss.dart' as globalss ;
class ApplicationToolbarnosearch extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[Container()],
      centerTitle: true,

      flexibleSpace: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,


          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width *(35/375),
            child:Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Center(
                child:
                SizedBox(
                  height: MediaQuery.of(context).size.width *(31/375),

                  width: MediaQuery.of(context).size.width *(102/375),
                  child: Image.asset(
                    'assets/22images/logo22.png',
                    color:Theme.of(context).textTheme.headline1!.color,
                    fit: BoxFit.fill,
                  ),
                ),

              ),
            ),
            ),

            Center(
              child: Row(
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
                  CircleAvatar(child:

                  CachedNetworkImage(
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


                  IconButton(onPressed: (){ Scaffold.of(context).openEndDrawer();}, icon: Icon(Icons.menu,color:Theme.of(context).textTheme.headline1!.color,size: 30,)),



                ],
              ),
            )



          ],
        ),
      ),
      backgroundColor: Colors.white,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}