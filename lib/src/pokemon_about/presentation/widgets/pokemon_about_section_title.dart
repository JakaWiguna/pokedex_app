import 'package:flutter/material.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_colors.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_dimensions.dart';

class PokemonAboutSectionTitle extends StatelessWidget {
  const PokemonAboutSectionTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: PokemonAboutDimensions.sectionTitleFontSize,
          fontWeight: FontWeight.bold,
          color: PokemonAboutColors.titleColor,
        ),
      ),
    );
  }
}
