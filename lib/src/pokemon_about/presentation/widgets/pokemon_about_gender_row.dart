import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_colors.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_dimensions.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_strings.dart';

class PokemonAboutGenderRow extends StatelessWidget {
  const PokemonAboutGenderRow({
    required this.genderRate,
    super.key,
  });

  final int genderRate;

  @override
  Widget build(BuildContext context) {
    final malePercentage = 100 - (genderRate * 12.5);
    final femalePercentage = genderRate * 12.5;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              PokemonAboutStrings.gender,
              style: TextStyle(color: PokemonAboutColors.labelColor),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                _GenderIconWithPercentage(
                  icon: FontAwesomeIcons.mars,
                  color: PokemonAboutColors.maleColor,
                  percentage: malePercentage,
                ),
                const SizedBox(width: AppSpacing.m),
                _GenderIconWithPercentage(
                  icon: FontAwesomeIcons.venus,
                  color: PokemonAboutColors.femaleColor,
                  percentage: femalePercentage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderIconWithPercentage extends StatelessWidget {
  const _GenderIconWithPercentage({
    required this.icon,
    required this.color,
    required this.percentage,
  });

  final IconData icon;
  final Color color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: PokemonAboutDimensions.genderIconSize,
        ),
        const SizedBox(width: PokemonAboutDimensions.genderIconTextPadding),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: PokemonAboutColors.valueColor,
          ),
        ),
      ],
    );
  }
}
