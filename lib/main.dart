import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tubes_flutter/providers/provider_book.dart';
import 'package:tubes_flutter/services/sign_up.dart';
import 'screens/home_page.dart';
import 'services/login.dart';
import 'screens/login_page.dart';
import 'package:provider/provider.dart';
import 'services/firestore_service.dart';
import 'package:tubes_flutter/providers/provider_anggota.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // get firestoreService => null;

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnggotaProvider()),
        StreamProvider(
          create: (context) => firestoreService.getAnggota(),
          //  initialData: initialData,
        ),
        ChangeNotifierProvider(create: (context) => AnggotaProvider()),
        StreamProvider(
          create: (context) => firestoreService.getBook(),
          //  initialData: initialData,
        ),
        ChangeNotifierProvider(create: (context) => BookProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.orange),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          "Login": (BuildContext context) => Login(),
          "SignUp": (BuildContext context) => SignUp(),
          "start": (BuildContext context) => LoginPage(),
        },
      ),
    );
  }
}
