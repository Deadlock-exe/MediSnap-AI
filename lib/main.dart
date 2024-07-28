import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medisnap/auth/login_page.dart';
import 'package:medisnap/constants/routes.dart';
import 'package:medisnap/firebase_options.dart';
import 'package:medisnap/pages/main_page.dart';
import 'package:medisnap/provider/auth_provider.dart';
import 'package:medisnap/provider/chat_provider.dart';
import 'package:medisnap/provider/image_provider.dart';
import 'package:medisnap/provider/nav_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('chat_sessions');
  runApp(MyApp());
}

void setPersistence() async {
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => MyChatProvider()),
        ChangeNotifierProvider(create: (_) => MyImageProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthCheck(),
        routes: routes,
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.user == null) {
          return LoginPage();
        } else {
          return MainPage();
        }
      },
    );
  }
}
