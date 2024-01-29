import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/screens/launch/launch_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/theme.dart';
import 'package:project/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions;

  // Check the platform and assign the correct Firebase options
  if (Platform.isAndroid) {
    firebaseOptions = const FirebaseOptions(
      apiKey: "AIzaSyBJ5dgytUJXtZo4qXm4Knc6j2Q_9yRvhYo", // Use Android apiKey
      appId: "1:1002141291798:android:11be0028fed83f483e6c37", // Use Android appId
      messagingSenderId: "1002141291798", // Use Android messagingSenderId
      projectId: "ajnakafu-330fa", // Your project ID
      storageBucket: "ajnakafu-330fa.appspot.com", // Your storage bucket
    );
  } else if (Platform.isIOS) {
    firebaseOptions = const FirebaseOptions(
      apiKey: "your-ios-apiKey", // Replace with your iOS apiKey
      appId: "1:1002141291798:ios:c1ecf05c52a43b753e6c37", // Use iOS appId
      messagingSenderId: "1002141291798", // Use iOS messagingSenderId
      projectId: "ajnakafu-330fa", // Your project ID
      storageBucket: "ajnakafu-330fa.appspot.com", // Your storage bucket
      iosBundleId: "com.example.project", // Your iOS Bundle ID
    );
  } else {
    throw UnsupportedError("This platform is not supported");
  }

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
