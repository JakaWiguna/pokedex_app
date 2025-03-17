import 'package:flutter/material.dart';
import 'package:pokedex_app/core/res/media.dart';

class PokemonDetailDottedDecoration extends StatelessWidget {
  const PokemonDetailDottedDecoration({
    required this.screenWidth,
    required this.screenHeight,
    required this.isPortrait,
    required this.slidePosition,
    super.key,
  });

  final double screenWidth;
  final double screenHeight;
  final bool isPortrait;
  final double slidePosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: screenWidth * (isPortrait ? 0.20 : 0.30),
      top: screenHeight * 0.25,
      child: Opacity(
        opacity: 1 - slidePosition,
        child: Image.asset(
          MediaRes.dotted,
          width: 50,
          height: 50,
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
