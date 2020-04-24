import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/home/chat_list.dart';
import 'package:swchat/widgets/home/favorite_contact.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    UserData data = Provider.of<UserData>(context);

    return data == null ? Loading() : Column(
      children: <Widget>[
        Container(
          height: 20,
          color: Theme.of(context).primaryColor,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: <Widget>[
                FavoriteContacts(data: data),
                ChatList(data: data),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
