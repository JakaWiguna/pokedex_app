import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/extensions/int_extension.dart';

class PokemonDetailPokemonImage extends StatelessWidget {
  const PokemonDetailPokemonImage({
    required this.screenWidth,
    required this.screenHeight,
    required this.isPortrait,
    required this.pokemon,
    required this.slidePosition,
    super.key,
  });

  final double screenWidth;
  final double screenHeight;
  final bool isPortrait;
  final Pokemon pokemon;
  final double slidePosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight / 2 * (isPortrait ? 0.50 : 0.10),
      left: screenWidth / 2 - (200 / 2),
      child: Opacity(
        opacity: (1 - slidePosition * 2).clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, (isPortrait ? -200 : -20) * slidePosition),
          child: CachedNetworkImage(
            imageUrl: pokemon.id.thumbnailUrl,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
