import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MySlidable extends StatefulWidget {
  final Function onTap;
  final Widget child;

  MySlidable({this.onTap, this.child});

  @override
  State<StatefulWidget> createState() => _MySlidableState();

}

class _MySlidableState extends State<MySlidable>{
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          foregroundColor: Colors.red,
          onTap: () => widget.onTap,
        )
      ],
      child: widget.child,
    );
  }
}