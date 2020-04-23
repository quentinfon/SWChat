import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/screens/home/home_screen.dart';
import 'package:swchat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:swchat/services/dataHolder.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/widgets/home/a_propos.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';
import 'package:swchat/widgets/user/infos_utilisateur.dart';
import 'package:swchat/widgets/user/userMessage.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: APropos(),
        );
      });
    }

    User user = Provider.of<User>(context);

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                child: InfosUtilisateur(),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              ListTile(
                onTap: () => _showSettingsPanel(),
                leading: Icon(Icons.info_outline),
                title: Text(
                  'À propos',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.not_interested,
                  color: Colors.red,
                ),
                title: Text(
                  'Deconnexion',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'NunitoSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),
                ),
                onTap: () async{
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: HomeScreen(),
        ),
      ),
    );
  }
}





