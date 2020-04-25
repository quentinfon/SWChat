import 'package:flutter/material.dart';
import 'package:swchat/main.dart';
import 'package:swchat/widgets/color_selector.dart';


class ParametreScreen extends StatefulWidget {

  final MyAppSettings settings;
  ParametreScreen(this.settings);

  @override
  _ParametreScreenState createState() => _ParametreScreenState();
}

class _ParametreScreenState extends State<ParametreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(
            fontFamily: 'NunitoSans',
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  "Couleur de l'application",
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    ColorSelector(couleur: 'rouge', settings: widget.settings),
                    ColorSelector(couleur: 'bleu', settings: widget.settings),
                    ColorSelector(couleur: 'vert', settings: widget.settings),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ColorSelector(couleur: 'violet', settings: widget.settings),
                    ColorSelector(couleur: 'bleufonce', settings: widget.settings),
                    ColorSelector(couleur: 'noir', settings: widget.settings),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
