import 'package:tubes_flutter/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tubes_flutter/screens/home_page.dart';
import 'package:tubes_flutter/screens/anggota_page.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MaindrawState createState() => _MaindrawState();
}

class _MaindrawState extends State<MainDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: !isloggedin
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        "https://www.mudracostumes.in/images/testimonial.jpg",
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      " ${user.displayName} ",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Admin Perpustakaan",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage())),
        leading: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text("Home"),
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AnggotaPage())),
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("Data Anggota"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.book,
          color: Colors.black,
        ),
        title: Text("Data Buku"),
      ),
      ListTile(
        onTap: signOut,
        leading: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        title: Text("Sign Out"),
      ),
    ]);
  }
}
