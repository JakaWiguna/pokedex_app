import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon/presentation/common/pokemon_dimensions.dart';

class BadgeType extends StatelessWidget {
  const BadgeType({
    required this.type,
    this.diameter = 0.0,
    this.diameterPadding = 0.0,
    this.height,
    super.key,
  });

  const BadgeType.circular({
    required this.type,
    required this.diameter,
    required this.diameterPadding,
    super.key,
    this.height,
  });

  final String type;
  final double? height;
  final double diameter;
  final double diameterPadding;

  @override
  Widget build(BuildContext context) {
    if (diameter == 0.0) {
      final pokemonTypeSize = height == null
          ? 12.0
          : (height! * PokemonDimensions.cardTypeTextSize);
      final textTheme = Theme.of(context).textTheme;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppSpacing.m),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s,
            vertical: AppSpacing.xs,
          ),
          child: Text(
            type.capitalize(),
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium
                ?.copyWith(color: Colors.white, fontSize: pokemonTypeSize),
          ),
        ),
      );
    }
    return _CircularBadge(
      type: type,
      diameter: diameter,
      diameterPadding: diameterPadding,
    );
  }
}

class _CircularBadge extends StatelessWidget {
  const _CircularBadge({
    required this.type,
    required this.diameter,
    required this.diameterPadding,
  });

  final String type;
  final double diameter;
  final double diameterPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        color: type.pokemonColor.primary,
        borderRadius: BorderRadius.circular(diameter),
      ),
      child: Padding(
        padding: EdgeInsets.all(diameterPadding),
        child: SizedBox(
          child: SvgPicture.asset('icons/$type.svg'.asset()),
        ),
      ),
    );
  }
}
