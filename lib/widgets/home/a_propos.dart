import 'package:flutter/material.dart';


class APropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Text(
            'SWChat',
            style: TextStyle(
              fontSize: 25,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'NunitoSans'
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Application réalisé par Quentin Fontaine',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
              fontFamily: 'NunitoSans'
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Contact :',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontFamily: 'NunitoSans'
            ),
          ),
          SizedBox(height: 5),
          Text(
            'mail : qfon.dev@gmail.com',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[900],
              fontWeight: FontWeight.w600,
              fontFamily: 'NunitoSans'
            ),
          ),
          SizedBox(height: 5),
          Text(
            'linkedin : quentinfon',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[900],
              fontWeight: FontWeight.w600,
              fontFamily: 'NunitoSans'
            ),
          ),
        ],
      ),
    );
  }
}
