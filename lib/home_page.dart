import 'package:flutter/material.dart';
import 'maindrawer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SwiperController _swiperController;
  double prevOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    List<Widget> swiperItemsList = [
      buildSwiperItem(
          "https://images.vexels.com/media/users/3/137291/isolated/preview/a97dc74de5e10e10383ab790d5c36927-hand-hello-gesture-fingers-icon-by-vexels.png",
          "Hai Admin  , Selamat Bekerja! Swipe untuk melihat apa pekerjaanmu!",
          Color(0xFFfba457),
          firstGradient,
          "PERPUSTAKAAN "),
      buildSwiperItem(
          "https://th.bing.com/th/id/R9144787a13d82520566564a35d44bc14?rik=VdN0Ahze%2bueX%2bQ&riu=http%3a%2f%2fwww.icone-png.com%2fpng%2f48%2f48147.png&ehk=NdobyHbtKNUi2zBrT5vn2euO5cJtW9hR8AmoMT20MkI%3d&risl=&pid=ImgRaw",
          "Hai Admin , Kamu harus mencatat data anggota dan melakukan create update edit delete sesuai kebutuhan",
          Color(0xFFffcc00),
          secondtGradient,
          "ANGGOTA"),
      buildSwiperItem(
          "https://maxcdn.icons8.com/Share/icon/nolan/User_Interface/user_manual1600.png",
          "Hai Admin , Pekerjaan selanjutnya kamu harus mencatat data buku dan melakukan create update edit delete sesuai kebutuhan",
          Color(0xFFffcc00),
          firstGradient,
          "BUKU"),
      buildSwiperItem(
          "https://image.flaticon.com/icons/png/512/1910/1910022.png",
          "Terima Kasih Admin , Selamat Bekerja ",
          Color(0xFFffcc00),
          secondtGradient,
          "THANK YOU"),
    ];
    return new Scaffold(
      appBar: AppBar(
        title: Text("Admin Perpustakaan"),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Expanded(
              flex: 6,
              child: Swiper(
                controller: _swiperController,
                itemCount: swiperItemsList.length,
                onIndexChanged: (int value) {
                  if (value == 2) {
                    setState(() {
                      prevOpacity = 0.0;
                    });
                  } else {
                    setState(() {
                      prevOpacity = 1.0;
                    });
                  }
                },
                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: MediaQuery.of(context).size.height / 1.5,
                itemBuilder: (BuildContext context, index) {
                  return swiperItemsList[index];
                },
                layout: SwiperLayout.TINDER,
                curve: Curves.bounceOut,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwiperItem(String image, String text, Color color,
      Gradient gradient, String endText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.8),
            blurRadius: 4,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: gradient,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 8),
                        )
                      ]),
                ),
                Image.network(
                  image,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.3,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              endText,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black12,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const firstGradient = LinearGradient(
  colors: [
    Color(0xFFfc792c),
    Color(0xFFfba457),
  ],
);

const secondtGradient = LinearGradient(
  colors: [
    Color(0xFFfeb700),
    Color(0xFFffcc00),
  ],
);
