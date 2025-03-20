import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/extensions/int_extension.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/common/pokemon_detail_colors.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_type_badge.dart';

class PokemonDetailPokemonInfo extends StatelessWidget {
  const PokemonDetailPokemonInfo({
    required this.screenWidth,
    required this.screenHeight,
    required this.appBarHeight,
    required this.isPortrait,
    required this.pokemon,
    required this.slidePosition,
    super.key,
  });

  final double screenWidth;
  final double screenHeight;
  final double appBarHeight;
  final bool isPortrait;
  final Pokemon pokemon;
  final double slidePosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (screenHeight / 2) * 0.20 + (isPortrait ? 10 : appBarHeight),
      left: AppSpacing.l,
      right: AppSpacing.l,
      child: Opacity(
        opacity: 1 - slidePosition,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Transform.translate(
                offset: Offset(0, -20 * slidePosition),
                child: Text(
                  pokemon.id.pokenumber,
                  style: const TextStyle(
                    color: PokemonDetailColors.pokemonIdColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -20 * slidePosition),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...pokemon.types.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(
                        right: AppSpacing.s,
                      ),
                      child: PokemonDetailTypeBadge(
                        type: e.type.name.capitalize(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
