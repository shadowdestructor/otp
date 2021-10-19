import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp/pageview/pageview_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Teknopark());
}

class Teknopark extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme:ThemeData(brightness:Brightness.dark),
      title: "Teknopark Task",
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        curve: Curves.bounceIn,
        splashTransition: SplashTransition.scaleTransition,
        nextScreen: Pageviewing(),//HostHome(), //Login(),
        duration: 3,
        animationDuration: Duration(milliseconds: 1800),
        centered: true,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Colors.green.shade700,
        splash: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green.shade400,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                alignment: Alignment.center,
                width: 300,
                height: 72,
                child: Text(
                  "Teknopark",
                  style: GoogleFonts.balooThambi(
                    color: Colors.green.shade400,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}