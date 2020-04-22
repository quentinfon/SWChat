import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';

class UserMessageItem extends StatefulWidget {
  @override
  _UserMessageItemState createState() => _UserMessageItemState();
}

class _UserMessageItemState extends State<UserMessageItem> {
  @override

  Widget build(BuildContext context) {

    UserData data = Provider.of<UserData>(context);

    if(data == null){
      return Loading();
    }else{
      return Container(
        child: Column(
          children: <Widget>[
            ProfilImage(url: data.imageUrl),
            Text(data.uid),
            Text(data.bio),
          ],
        ),
      );
    }

  }
}
