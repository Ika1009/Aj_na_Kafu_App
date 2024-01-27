import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/screens/onboard/onboard_screen.dart';
import 'package:project/theme.dart';
import 'package:project/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions;
  firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyBJ5dgytUJXtZo4qXm4Knc6j2Q_9yRvhYo", // API key
    appId: "1:1002141291798:android:11be0028fed83f483e6c37", // App ID
    messagingSenderId: "1002141291798", // Messaging Sender ID
    projectId: "ajnakafu-330fa", // Project ID
    storageBucket: "ajnakafu-330fa.appspot.com", // Storage Bucket (optional)
  );

  // Initialize Firebase with the platform-specific options
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
      initialRoute: OnBoardScreen.routeName,
      routes: routes,
    );
  }
}
