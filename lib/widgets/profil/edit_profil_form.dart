import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';


class EditProfilForm extends StatefulWidget {

  final String userUid;
  EditProfilForm({this.userUid});


  @override
  _EditProfilFormState createState() => _EditProfilFormState();
}

class _EditProfilFormState extends State<EditProfilForm> {


  UserData userData;

  bool loading = false;

  //Text fields
  String nom = '';
  String bio = '';

  var nomController = TextEditingController();
  var bioController = TextEditingController();


  setUserData () async{
    UserData data = await DatabaseService(uid: widget.userUid).getUserData();

    setState(() {
      userData = data;
    });

    nomController.text = data.nom;
    bioController.text = data.bio;
  }


  @override
  void initState(){
    super.initState();
    setUserData();
  }

  @override
  Widget build(BuildContext context) {

    return userData == null ? Loading() : Container(

      child: SingleChildScrollView(
        child: Column(

          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 200.0,
              width: 200.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: ProfilImage(url: userData.imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Nom',
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueGrey
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 75),
              child: TextField(
                controller: nomController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (val) {
                  nom = val;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nom',
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(fontFamily: 'NunitoSans'),
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Biographie',
                style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                textAlign: TextAlign.center,
                controller: bioController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (val) {
                  bio = val;
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Biographie',
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(fontFamily: 'NunitoSans'),
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            FlatButton.icon(
              color: Theme.of(context).primaryColor,
              onPressed: (){},
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: Text(
                'Enregistrer',
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
            )
          ],
        ),
      ),

    );

  }
}
