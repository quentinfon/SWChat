import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swchat/main.dart';


class ColorSelector extends StatelessWidget {

  final String couleur;
  final MyAppSettings settings;
  ColorSelector({this.couleur, this.settings});

  Color getColor(String stringCouleur){

    if(stringCouleur == "rouge") return Colors.red;
    if(stringCouleur == "bleu") return Colors.blue;
    if(stringCouleur == "vert") return Colors.green;
    if(stringCouleur == "bleufonce") return Colors.indigo[900];
    if(stringCouleur == "violet") return Colors.purple;
    if(stringCouleur == "noir") return Colors.black;

    return Colors.red;
  }


  @override
  Widget build(BuildContext context) {

    bool selected = false;

    return PreferenceBuilder(
      preference: settings.couleur,
      builder: (BuildContext context, String c) {

        if(c == couleur) selected = true;

        return GestureDetector(
          onTap: (){
            print(couleur);
            settings.couleur.setValue(couleur);
          },
          child: Container(
            margin: EdgeInsets.all(15),
            height: 75,
            width: 75,
            color: getColor(couleur),
            child: selected ? Icon(
              Icons.check,
              color: Colors.white,
              size: 70,
            ) : SizedBox(),
          ),
        );
      }
    );

  }
}
