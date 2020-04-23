import 'package:swchat/services/auth.dart';
import 'package:swchat/shared/constants.dart';
import 'package:swchat/shared/loading.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text fields
  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          'Connexion',
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Inscription',
              style: TextStyle(
                fontFamily: 'NunitoSans',
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Entrez un email' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val.length < 6 ? 'Le mot de passe doit faire au moins 6 caractères' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Mot de passe'),
                  onChanged: (val){
                    setState(() => password = val);
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Connexion',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){

                      setState(() => loading = true);

                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                      if(result == null){
                        setState(() {
                          error = 'Mauvais identifiants';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
