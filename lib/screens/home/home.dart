import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/screens/home/home_screen.dart';
import 'package:swchat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:swchat/services/dataHolder.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';
import 'package:swchat/widgets/user/userMessage.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: (){

            },
          ),
          title: Text(
            'Chats',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              iconSize: 30,
            ),
          ],
        ),
        body: Container(
          child: HomeScreen(),
        ),
      ),
    );
  }
}





