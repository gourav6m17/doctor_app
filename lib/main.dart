import 'package:my_doctor_app/appBehaviour/my_behaviour.dart';
import 'package:my_doctor_app/pages/screens.dart';
import 'package:my_doctor_app/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_doctor_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'constant/constant.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        //ChangeNotifierProvider(create: (_) => data())
      ],
      child: MaterialApp(
        title: 'MyDoctor User App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Noto Sans',
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: primaryColor,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        home: SplashScreen(),
      ),
    );
  }
}
