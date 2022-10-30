import 'package:flutter/material.dart';


class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return PreferredSize(

      preferredSize: Size.fromHeight(75.0),
      child: AppBar(
        centerTitle: true,

        flexibleSpace: Container(

          decoration:
          BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 4,
                color: Colors.black26,
                offset: Offset(0, 0),
                blurRadius: 5,
              )
            ],
            image: DecorationImage(
              image: AssetImage('assets/image/appbar.jpg'),
              fit: BoxFit.fill,


            ),
          ),
        ),
        backgroundColor: Colors.transparent,

        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[

            Flexible(
              child: IconButton (
                icon: Icon(Icons.search),
                onPressed: () {
// Navigator.push(
//   context,MaterialPageRoute(builder: (context)=>SearchPage())
// );
                },
              ),
            ),



          ],
        ),
        title: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [

                Text("STUDY IN RUSSIA",)

              ],
            )

          ],
        ),






      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75.0);
}