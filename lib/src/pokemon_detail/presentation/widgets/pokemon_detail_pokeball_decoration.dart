import 'package:flutter/material.dart';
import 'package:pokedex_app/core/res/media.dart';

class PokemonDetailPokeballDecoration extends StatelessWidget {
  const PokemonDetailPokeballDecoration({
    required this.screenHeight,
    required this.isPortrait,
    required this.slidePosition,
    super.key,
  });

  final double screenHeight;
  final bool isPortrait;
  final double slidePosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * (isPortrait ? 0.26 : 0.05),
      right: (isPortrait ? -15 : screenHeight / 2 + 10),
      child: Opacity(
        opacity: 1 - slidePosition,
        child: Image.asset(
          MediaRes.pokeball,
          width: 180,
          height: 180,
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
