import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokedex_app/core/res/media.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
    this.color = Colors.black,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 32,
        height: 32,
        child: Image.asset(
          MediaRes.pokeball,
          color: color,
        ),
      ),
    )
        .animate()
        .fade()
        .scale()
        .then()
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .rotate(duration: const Duration(seconds: 1))
        .then();
  }
}
