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
    final imageSize = isPortrait ? 200.0 : 150.0;
    return Positioned(
      top: screenHeight / 2 * (isPortrait ? 0.50 : 0.10),
      left: screenWidth / 2 - (imageSize / 2),
      child: Opacity(
        opacity: (1 - slidePosition * 2).clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, (isPortrait ? -imageSize : -20) * slidePosition),
          child: CachedNetworkImage(
            imageUrl: pokemon.id.thumbnailUrl,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
