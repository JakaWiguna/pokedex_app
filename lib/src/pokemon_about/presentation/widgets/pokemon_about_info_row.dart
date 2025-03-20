import 'package:flutter/material.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_colors.dart';

class PokemonAboutInfoRow extends StatelessWidget {
  const PokemonAboutInfoRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: PokemonAboutColors.labelColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: PokemonAboutColors.valueColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
