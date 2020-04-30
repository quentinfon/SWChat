import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swchat/firebase_notification_handler.dart';
import 'package:swchat/models/user.dart';
import 'package:swchat/screens/wrapper.dart';
import 'package:swchat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await StreamingSharedPreferences.instance;
  final settings = MyAppSettings(preferences);

  runApp(MyApp(settings));
}

class MyApp extends StatefulWidget {

  final MyAppSettings settings;
  MyApp(this.settings);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    new FirebaseNotifications().setUpFirebase();
  }

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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: PreferenceBuilder(
        preference: widget.settings.couleur,
        builder: (BuildContext context, String couleur){
          return MaterialApp(
            title: 'SWChat',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: getColor(couleur),
                accentColor: Color(0xFFFEF9EB)
            ),
            home: Wrapper(widget.settings),
          );
        },
      ),
    );
  }
}

class MyAppSettings {
  MyAppSettings(StreamingSharedPreferences preferences)
      : couleur = preferences.getString('couleur', defaultValue: 'rouge');

  final Preference<String> couleur;

}