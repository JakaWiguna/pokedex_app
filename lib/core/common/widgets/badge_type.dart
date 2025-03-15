import 'package:flutter/material.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/utils/constants.dart';

class BadgeType extends StatelessWidget {
  const BadgeType({
    required this.type,
    required this.height,
    super.key,
  });

  const BadgeType.circular({
    required this.type,
    required this.height,
    super.key,
  });

  final String type;
  final double height;

  @override
  Widget build(BuildContext context) {
    final pokemonTypeSize = height * 0.075;
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
}
