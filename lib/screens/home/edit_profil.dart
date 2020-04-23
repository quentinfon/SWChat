import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/auth.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/profil/edit_profil_form.dart';

class EditProfil extends StatefulWidget {

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {

  final AuthService _auth = AuthService();

  User user;


  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Profil',
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: StreamBuilder<User>(
            stream: AuthService().user,

              builder: (context, snap) {

                if(snap.hasData){
                  user = snap.data;
                }

                return user == null ? Loading() : EditProfilForm(userUid: user.uid);

              }
          ),
        ),
      );
  }

}
