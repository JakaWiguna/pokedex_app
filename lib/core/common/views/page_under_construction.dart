import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/core/res/media.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            height: 200,
            child: Lottie.asset(MediaRes.pageUnderConstruction),
          ),
        ),
      ),
    );
  }
}
