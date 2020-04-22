import 'package:flutter/material.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';

class BulleContact extends StatefulWidget {

  UserData data;
  BulleContact({this.data});


  @override
  _BulleContactState createState() => _BulleContactState();
}

class _BulleContactState extends State<BulleContact> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      child: Column(
        children: <Widget>[
          Container(
            height: 60.0,
            width: 60.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75.0),
              child: ProfilImage(url: widget.data.imageUrl),
            ),
          ),
          SizedBox(height: 7),
          Text(
            widget.data.nom,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
