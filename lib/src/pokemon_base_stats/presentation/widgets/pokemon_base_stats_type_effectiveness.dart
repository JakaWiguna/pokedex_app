import 'package:flutter/material.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/res/color.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/common/pokemon_base_stats_strings.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/widgets/pokemon_base_stats_types_list.dart';

class PokemonBaseStatsTypeEffectiveness extends StatelessWidget {
  const PokemonBaseStatsTypeEffectiveness({
    required this.stats,
    super.key,
  });

  final PokemonBaseStatsEntity stats;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sectionTheme = textTheme.titleMedium?.copyWith(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    final multipliers = stats.multipliers.toList();
    final hasImmune = multipliers.any((element) => element.second == 0.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(PokemonBaseStatsStrings.typeEffectiveness, style: sectionTheme),
        const SizedBox(height: AppSpacing.m),
        Text(
          '${PokemonBaseStatsStrings.typeEffectivenessOnType} ${stats.pokemon.name.capitalize()}',
          style: textTheme.bodyLarge
              ?.copyWith(color: ColorRes.textGrey, fontSize: 14),
        ),
        const SizedBox(height: AppSpacing.m),
        PokemonBaseStatsTypesList(
          defenses: stats.multipliers.toList(),
        ),
        if (hasImmune) ...{
          Text(
            PokemonBaseStatsStrings.immune,
            style: textTheme.labelSmall?.copyWith(color: ColorRes.textGrey),
          ),
          const SizedBox(height: AppSpacing.m),
        },
      ],
    );
  }
}
