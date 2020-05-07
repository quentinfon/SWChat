import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swchat/main.dart';
import 'package:swchat/shared/constants.dart';


class ColorSelector extends StatelessWidget {

  final String couleur;
  final MyAppSettings settings;
  ColorSelector({this.couleur, this.settings});


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
