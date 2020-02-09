import 'package:flutter/material.dart';


class MyAppBar extends StatefulWidget {
  final Widget flexibleSpaceChild;
  final Widget appBarBottom;

  MyAppBar({
   this.flexibleSpaceChild ,
    this.appBarBottom
  });

  @override
  State<StatefulWidget> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar>{
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        elevation: 5.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0))),
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              widget.flexibleSpaceChild ?? Container()
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromWidth(double.infinity),
          child: widget.appBarBottom ?? Container(),
        )
    );
  }
}