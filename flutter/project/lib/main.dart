import 'package:flutter/material.dart';
import 'package:project/screens/launch/launch_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/theme.dart';
import 'package:project/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyBJ5dgytUJXtZo4qXm4Knc6j2Q_9yRvhYo",
    appId: "1:1002141291798:android:11be0028fed83f483e6c37", 
    messagingSenderId: "1002141291798", 
    projectId: "ajnakafu-330fa", 
    storageBucket: "ajnakafu-330fa.appspot.com", 
  );

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aj Na Kafu',
      theme: AppTheme.lightTheme(context),
      initialRoute: LaunchScreen.routeName,
      routes: routes,
    );
  }
}
