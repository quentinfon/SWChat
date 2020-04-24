import 'package:flutter/material.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:swchat/widgets/user/apercu_contact.dart';



class DataSearch extends SearchDelegate<String>{

  final User utilisateur;
  DataSearch({this.utilisateur});

  UserData res;

  List<UserData> users;


  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show some result based on the selection
    return ApercuContact(contact: res, userUid: utilisateur.uid );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone searches for something


    return StreamBuilder<List<UserData>>(
      stream: DatabaseService().allUsersData,
      builder: (context, snapshot){

        if(!snapshot.hasData) return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                'Chargement ...',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NunitoSans',
                    letterSpacing: 1,
                    fontSize: 15
                ),
              ),
            ),
          ],
        );

        users = snapshot.data;

        final suggestionList = users.where((u)=>u.nom.toLowerCase().startsWith(query.toLowerCase())).toList();

        if(query.isEmpty){
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  'Recherchez un contact',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    letterSpacing: 1,
                    fontSize: 15
                  ),
                ),
              ),
            ],
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: (){
              res = suggestionList[index];
              showResults(context);
            },
            leading: Icon(Icons.contacts),
            title: RichText(
              text: TextSpan(
                  text: suggestionList[index].nom.substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  children: [
                    TextSpan(
                        text: suggestionList[index].nom.substring(query.length),
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal
                        )
                    )
                  ]
              ),
            ),
          ),
          itemCount: suggestionList.length,
        );
      }

    );
  }

}