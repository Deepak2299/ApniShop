import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fetchForProducts(context: context);
    fetchForCart(context: context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent
       ),
      child: Center(
        child: DefaultTextStyle(
          style: GoogleFonts.dancingScript(textStyle:
          
            TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            color: Colors.black,

          ),
          
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('Apni Shop'),
            ],
            onFinished: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
            // totalRepeatCount: 3,
           pause: const Duration(milliseconds: 800),
          ),
        ),
      ),
    );
  }
}
