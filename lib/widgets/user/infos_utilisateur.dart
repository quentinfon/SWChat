import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/screens/home/edit_profil.dart';
import 'package:swchat/shared/loading.dart';
import 'package:swchat/widgets/user/ProfilImage.dart';


class InfosUtilisateur extends StatefulWidget {

  @override
  _InfosUtilisateurState createState() => _InfosUtilisateurState();
}

class _InfosUtilisateurState extends State<InfosUtilisateur> {

  UserData utilisateur;

  @override
  Widget build(BuildContext context) {

    utilisateur = Provider.of<UserData>(context);

    return utilisateur == null ? Loading() : Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 150.0,
            width: 150.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: ProfilImage(url: utilisateur.imageUrl),
            ),
          ),
          SizedBox(height: 10),
          Text(
            utilisateur.nom,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'NunitoSans'
            ),
          ),
          SizedBox(height: 10),
          Text(
            utilisateur.bio,
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'NunitoSans',
              color: Colors.blueGrey
            ),
          ),
          SizedBox(height: 10),
          FlatButton.icon(
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (_) => EditProfil(),
                )
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              label: Text(
                'Modifier',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'NunitoSans'
                ),
              )
          ),
          Divider(
            height: 50,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }
}
